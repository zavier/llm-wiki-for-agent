---
type: concept
tags: [ai-agents, harness, configuration, discipline]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [addy-osmani, agents-md, context-engineering, long-running-agents, agent-verification, model-context-protocol, tool-evaluation, agentic-workflow-patterns, agent-readability, openai, cursor, humanlayer, alibaba, execution-graph, claude-code, loop-engineering, skills, process-over-prose, pi-coding-agent, minimal-vs-rich-harness]
sources: [2026-04-19-agent-harness-engineering, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-02-11-codex-agent-first-engineering, 2026-04-30-cursor-agent-harness-improvement, 2026-03-12-skill-issue-harness-engineering, 2026-05-08-ai-native-organization, 2026-05-14-claude-code-large-codebases, 2026-06-07-loop-engineering, 2026-05-03-agent-skills, 2025-11-30-opinionated-minimal-coding-agent]
status: active
---

# Harness engineering

把模型之外的一切(提示、工具、上下文策略、hooks、沙箱、反馈回路)当作真正的工程工件来设计与维护的学科——"Agent = Model + Harness";harness 工程是编码代理领域的核心杠杆。

## 关键信息

**定义与等式**(来源: [[2026-04-19-agent-harness-engineering]])

- Viv Trivedy 的等式:**coding agent = AI model(s) + harness**;"If you're not the model, you're the harness";原始模型不是代理,harness 赋予状态、工具执行、反馈回路与可强制约束
- 组成:系统提示/CLAUDE.md/AGENTS.md/skills/子代理提示;工具与 MCP 描述;基础设施(文件系统/沙箱/浏览器);编排(子代理、交接、路由);hooks(compaction/continuation/lint);可观测性
- **核心立场**:一般模型 + 好 harness 胜过好模型 + 差 harness;今天模型能做 vs 你看到它做的差距**大部分是 harness 差距**("skill issue" = 配置问题,HumanLayer)
- 量化证据:Terminal Bench 2.0 上同一模型(Opus 4.6)在不同 harness 里差距巨大;只改 harness 把编码代理从 Top 30 提到 Top 5;模型后训练与训练时所用 harness 耦合(共训练过拟合——改工具逻辑会莫名回归)

**两条核心纪律**

1. **棘轮原则(ratchet)**:错误是永久信号——出过事才加约束(AGENTS.md 加行、hook 拦截、评审子代理标记),模型强到冗余才移除;"好 AGENTS.md 每一行都可追溯到一次具体失败";harness 由你的失败史塑造,**无法下载**
2. **行为驱动设计**:从想要的行为(或要修的失败)推导组件——说不出服务于哪个行为的组件不该存在

**原语工具箱**(与 [[context-engineering]]/[[long-running-agents]] 互补)

- 文件系统 + Git = 最基础的持久状态(工作区/卸载中间结果/多人多代理协调面)
- bash + 代码执行 = 通用工具(比预建每个工具更可扩展;ReAct 循环的落地)
- 沙箱 = 隔离执行环境(allow-list、网络隔离、预装运行时 + 无头浏览器;原则"**成功静默、失败冗长**")
- 记忆 = AGENTS.md 每次启动注入、编辑后重载(粗粒度持续学习)+ 搜索/MCP 补知识截止
- 上下文 = compaction、tool-call 输出卸载(2,000 行日志留头尾、全文落盘)、skills 渐进披露、全量 reset
- 长时执行 = Ralph Loop(hook 拦截退出 → 新窗口重注原 prompt 强制继续)、plan 文件 + 验证、planner/generator/evaluator + sprint contract
- hooks = 强制层("告诉代理做 X" vs "系统强制 X"):每改必跑 typecheck/lint/test、拦截破坏性命令、批准门
- AGENTS.md/工具选择 = "飞行员的检查单而非风格指南"(HumanLayer <60 行);十把聚焦工具胜过五十把重叠

**安全**:工具描述每请求进 prompt——安装的任何 MCP 服务器都是模型会读的可信文本,马虎/恶意 MCP 可 prompt-inject 代理(MCP 供应链风险,见 [[model-context-protocol]]、[[tool-evaluation]])

**演化动力学**

- "harness 不缩小,只移动"(Anthropic):每个组件编码"模型做不到什么"的假设;模型变强组件变死代码,但天花板上移产生新需求(多天记忆、多代理协调、设计质量评估)
- 模型-harness 训练回路:harness 原语 → 产品化 → 进下一代训练 → 新模型更会用该原语;harness 是活系统而非一次配置
- HaaS(Harness-as-a-Service):从 LLM API(completion)到 harness API(runtime)——Claude Agent SDK/Codex SDK/OpenAI Agents SDK;四支柱(系统提示/工具/上下文/子代理)配置;v0.1 先跑起来再迭代
- 前沿:并行多代理共享代码库、代理自分析 trace 修 harness 失败、按任务**动态装配**工具与上下文(静态配置 → "编译器"化)
- **过拟合双刃**(来源: [[2026-03-12-skill-issue-harness-engineering]],HumanLayer):模型在后训练 harness 上表现好(Codex 与 apply_patch 强耦合,OpenCode 被迫为 GPT/Codex 模型加 apply_patch 工具)——但**模型也会被 harness 过拟合**:Terminal Bench 2.0 上 Opus 4.6 在 Claude Code 排 #33,换专门调优的陌生 harness 排 #5(±4)——"调优过的外来 harness 可解锁后训练未覆盖的能力";OpenAI 视角解读:harness = 运行时之外的一切(回压与验证机制为主)
- **实战经验清单**(来源: 同上):没用——未遇失败就设计理想 harness、装一堆以防万一的 skills/MCP、每会话末跑全量测试(5+ 分钟)、微调子代理工具访问(工具 thrash 更差);有用——从简单开始失败后按需加、设计-测试-迭代并扔掉(扔掉的多于在用的)、仓库级配置分发、优化迭代速度而非一次做对、先给能力再收窄;安全补充:**恶意 skill 注册表**(ClawHub 数百个恶意 skill,可执行任意代码)+ MCP 供应链(prompt injection + STDIO 执行宿主机代码)(见 [[skills]])
- **组织尺度**(来源: [[2026-05-08-ai-native-organization]],阿里技术):Harness 层是 AI Native 组织**双层结构的底层**(代码/测试/流水线/文档/世界模型全部 AI 友好化,AI 主导),上层 Hive Mind 由人主导(见 [[hive-mind]]);**Architect** 是 harness 的组织化形态——把组织隐性 know-how 翻译成 AI 可消化形态的人(见 [[management-collapse]]);**复利飞轮**:Harness 跑起来 → AI 接管越多 → 失败信号越丰富 → Harness 优化越快,早建与晚建是指数差距而非线性;文中称"OpenAI 2026 年初提出 harness engineering"(二手,与 Viv Trivedy 命名说并存,待核);新瓶颈论:不是 AI 能力不够,是**系统信息形态不够**(见 [[agent-readability]])
- **厂商官方背书 + 维护节奏**(来源: [[2026-05-14-claude-code-large-codebases]],Anthropic):"模型周围的生态——harness——决定表现的程度超过模型本身"——官方站台 HumanLayer/Osmani 的 harness 论;五扩展点**按序**构建(CLAUDE.md → hooks → skills → plugins → MCP,每层建立在前层上)+ LSP 与子代理两个能力;hooks 的自改进用法(stop hook 在上下文新鲜时反思会话并提议 CLAUDE.md 更新,start hook 动态加载团队上下文);**配置评审每 3-6 个月一次**(重大模型发布后平台期也做)——harness 过时问题的第一个节奏答案(与 Cursor 护栏过时、Anthropic 逐组件移除互证);LSP = 符号级搜索(过滤发生在模型读任何东西之前,见 [[context-engineering]]);组件常见误区表(见 source 页)
- **上一楼层:循环工程**(来源: [[2026-06-07-loop-engineering]]):harness 之上有第三层——"跑在定时器上的 harness,孵化小助手,自我喂食"(自动化发现/派活/检查/记录/决策);五件套(automations/worktrees/skills/plugins+connectors/subagents)+ 状态文件;harness 的维护节奏升级为循环的自维护(见 [[loop-engineering]])
- **层级分工**(来源: [[2026-05-03-agent-skills]],Osmani):harness 各层各司其职——AGENTS.md 滚动规则书、**skills = 资深工程师流程层**(可复用工作流按需渐进披露)、hooks 确定性执行、工具动作、会话日志持久记忆;skills 干"senior-engineer 流程"的活,"运行越长,资深脚手架越要强制执行而非建议"(见 [[process-over-prose]])
- **极简派:harness 也可以是"更少"**(来源: [[2025-11-30-opinionated-minimal-coding-agent]],[[pi-coding-agent]]):Zechner 自建 pi 的立场——"如果我用不到,它就不会被构建":系统提示+四工具 <1000 tokens(无 hooks/skills/子代理/MCP/plan mode/to-do/后台 bash),状态全在文件(TODO.md/PLAN.md),后台交互用 tmux(可观测 + 人机协同调试),安全 = YOLO(权限弹窗 = security theater,能力三元组无解,引 [[simon-willison]] dual-LLM 自认);Terminal-Bench 2.0 五轮跑分上榜(Claude Opus 4.5);Terminal-Bench 团队自己的 Terminus 2(**纯 tmux 交互、零工具**)也名列前茅——与"Top 30→Top 5 靠调优 harness"构成 harness 差距论的两面:**harness 可以增加表现,也可以削减负担**;与 HumanLayer"从简单开始、失败后按需加、扔掉的多于在用的"清单同调;"行为驱动设计"(说不出服务哪个行为的组件不该存在)= Zechner 的"用不到就不构建"的同构表述(见 [[minimal-vs-rich-harness]])

**极端实例与维护回路**(来源: [[2026-02-11-codex-agent-first-engineering]],OpenAI 零人工代码实验):harness 工程的极限形态——整个仓库由代理塑造(1/10 时间、100 万行、1500 PR);工程师的工作 = 设计环境/明确意图/构建反馈回路,出问题时问"缺什么能力、如何让能力对智能体清晰可读又可强制执行";两条新增实践:①**熵与垃圾回收**——代理复现既有模式致漂移,人类每周五清"AI 残渣"不可扩展 → 把"黄金原则"(带主观意见的机械规则)编码进仓库 + 后台清理代理(扫偏差/更新质量等级/开定向重构 PR,多数一分钟内审完自动合并);"技术债如高息贷款,小额持续偿还""人类的品味一旦被捕捉,就持续应用于每一行代码"②**规范架构**——强制不变量而非微观管理(固定层依赖方向 + 自定义 linter 机械执行,错误信息写成注入代理上下文的修复指令);"有了约束,速度才不会下降,架构才不会漂移"(见 [[agent-readability]])

**按模型定制**(来源: [[2026-04-30-cursor-agent-harness-improvement]],Cursor):框架抽象不依赖具体模型但可深度定制——**工具格式必须匹配模型训练格式**(OpenAI 用 patch 编辑文件、Anthropic 用字符串替换;给不熟悉的格式额外消耗 reasoning token 并产生更多错误);提供商级定制提示(OpenAI 偏字面精确、Claude 偏直觉容忍不精确);Early Access 调优循环(从最接近的模型框架起步 → 离线评估 → 试用反馈 → 迭代);"同一个模型在专门调优过的框架中明显更快更聪明更高效"——"模型-harness 训练回路"的具体证据;护栏演进史:2024 末的护栏(每改必喂 lint/限工具数/静态上下文)大多已淡出,转向动态上下文——组件随模型变强过时的直接例证(见 [[context-anxiety]])

## 与其他页面的关系

- 定义者与倡导者: [[addy-osmani]];配置文件载体: [[agents-md]]
- 上下文侧: [[context-engineering]];长时侧: [[long-running-agents]]、[[context-anxiety]]
- 评审侧: [[agent-verification]]、[[llm-as-a-judge]];工作流: [[agentic-workflow-patterns]]
