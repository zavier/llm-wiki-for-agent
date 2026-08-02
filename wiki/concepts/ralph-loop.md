---
type: concept
tags: [ai-agents, loop, memory, long-running, stateless]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [long-running-agents, file-as-memory, agent-verification, agents-md, harness-engineering, self-reflection, loop-engineering, agent-management]
sources: [2026-03-26-code-agent-orchestra, 2026-01-31-self-improving-agents]
status: active
---

# Ralph Loop

无状态但迭代的代理循环:"shipping while you sleep"背后的模式——把开发拆成小的原子任务,代理每轮 Pick→Implement→Validate→Commit→Update→Reset,以外部记忆维持连续性;Geoffrey Huntley 与 Ryan Carson 推广(工具:snarktank/ralph;Compound Product 在其上叠复合循环;Antfarm 叠多代理编排)。

## 关键信息

**六步循环**(来源: [[2026-01-31-self-improving-agents]],Osmani 加详版;[[2026-03-26-code-agent-orchestra|演讲版]]为五步)

1. **Pick** — 从 `tasks.json`/`prd.json` 选下一个未完成任务
2. **Implement** — 做改动(每轮**全新派生代理进程**——真·擦干净石板,重新喂必要上下文)
3. **Validate** — 跑测试/类型检查/lint(通过才继续,防在错误上堆错误)
4. **Commit** — 提交代码(commit message 即下一轮的上下文)
5. **Update** — 标记任务 done + **记录学习**(写进 AGENTS.md/progress)
6. **Reset** — 清空代理上下文,从下一个任务重新开始

**核心洞见:stateless-but-iterative**——每次重置避免代理累积混乱(解决上下文溢出问题:单个巨型 prompt 会漂移/遗忘);小而有界任务 + 无歧义 pass/fail 标准(原子用户故事:\"添加导航栏,当前页链接高亮为蓝色\"而非\"建整个仪表盘\")→ 更干净代码、更少幻觉

**任务来源:SPEC → tasks JSON**:先写 spec(可 AI 辅助补边界情况),转成结构化任务列表(prd.json:用户故事+验收标准);Carson 的 `/prd` 与 `/tasks` skills 自动化转换

**复合循环(Compound Product,开源)**:Analysis loop(读每日报告决定建什么)→ Planning loop(生成 PRD+任务)→ Execution loop(编码实现)——代理不仅写功能还决定**最高优先级功能是什么**;循环可链:一个代理的输出成为另一个的输入

**四通道记忆**(跨重置持久):①git 提交历史(每轮提交,下轮 git diff/log 自读)②progress.txt(追加式日志:尝试了什么/过没过/错误与发现——代理的日记)③tasks 状态(prd.json 的 passes 标记——崩溃重启后知道剩哪些)④**AGENTS.md**(长期语义记忆——发现/约定/指引的运行笔记本;每任务后追加:\"代码库用 Library X 做 Y\"、\"Gotcha:改 user model 也要改 audit log\");复合学习哲学:\"**每次改进让未来改进更容易**\";**验证记忆真的被用**:记忆文件只有被注入 prompt 才有效——progress.txt 可能默认不自动加载,需在 prompt 模板显式加入(\"以下是前几轮笔记:\")(见 [[agents-md]]、[[file-as-memory]])

**验证循环(QA 第一公民)**:每轮跑既有测试(理想:每个用户故事至少关联一个测试);typecheck+lint 配置化;CI 进循环(红旗即停,卡 N 次后标记失败或跳过);AI 自评可选(dev-browser skill:无头浏览器确认 UI 元素——代理驱动的集成测试,需沙箱);**Willison 以身作则**:维护高质量测试,代理自然模仿(\"用 [某文件] 的测试风格\")——\"agentic QA 循环把天真的'生成点代码'变成可靠工程工作流\"(见 [[agent-verification]])

**监控与止损**:实时日志(tail progress.txt,同错误打转就介入);checkpoint 提交(git log/diff 审计;自动化 diff 审查——diff 超预期或碰范围外关键文件 = gone rogue 中止);代理内省(\"3 次仍失败就输出推理与计划\",谨慎用);性能指标(每迭代耗时/token 成本,\"每小时功能数\"评估模型升级);**自动停止条件**(max iterations / 时间限制 / 闲置条件——最后 5 次迭代无提交即断,防跑一夜空转);**人工覆盖:结束开 PR,绝不自动合并**——每天早上的最终评审(\"human QA 步骤目前无价\":抓到符合验收标准字面但不符精神的东西)(见 [[agent-management]])

**风险护栏**:特性分支绝不 main;只读命令自动批准、写操作人工批准(git push/rm -rf);沙箱(Docker/VM);最小作用域 API key;紧急停止(Ctrl+C/Escape/资源监控);**定期重新聚焦**(长跑漂移/隧道视野——完成一大块后停下评审中间产物、更新任务列表再继续);多模型交叉检查(规划强模型+编码专长模型;第二意见审 diff);上下文膨胀优化(代理自摘要日志再截断;按任务 ID 分区;善用训练知识——\"用 Hooks 和 Vite 的 React 项目\"即可,别贴文档)

**规模化方向**:**迭代更深而非更宽**——一个能干代理跑更久(过夜/数天)比难管理的蜂群更有效;多循环并行需明确分区(前端/后端循环;多分支夜间循环);协调问题与 Planner-Worker-Judge 见 [[agent-teams]](共享锁导致代理卡死/风险厌恶的实证)

**谱系定位**:Ralph Loop 是 [[loop-engineering]] 的原型实例(/goal 停止条件版);与初始器/编码拆分对比:后者用交接工件换会话,前者靠强制续跑;\"把单会话代理变成多会话的惊人简单技巧\";轶事:$50k 项目用几百美元 API 交付(待核)(见 [[long-running-agents]]、[[harness-engineering]])

## 与其他页面的关系

- 机制: [[long-running-agents]]、[[loop-engineering]];记忆: [[file-as-memory]]、[[agentic-memory]]、[[agents-md]]
- 验证: [[agent-verification]];学习: [[self-reflection]];管理: [[agent-management]]
- 来源: [[2026-03-26-code-agent-orchestra]]、[[2026-01-31-self-improving-agents]]
