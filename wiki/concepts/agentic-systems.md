---
type: concept
tags: [ai-agents, architecture, taxonomy]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agentic-workflow-patterns, agent-computer-interface, agent-verification, simon-willison, self-reflection, lilian-weng, factory-model]
sources: [2026-08-02-building-effective-ai-agents, 2026-08-02-effective-context-engineering-for-ai-agents, 2023-06-23-llm-powered-autonomous-agents, 2026-02-25-factory-model-coding-agents]
status: active
---

# Agentic systems

Anthropic 对"LLM 驱动的自动化系统"的总称,核心架构区分:**workflows**(预定义代码路径)与 **agents**(LLM 动态主导自身流程与工具使用)。

## 关键信息

架构区分(来源: [[2026-08-02-building-effective-ai-agents]]):

- **Workflows**:LLM 与工具通过预定义代码路径编排——可预测、一致,适合定义清晰的任务
- **Agents**:LLM 动态决定如何完成任务、用哪些工具——灵活,适合开放问题与需要规模化模型决策的场景
- 两者都是 agentic systems;term 混用是常见混乱来源

使用原则:

- **先找最简单方案**:许多应用"优化单个 LLM 调用 + 检索 + 上下文示例"就足够;agentic 以延迟与成本换取任务性能,先评估权衡
- **框架警告**:从 LLM API 直接开始——模式只需几行代码;框架简化低层任务但遮蔽 prompt/响应、难调试、诱惑过度设计;"对底层代码的错误假设是客户错误的常见来源"
- agents 的实现形态:"基于环境反馈循环使用工具的 LLM"——每步从环境获取 ground truth(工具调用结果/代码执行)评估进展,检查点可暂停等人类反馈,需停止条件(如最大迭代数)维持控制
- 风险:自主 = 更高成本 + 错误复合(compounding errors);沙箱环境大量测试 + guardrails

三原则(Anthropic 自用):

1. 保持**简单性**
2. **透明性**——显式展示代理的规划步骤
3. 精心打磨 [[agent-computer-interface|ACI]]——工具文档与测试

定义演进(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):自本文之后,Anthropic 转向 [[simon-willison|Willison]] 的简洁定义——"LLMs autonomously using tools in a loop"——作为对 agents 的默认理解。

历史谱系(来源: [[2023-06-23-llm-powered-autonomous-agents|Weng 2023]]):三组件框架(规划/记忆/工具)是 agentic 架构的奠基分类——LLM 作为大脑 + 子目标分解 + 反思 + 外部向量记忆 + 工具调用;当时的三大挑战(有限上下文/长程规划/NL 接口可靠性)分别被 context engineering、规划技术演进、验证闭环与评测部分回应(见 [[lilian-weng]])。

产业代际(来源: [[2026-02-25-factory-model-coding-agents|Osmani 2026]]):AI 编码工具三代——①加速自动补全(你驱动、工具助)②同步代理(自然语言描述、你逐轮审改、代理是协作者)③自主代理(spec 进结果出、代理自己撞失败/修复/测试/部署、你定义结果并审结果);本 wiki 的 workflows-vs-agents 分类即第二代到第三代的过渡形态(见 [[factory-model]])。

## 与其他页面的关系

- 模式目录: [[agentic-workflow-patterns]];工具接口: [[agent-computer-interface]]
- 相关: [[parallel-agents]]、[[subagents]]、[[agent-verification]](ground truth 的检查来源)
- 评估基准: [[swe-bench]]
