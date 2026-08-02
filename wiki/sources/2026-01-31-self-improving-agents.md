---
type: source
tags: [ai-agents, ralph-loop, self-improving, long-running, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Self-Improving Coding Agents (2026-01-31)

- 原文: `raw/Self-Improving Coding Agents.md`
- 类型: 技术博客([[addy-osmani]],发布于 **2026-01-31**,frontmatter 已标注;文末注\"本贴用 Gemini 优化可读性\")
- 备注: 本 wiki 第二十九篇源文档;**Ralph Loop 的实操大全**(Ryan Carson 推文《How to make your agent learn and ship while you sleep》的扩展版,作者与 Carson 饭局聊过后写成);覆盖:循环编排、上下文文件结构、记忆持久化、QA 验证、规模化、调试与风险管理——[[ralph-loop]] 概念页的深度来源

## 摘要

"结束工作日,醒来时新功能已编码、测试、待评审"——自主代理在连续循环中改进与交付。核心 = **continuous coding loop(Ralph Wiggum 技术)**:把开发拆成很多小任务,代理循环逐个解决;每轮六步(Pick → Implement → Validate → Commit → Update status+log → **Reset context**);\"stateless but iterative\"设计是可靠性的关键——解决上下文溢出问题(单个巨型 prompt 会漂移/遗忘),每轮干净起步 + 明确指令 → 更干净的代码、更少的幻觉。配套机制:SPEC → tasks JSON(/prd、/tasks skills 自动化)、AGENTS.md 手册(跨迭代的知识载体)、四通道记忆、验证循环(测试/类型/lint/CI/自评)、监控与止损、风险护栏;规模化方向是\"迭代更深而非更宽\"。

## 关键主张

**六步循环**(比 [[2026-03-26-code-agent-orchestra|演讲版]] 多一步:更新状态 + 记录学习):Pick(从 JSON 任务列表挑未完成的)→ Implement → Validate(测试/类型检查/质量检查)→ Commit(通过才提交)→ Update task status(标记 done)+ log learnings → **Reset**(清上下文,重复直到全部完成或停止条件);每次迭代**全新派生代理进程**(\"真·擦干净石板但重新喂必要上下文\")

**小任务 + 明确标准**:原子用户故事,小到能放进一个 AI 会话,有**无歧义的 pass/fail 标准**(例:\"添加导航栏,当前页链接高亮为蓝色\"而非\"建整个仪表盘\");**实现提示:先写 SPEC,再转 tasks JSON**(prd.json:用户故事 + 验收标准);Carson 的 /prd 与 /tasks skills(Amp/Claude)自动化转换

**复合循环(Compound Product,开源)**:Analysis loop(读每日报告决定建什么)→ Planning loop(生成 PRD + 任务)→ Execution loop(编码实现)——代理不仅写功能,还决定**最高优先级功能是什么**;循环可链:一个代理的输出(任务列表/分支名)成为另一个的输入

**AGENTS.md 手册**:跨迭代的知识载体——代理的\"运行笔记本\"(发现/约定/指引);每任务后追加学习(\"代码库用 Library X 做 Y\"、\"Gotcha:改 user model 时也要改 audit log\");Compound Product 哲学:\"**代理更新 AGENTS.md——发现的模式为未来迭代存档**\",每次改进让未来改进更容易(复合学习);结构四节:Patterns & Conventions / Gotchas / Style-Preferences / Recent Learnings;条目要简短事实化——**prompt additive**;上下文注入策略:警惕 context bloat(过大降低性能/被忽略),归档过时内容,按任务分区检索;**Eric J. Ma 实时反馈技术**:\"别用旧端点,用 v2/users API。**记到 AGENTS.md 里,然后继续**\"——创造持久偏好记录改善未来代理行为;跨代理共享:Eric Ma 的 MCP server 统一存储/供给上下文(或多项目共享 markdown/wiki)

**四通道记忆**(Carson Ralph 实现):①**git 提交历史**(每轮提交,下轮 git diff/log 自读;commit message 即上下文)②**progress.txt**(追加式日志:每轮尝试了什么、过没过、错误与发现——代理的日记;崩溃后从 progress.txt 定位)③**tasks 状态(prd.json)**(passes 标记持久化,崩溃重启后知道剩哪些,防返工)④**AGENTS.md**(长期语义记忆);**复合学习循环**:不是 ML 意义上的在线学习,是系统化记录结果;插件扩展:Amp 的 auto-handoff(上下文将溢出时把对话交给新会话 + 浓缩摘要——短期记忆)、实验性向量库(嵌入 diff/错误消息查询相似案例——\"见过类似失败测试及其修法\";增加复杂度,勤维护简单工件(文件与日志)可能就不需要);**重要提示:定期验证代理真的在用记忆**——记忆文件只有被注入 prompt 才有效(progress.txt 可能默认不自动加载,需在 prompt 模板里显式加入:\"以下是前几轮笔记:\")

**QA 验证循环**(自主代理可靠产出的前提):单测/集成测试(每轮跑既有测试;理想情况下每个用户故事至少关联一个测试);类型检查 + lint(配置:只在此成功退出后继续——防止代理在错误上堆错误);**CI 进循环**(Cursor 多代理实验的 judge 代理决定项目是否完成 = GH Actions 绿;**红旗即停**:检查失败代理去修,卡 N 次后标记仍失败或跳过);**AI 自评(可选)**:dev-browser skill——无头浏览器导航页面确认 UI 元素存在/交互工作(代理驱动的集成测试;需要沙箱);**Willison 的\"以身作则\"**:维护高质量测试,代理会自然模仿(\"用 [某文件] 的测试风格\";干净测试的项目里\"代理新增测试的质量会匹配它们\")——上下文播种大幅改善输出;**\"这个 agentic QA 循环把天真的'生成点代码'变成可靠工程工作流\"**

**规模化(并发与多循环)**:Cursor 实验(数十/数百代理;一周内百万行代码 1000+ 文件建浏览器——Wilson Lin);**并行挑战**:两个代理抢同一任务;共享文件锁机制 → 代理卡住/互相等待;锁的替代尝试暴露更深问题——**代理变风险厌恶**(各自只做微小安全改动、避开大而复杂的任务——自由混战中没人觉得\"负责\"难的部分);**Planner-Worker 模型**(更成功):Planner(项目经理:读整个代码库、决定做什么、递归拆子任务)+ Worker(实现,不管大局)+ **Judge 代理**(评估目标是否达成)——消除无目的游荡,吞吐量级提升;实用路径:多循环并行(前端循环 + 后端循环;10 个特性分支 10 个夜间循环——Carson 预测创始人最终每晚跑 10+ 循环);协调:共享 tasks.json + 锁(棘手)/\"交通警察\"脚本(队列派活);**\"对大多数高级用户,规模化 = 迭代更深而非更宽\"**——一个能干代理跑更久(过夜/数天)比难管理的蜂群更有效

**监控、调试与反馈仪表化**:实时日志(tail progress.txt;发现代理在同一错误上打转就介入);**checkpoint 提交**(git log/diff 审计轨迹;可自动化 diff 审查——diff 比预期大得多或碰了任务范围外关键文件就中止循环 = \"gone rogue\" 检测);检查命令(jq 看任务状态;grep ERROR);代理内省(\"测试 3 次仍失败就输出你的推理与计划\"——链式思考自反思,谨慎使用);性能指标(每迭代耗时与 token 成本;\"每小时功能数\"统计可评估模型升级/prompt 调优);**自动停止条件**(max iterations=50;时间限制 3 小时;闲置条件——最后 5 次迭代无提交即中断——防止跑一夜什么都没做);**人工覆盖:代理结束开 PR,绝不自动合并——每天早上的最终评审**(会抓到漏过测试的:逻辑问题/符合验收标准的字面但不符精神的东西);\"这个 human QA 步骤目前无价\";失败 = 学习信号(验收标准模糊?AGENTS.md 需要更好的提示?——反思式改进,类似结对编程复盘)

**风险管理**:防破坏——特性分支绝不直接 main;只读命令自动批准(grep/git log/npm test)、写操作人工批准(git push/rm -rf;`--dangerously-allow-all` 谨慎);沙箱(Docker/VM);最小作用域 API key;紧急停止(Ctrl+C/Escape;资源监控——CPU/内存异常自动杀);幻觉与发散——强 spec 与明确 prompt 第一道防线(\"POST /api/login 得 200 OK\"没有幻觉空间);验证捕获幻觉(类型错误/引用错误/失败测试是\"代理做了不真实的事\"的信号,回喂错误输出即可自纠);**定期重新聚焦**(长跑漂移/隧道视野:完成一大块后停下、评审中间产物、更新任务列表再继续——Carson 团队\"定期全新开始对抗漂移与隧道视野\");多模型交叉检查(规划用强模型、编码用代码专长模型;关键步骤第二意见——用 GPT-4 审 Claude 的 diff);上下文膨胀优化(让代理自己摘要 progress log 再截断;按任务 ID 只给相关日志;**善用训练知识**——\"这是用 Hooks 和 Vite 的 React 项目\"就够,别贴 React 文档);人类监督与持续改进(Carson 的\"elbow grease\":调 prompt 与工作流集成没有一劳永逸的魔法;你的角色从写代码变成策展流程——像 AI 开发团队的工程经理);成本(卡死循环烧 token;预算警报;Ralph 社区轶事:**$50k 项目用几百美元 API 调用交付**,待核)

**收尾**:\"每次迭代,你与代理都变得更好\"——\"趁你睡觉交付,让代理复合你的进度\"

## 与现有 wiki 的关系

- 更新了 [[ralph-loop]](六步 + 四通道细节 + AGENTS.md 手册 + 监控止损 + 风险), [[agents-md]](手册结构 + Eric Ma 实时反馈), [[long-running-agents]](复合循环 + 定期重新聚焦), [[agent-teams]](Cursor 规模化实验数据点), [[ai-feature-implementation-loop]]
- 关键互证:六步循环 = [[2026-03-26-code-agent-orchestra|演讲版]] 的加详(多了 Update status + log);四通道记忆 ↔ [[long-running-agents]] 交接工件与 [[file-as-memory]];AGENTS.md 手册 ↔ [[agents-md]] 意图账本(此为\"复合学习\"侧);\"验证代理真的在用记忆\" ↔ [[progressive-disclosure]] 触发率问题的记忆版;dev-browser skill ↔ [[agent-verification]] 浏览器自动化;Planner-Worker-Judge ↔ [[agent-teams]] maker/checker 与 [[multi-agent-systems]] 层级;风险厌恶代理 ↔ 协调开放问题(自由混战无人负责难任务);PR 不自动合并 ↔ [[pr-contract]] 人类签字阵营;\"迭代更深而非更宽\" ↔ [[2026-03-26-code-agent-orchestra|演讲]] 的 3-5 甜点与 WIP;Willison 以身作则 ↔ [[simon-willison]] 实体;Cursor 规模化实验 ↔ [[cursor]] 实体

## 待办 / 后续

- 核实:Ryan Carson 推文/Compound Product/ghuntley.com/ralph/Eric Ma 博客/cursor.com/blog/scaling-agents(Wilson Lin)/$50k 轶事(均外部引用)
- AGENTS.md 手册 vs ETH 反证(自动追加的学习条目质量——代理自己写的 vs 人写的,谁该写入?);向量库记忆的对比数据
