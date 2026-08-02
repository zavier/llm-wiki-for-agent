---
type: source
tags: [ai-agents, agentic-systems, workflows]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Building Effective AI Agents (2026-08-02)

- 原文: `raw/Building Effective AI Agents.md`
- 类型: Anthropic 工程博客文章(作者: Erik Schluntz 与 Barry Zhang;原文 anthropic.com/engineering/building-effective-agents;**原始发布日期未标注,约 2024 年末,待核实**;按剪藏日期归档)
- 备注: 原文含 7 张架构示意图(增强 LLM、五种 workflow、自主代理、编码代理流程),正文文本已完整覆盖其内容

## 摘要

基于与数十个团队合作的经验:最成功的实现**不用复杂框架,而是简单、可组合的模式**。提出 agentic systems 的架构分类——workflows(预定义代码路径)vs agents(LLM 动态主导);从增强 LLM 构建块逐级介绍五种工作流模式;给出三原则(简单性、透明性、精心打磨 ACI);附录覆盖实践领域(客服/编码)与工具提示工程。

## 关键主张

- **workflows vs agents 的架构区分**:workflows 是"LLM 与工具通过预定义代码路径编排";agents 是"LLM 动态主导自身流程与工具使用,掌控如何完成任务"
- **先找最简单方案**:许多应用"优化单个 LLM 调用 + 检索 + 上下文示例"就足够;agentic 系统以延迟与成本换取任务性能,需评估权衡
- **框架警告**:从 LLM API 直接开始;框架抽象遮蔽底层 prompt 与响应、难调试,且诱惑过度设计;"对底层代码的错误假设是客户错误的常见来源"
- **五种工作流模式**:prompt chaining(链式 + 门)、routing(分类路由,易→Haiku/难→Sonnet 分级)、parallelization(sectioning 拆解 / voting 投票)、orchestrator-workers(中央 LLM 动态拆解委派)、evaluator-optimizer(生成-评估循环)
- **agents 的实现形态**:"基于环境反馈循环使用工具的 LLM"——每步从环境获取 ground truth(工具结果/代码执行),检查点可暂停等人类反馈,需停止条件(最大迭代数)维持控制
- **自主代理风险**:更高成本、错误复合(compounding errors);建议沙箱环境大量测试 + guardrails
- **三原则**:①保持简单 ②透明性——显式展示代理的规划步骤 ③精心打磨 [[agent-computer-interface|ACI]]——工具文档与测试;SWE-bench 代理"花在优化工具上的时间比整体 prompt 更多"
- **工具格式建议**:给模型足够 token"思考";格式贴近互联网自然文本;无格式开销(数行数、JSON 转义);poka-yoke 让工具难以误用(例:强制绝对路径)
- **编码是最佳代理应用之一**:答案可被自动化测试验证、可迭代、问题空间结构化、产出可客观度量;但人类审查仍必要

## 与现有 wiki 的关系

- 更新了 [[anthropic]]、[[model-context-protocol]](增强 LLM 实现路径)、[[parallel-agents]](sectioning/voting)、[[llm-as-a-judge]](evaluator-optimizer)、[[agent-verification]](ground truth)、[[lethal-trifecta]](错误复合/模型分级路由)、[[ai-feature-implementation-loop]](SWE-bench 实证)
- 新建:[[agentic-systems]]、[[agentic-workflow-patterns]]、[[agent-computer-interface]]、[[swe-bench]]
- 跨源术语对应:ACI ↔ Osmani 的 AX(Agent Experience);ground truth ↔ Claude Code 最佳实践的"验证检查";routing 模型分级 ↔ 致命三要素的成本缓解
- 与前两篇源文档无矛盾,互补

## 待办 / 后续

- 核实原始发布日期(搜索未确认)
- 深挖 [[swe-bench|SWE-bench Verified]] 基准构成与当前成绩
- 找 cookbook 中五种模式的实现示例,对照本文模式逐一验证
