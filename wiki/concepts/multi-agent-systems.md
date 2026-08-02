---
type: concept
tags: [ai-agents, architecture, multi-agent]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [subagents, parallel-agents, agentic-workflow-patterns, llm-as-a-judge, lethal-trifecta, agent-teams, addy-osmani, conductor-orchestrator]
sources: [2026-08-02-how-we-built-our-multi-agent-research-system, 2026-03-26-code-agent-orchestra, 2026-01-02-future-agentic-coding]
status: active
---

# Multi-agent systems

多个代理(LLM 自主循环使用工具)协作完成任务的系统;以 token 消耗换并行能力与性能——"搜索的本质是压缩"。

## 关键信息

**为什么有效**(来源: [[2026-08-02-how-we-built-our-multi-agent-research-system]])

- 搜索 = 压缩:子代理在各自上下文窗口并行探索不同方面,把最重要的 token 压缩给主导代理;分离关注点,减少路径依赖
- 集体智能:个体代理有上限,代理组可完成更多(与人类社会集体智能类比)
- 量化:Opus 4 主导 + Sonnet 4 子代理 vs 单代理 Opus 4,内部研究评测高 **90.2%**;BrowseComp 上 token 用量解释 80% 性能方差(+工具调用数与模型选择 = 95%)
- 模型是 token 的"效率乘数":升级模型(如 Sonnet 3.7→4)比翻倍 token 预算收益更大

**代价与适用**

- 经济:代理 ≈ 4× 聊天 token,多代理 ≈ **15×**——任务价值须高到值得
- 适用:重度并行、信息超出单上下文窗口、接口众多复杂工具
- 不适合:需所有代理共享上下文/代理间强依赖的领域;多数编码任务并行度不足,实时协调委派还不成熟
- 风险叠加:非确定性 × 多代理放大,错误复合更快(见 [[lethal-trifecta]])

**架构与原则**

- 典型形态:[[agentic-workflow-patterns|orchestrator-workers]]——主导代理规划+委派,子代理并行,综合收尾(Research 额外加 CitationAgent 做引用归因)
- 委派要教:每个子代理需 目标/输出格式/工具与源/任务边界,否则重复与遗漏
- 投入按查询复杂度缩放:简单事实 1 代理 3-10 调用 → 复杂研究 10+ 子代理分责
- 并行两层次:3-5 子代理并行 + 子代理 3+ 工具并行,复杂查询研究时间降 90%
- 提示原则七条见源页;评测见 [[llm-as-a-judge]](rubric 判分、"立即小样本"启动、人工补漏)
- 生产:有状态、错误复合 → 断点续跑/告知失败让代理自适应/retry+checkpoint;全链路追踪(不监控对话内容);彩虹部署逐步切流量;同步执行是当前瓶颈,异步(实时协调)是方向
- **指挥 → 编排**(来源: [[2026-03-26-code-agent-orchestra]],Osmani 演讲):conductor 模型(单代理、同步、上下文窗口是硬天花板)已让位 orchestrator 模型(多代理各自窗口、异步,你计划+周期性查岗);**单代理三堵墙**:上下文过载、无专长、无协调;多代理四个**乘法**理由:并行(3×吞吐)/专长化(聚焦上下文)/隔离(worktree)/复合学习(AGENTS.md)——"三个专注代理持续胜过干三倍时间的一个通才";Yegge 八级阶梯(多数开发者困在 3-4 级,编排层从 6 级开始,需要与 5 级之前不同的技能);**协调原语缺口已由 Agent Teams 填补**(共享任务列表/依赖跟踪/文件锁/对等消息,见 [[agent-teams]])——Anthropic 2026 初"实时协调委派不成熟"的判断正在被产品化演进;角色光谱的完整定义见 [[conductor-orchestrator]](五轴对比:控制范围/自主度/同步性/工件可追溯性/人力分布;ephemeral vs git 痕迹;降级回 conductor 的调试模式;上下文共享孤岛/交接元数据是开放问题)
- **编排经济学:人是最慢组件**(来源: [[2026-05-24-orchestration-tax]]):编排税——启动代理便宜、闭环评审贵,全部判断/合并路由经过唯一串行处理器(你);GIL 类比 + Amdahl(串行分数 = 判断)精确化;吞吐 = 评审步吞吐,代理数量只加深队列;不付税 = 技术债+认知债同时累积(Storey 框架);五条注意力架构实践(按评审率缩放/两堆分类/批量评审/锁只花在判断上/保护串行时间)——"编排不是真正的工作,是工作周围的 overhead";与 3-5 甜点区([[agent-teams]])、WIP 上限([[parallel-agents]])互证(见 [[orchestration-tax]])
- **2026 工具三层谱系**(2026-03 snapshot):Tier 1 进程内(子代理/Agent Teams)→ Tier 2 本地编排器(3-10 代理,worktree+dashboard:Conductor/Vibe Kanban/Gastown/OpenClaw+Antfarm/Claude Squad/Antigravity/Cursor Background Agents)→ Tier 3 云端异步(派活走人收 PR:Claude Code Web/Copilot Coding Agent/Jules/Codex Web);Cursor Glass 标志"控制平面成为主界面、编辑器退居其下"的生态趋势;多数人三层都用(交互/并行冲刺/夜里清积压);Beads(Gastown) = 不可变 git 支撑的制度记忆、SQL 可寻址、**非向量 RAG**(见 [[agentic-memory]])
- 附录技巧:终态评测(状态变更类任务)、长时对话管理(总结阶段+外部记忆+新子代理接续)、子代理输出直写文件系统(传轻量引用,避免"传话游戏"信息损耗)

## 与其他页面的关系

- 构件: [[subagents]];执行并行: [[parallel-agents]];模式: [[agentic-workflow-patterns]]
- 风险: [[lethal-trifecta]];评测: [[llm-as-a-judge]];记忆: [[agentic-memory]]
