---
type: source
tags: [context-engineering, ai-agents, memory]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Effective context engineering for AI agents (2026-08-02)

- 原文: `raw/Effective context engineering for AI agents.md`
- 类型: Anthropic 工程博客(Applied AI 团队:Prithvi Rajasekaran、Ethan Dixon、Carly Ryan、Jeremy Hadfield,另有贡献者多人;**原始发布日期:2025-09,据外部转载确认,具体日期待核实**;按剪藏日期归档)
- 备注: 原文含 2 张示意图(prompt vs context engineering;系统提示校准),正文文本已覆盖其内容

## 摘要

正式把 **context engineering** 定义为 prompt engineering 的自然演进:从"写对提示"转向"配置对的上下文状态"。用 context rot 与注意力预算解释为何上下文是有限资源;给出有效上下文的组件指导(系统提示的"正确高度"、最小可用工具集、典范示例);提出 just-in-time 检索范式;为超窗口的长时任务给出三技术:compaction、结构化笔记(agentic memory)、子代理架构。

## 关键主张

- **定义**:context engineering = 在 LLM 推理期间策展最优 token 集(系统提示、工具、MCP、外部数据、消息历史);prompt 是一次性写作,context 是每轮推理都要策展的迭代过程
- **context rot**(见 [[context-rot]]):token 数增加 → 模型召回能力下降;所有模型皆然,只是退化曲线陡缓不同;注意力预算是有限的,每个新 token 都在消耗
- **系统提示的"正确高度"**:脆弱的硬编码逻辑与过度笼统/假想共享上下文之间;分节(XML/Markdown);"minimal 不等于 short";先拿最好模型测最小 prompt,按失败模式增量补
- **最小可用工具集**:臃肿工具集导致选择歧义——"人类工程师都无法确定用哪个工具,代理更做不到";工具返回要 token 高效
- **示例策略**:精选多样化、典范性示例,而非罗列边界情况清单("example 是千言万语对应的图")
- **just-in-time 检索**:从嵌入预加载转向轻量标识 + 运行时工具动态加载(Claude Code 用 head/tail 分析大数据集,从不全量载入);元数据即信号;渐进式披露;混合策略(前置注入 + JIT,如 CLAUDE.md + glob/grep)
- **长时任务三技术**:compaction(总结重开,先保召回再提精度,最轻形态=工具结果清理)、[[agentic-memory|结构化笔记]](窗口外持久化,Claude plays Pokémon 为证)、子代理架构(独立探索,只回 1-2k token 摘要);按任务特性选择
- **定义演进**:Anthropic 转向 [[simon-willison|Willison]] 的简洁定义——"LLMs autonomously using tools in a loop"
- 总原则:"do the simplest thing that works";模型越强,规定性工程越少

## 与现有 wiki 的关系

- **重构了 [[context-engineering]]**(此前的页面基于 Osmani 摘要 + Claude Code 实践,本篇是其领域定义级来源)
- 更新了 [[subagents]](上下文技术视角)、[[simon-willison]](定义被官方采纳)、[[agentic-systems]](定义演进)、[[claude-md]](混合策略角色)、[[curse-of-instructions]](正确高度)、[[ai-feature-implementation-loop]](过载输入的机制证据)
- 新建:[[context-rot]]、[[agentic-memory]]
- 与前三篇源文档互补无矛盾;值得注意的跨源呼应:Willison 的代理定义(2025-09-18)被 Anthropic 官方采用

## 待办 / 后续

- 核实具体发布日期;track memory tool(公开 beta)的进展
- 找 Chroma 的 context rot 研究原文,记录量化曲线
- 找 Anthropic 多代理研究系统文章,补充子代理架构实证
