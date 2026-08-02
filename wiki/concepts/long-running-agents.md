---
type: concept
tags: [ai-agents, long-running, harness, memory]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agentic-memory, agent-verification, conformance-testing, context-engineering, agentic-workflow-patterns, file-as-memory, context-anxiety, harness-engineering, loop-engineering, ralph-loop, skills]
sources: [2026-08-02-effective-harnesses-for-long-running-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-04-19-agent-harness-engineering, 2026-06-07-loop-engineering, 2026-03-26-code-agent-orchestra, 2026-05-03-agent-skills, 2026-01-31-self-improving-agents, 2025-03-19-measuring-ai-long-tasks]
status: active
---

# Long-running agents

长时运行代理:需要跨多个上下文窗口/会话持续工作(数小时到数天)的代理——核心难题是**每次会话以空记忆开始**,需要 harness 层设计来桥接会话间隙。

## 关键信息

**能力基线:时间地平线(来源: [[2025-03-19-measuring-ai-long-tasks]],METR 一手)**:模型能自主完成"人类专家耗时 T"的任务(50% 成功率)——T 即时间地平线;人类时长强预测成功率(人类 <4 分钟 ≈100%,>4 小时 <10%);**6 年约每 7 个月翻倍**(1-4 doublings/年),从 GPT-2 ~4 秒 → Claude 3.7 Sonnet ~1 小时 → GPT-5(2025-08)~2 小时(OpenAI 引用的 2h17m 一致)→ **Claude Opus 4.6 ~16 小时**(2026,>16h 测量不可靠);外推:2-4 年周级任务、2030 末月级项目;稳健性:SWE-bench 复制更快(<3 个月,方法差异);敏感度:10x 误差 ±2 年、2024+ 子集缩短月级预测 2.5 年;含义:harness 设计(会话交接/验证门禁)的"作业时长"窗口正在从分钟级扩到天级——[[ralph-loop]]/[[loop-engineering]] 的长期循环模式与能力增长同向(见 [[harness-engineering]])

**问题本质**(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]])

- 上下文窗口有限,复杂项目无法单窗口完成;compaction 只能延续单会话,不能保证向下一会话传递清晰指令
- 默认失败模式:①**一次性做完**——试图一口气实现全部 → 上下文耗尽 → 下一会话从半实现无文档状态靠猜恢复;②**提前宣布完成**——后到的会话看到进展就宣布完成;③**未测试就标完成**——跑过单测/curl 但识别不出端到端不工作
- 反例基线:Opus 4.5 跑 Claude Agent SDK 循环,仅给高层提示建不出生产级 web app

**两件套 harness 模式**

1. **初始器代理(首次会话专用 prompt)**:建环境——特征清单(feature list,JSON,200+ 端到端特征全标 `passes: false`)、`init.sh`(起开发服务器 + 冒烟脚本)、`claude-progress.txt`、初始 git commit;选 JSON 而非 Markdown:模型更不易改写 JSON
2. **编码代理(后续每会话)**:只做增量——一次一个特征;改代码后 git commit(描述性消息)+ 更新 progress 文件;只允许改 passes 字段("It is unacceptable to remove or edit tests");会话后环境 = **可合并 main 分支的干净状态**(无大 bug、有序、有文档)

**会话起步仪式**(快速进入状态 + 省 token)

`pwd` → 读 git log + progress 文件 → 读特征清单选最高优先级未完成特征 → init.sh 起服务 → 浏览器自动化冒烟测试(确认没被留在损坏状态)→ 动手新特征

**验证手段**:显式提示 + Puppeteer MCP 浏览器自动化,"像人类用户一样测试"——大幅提升(发现代码本身看不出的 bug);vision/浏览器自动化限制(原生 alert 模态框不可见)导致该类特征易出 bug

**演进:三代理架构**(来源: [[2026-08-02-harness-design-for-long-running-apps]],Opus 4.5/4.6 时代)

- **Planner**:1-4 句 prompt → 完整产品 spec(自动化上篇的初始器步骤);要求雄心范围 + 产品语境/高层技术设计,**避免细粒度实现细节**(细节写错会在下游级联);主动织入 AI 功能
- **Generator**:sprint 式一次一个特征;每个 sprint 结束自评再交 QA;git 版本控制
- **Evaluator**:Playwright MCP 像用户一样点遍运行中应用(UI/API/数据库);按 bug + 四条标准打分(产品深度/功能/视觉设计/代码质量),**每条硬阈值、任一不达标 sprint 失败**并给可执行反馈
- **Sprint contract**:写码前协商"完成"定义——生成器提案(做什么 + 如何验证),评估器审查(是否在做对的事),迭代到达成;文件通信(写文件 → 对方读并回复);桥接高层 spec 与可测试实现
- **简化原则**:每个组件都编码"模型自己做不到什么"的假设,随模型变强会过时(Opus 4.6 后去掉 sprint 结构、评估器改终评;激进全砍失败,需逐组件移除评估);context reset 在 Opus 4.5 后不再必需(见 [[context-anxiety]])
- 成本实证:Solo 20 分钟/$9 vs 三代理 6 小时/$200(20 倍);DAW 案例 3h50m/$124.70,QA 每轮约 $3-4 抓到真实缺口(stub 特征、交互缺失)

**Ralph Loop**(来源: [[2026-04-19-agent-harness-engineering]]):另一种跨会话机制——hook 拦截模型退出企图,把原 prompt 重注入**新上下文窗口**,强制代理对着完成目标继续;每次迭代干净起步、经文件系统读上一轮状态;与初始器/编码拆分的对比:后者用交接工件换会话,前者靠强制续跑("把单会话代理变成多会话的惊人简单技巧",见 [[harness-engineering]]);**形式化版见 [[ralph-loop]]**(Pick→Implement→Validate→Commit→Reset 五步、stateless-but-iterative、四通道记忆、3+ 卡死杀并重派)

**循环原语**(来源: [[2026-06-07-loop-engineering]],Osmani):`/loop` 按节奏重跑 prompt/命令;/goal 一直跑到可验证停止条件成立(独立模型每轮检查完成,见 [[agent-verification]]);状态文件 = 循环的脊柱——"**代理会忘,仓库不会**",明早接着今晚停下的地方跑;循环把长时 harness 的交接工件(progress 文件/特征清单)升级为自我喂食的自动化(automations 定时发现+triage,见 [[loop-engineering]])

**运行越长,强制越多**(来源: [[2026-05-03-agent-skills]],Osmani):10 分钟会话跳过测试 = 一个 bug;30 小时会话跳过测试 = 结束时没人记得原始意图的调试考古项目——长运行放大每个捷径,资深脚手架(验证退出标准/反合理化表/范围纪律)在长时任务里**必须强制执行而非建议**(见 [[skills]]、[[process-over-prose]])

**复合循环与重新聚焦**(来源: [[2026-01-31-self-improving-agents]]):Ralph Loop 升级版——Analysis → Planning → Execution 复合循环(代理决定最高优先级功能是什么,见 [[ralph-loop]]);长跑漂移/隧道视野的对抗:**定期全新开始**(完成一大块后停下、评审中间产物、更新任务列表再继续);自动停止条件(迭代数/时间/闲置——最后 5 次迭代无提交即断)防跑一夜空转

## 与其他页面的关系

- 记忆层:progress 文件 + git 历史 = [[file-as-memory]] 实例(外部化跨会话记忆,见 [[agentic-memory]])
- 验收:feature list passes 门禁 = 可执行 [[conformance-testing]];端到端验证见 [[agent-verification]]
- 属于 [[context-engineering]] 多上下文窗口工作流(Claude 4 prompting guide:"首个上下文窗口用不同 prompt")
- 与 [[multi-agent-systems]] 对照:此模式是单代理跨会话;专用测试/QA/清理代理是否更好是开放问题
