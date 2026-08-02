---
type: concept
tags: [ai-agents, orchestration, conductor, roles, mental-model]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [multi-agent-systems, factory-model, ai-agent-spec, pr-contract, file-as-memory, intent-debt, addy-osmani, orchestration-tax]
sources: [2026-01-02-future-agentic-coding, 2026-03-26-code-agent-orchestra, 2026-05-24-orchestration-tax]
status: active
---

# Conductor vs Orchestrator

人机协作的两种角色:conductor 与单个代理紧密同步协作(指挥家引导独奏者),orchestrator 管理多代理舰队(指挥整个乐团);不是刚性分类而是**光谱两端**——同一开发者可随时切换,是 2026 年代理化开发的底层心智模型。

## 关键信息

**定义**(来源: [[2026-01-02-future-agentic-coding]],Osmani)

- **Conductor**:工程师在环内逐步动态转向;同步、交互式会话(IDE/CLI);GPS 式导航;手动步骤仍在(建分支/跑测试/写 commit);**交互大部分是 ephemeral 的**——会话结束、未捕获进代码的上下文与决策即丢失;工具:Claude Code CLI/Gemini CLI/Cursor(inline)/Cline/Roo Code
- **Orchestrator**:设定高层目标与任务,自主代理独立执行(克隆仓库/建分支/改多文件/编译测试/迭代精化);异步、前台→后台("AI 团队在后台编码,完成后把带测试与文档的成品交给你评审");**跟踪式持久工作流**——分支/commit/PR 留在版本控制里("git 痕迹");工具:Copilot Coding Agent/Jules/Codex 云代理/Claude Code Web/Cursor Background Agents/Conductor/Claude Squad

**五轴对比**

| 维度 | Conductor | Orchestrator |
|---|---|---|
| 控制范围 | 微观:单任务 | 宏观:多代理/多步项目 |
| 自主度 | 低(每步等提示) | 高(内部计划+执行几十步) |
| 同步性 | 同步实时循环 | 异步(像长 CI 任务) |
| 工件 | 大量交互未记录 | 持久工件,团队可见可触发 |
| 人力分布 | ~100% 在场 | 前载(spec)+后载(评审),中间几乎不用 |

**关键性质**:①**角色流动**——光谱而非分类(此刻 conductor 下一刻 orchestrator;Codex 的"实时协作与异步委派无缝切换"是产品化);②**人力前载/后载**——"自动化规模化的本质:以细粒度控制换吞吐广度",这使 orchestrator 的人力杠杆更高但要求更强的前期规格能力;③**降级模式**——代理出错时 orchestrator 常需降回 conductor 修完再升回,编排不是"fire and forget"

**为什么重要**:自主代理是下一个抽象层;工程师角色从 implementer → manager;"每个工程师都以某种程度成为 AI 开发者们的经理";高需求技能:规划、prompt 工程、验证、监督(见 [[factory-model]] 高杠杆工程师六能力)

**编排税 = orchestrator 的成本经济学**(来源: [[2026-05-24-orchestration-tax]]):orchestrator 人力杠杆高(一次指挥多代理)但每闭环一次付一次税——启动便宜、评审贵,人是唯一串行处理器(GIL/Amdahl);对策:按评审率缩放舰队、两堆分类(隔离委托 vs 判断即工作绝不并行)、批量评审、只在判断上花锁、保护串行时间;不付 = 浅层评审 + 认知投降 + 心智模型过期(见 [[orchestration-tax]])

**六大挑战**(orchestrator 模式的开问题):质量与信任(何时介入 vs 信任代理计划;新"信任模型"——Stack Overflow CTO 引述)、协调与冲突(工作区隔离/一代理一任务,未来或靠代理间协商)、**上下文共享与交接**(没有统一工作流编排层时每个代理成孤岛:一个代理的元数据标记另一个不认就崩)、提示与规格(人的"编码"上移到写规格——"非常老派的技能重新变得重要")、工具与调试(checkpointing/rollback/监控仪表盘/AI 可观测性)、伦理与责任(许可/安全/偏见最终由人负责;"信任,但要验证")

**专业化流水线愿景**:Planning → Coding → Testing → Code Review → Documentation → Deployment/Monitoring 代理各司其职,人 = 全流程监督(批计划/解冲突/最终部署批准);"代理评审代理的 PR,人最后在环"的早期迹象已现
- **操作手册**:管理技能迁移(四项技能/委派三档/PR packet/六步操作系统)见 [[agent-management]]——角色光谱的实践对应

## 与其他页面的关系

- 规模化: [[multi-agent-systems]](指挥→编排在编排层的落地)、[[agent-teams]]、[[ralph-loop]]
- 人的杠杆: [[factory-model]](spec 杠杆)、[[ai-agent-spec]];评审: [[pr-contract]]
- 记忆: [[file-as-memory]](git 痕迹 = 持久工件)、[[intent-debt]](spec 上移的债务侧);倡导者: [[addy-osmani]]
