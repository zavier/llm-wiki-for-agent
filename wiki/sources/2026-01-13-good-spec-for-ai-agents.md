---
type: source
tags: [ai-agents, spec-writing, prompt-engineering]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# How to write a good spec for AI agents (2026-01-13)

- 原文: `raw/How to write a good spec for AI agents.md`
- 类型: 博客文章(作者自述排版由 Gemini 辅助,配图为 Nano Banana Pro 生成)
- 作者: [[addy-osmani]],发布在 addyosmani.com/blog/good-spec/

## 摘要

面向 AI 编码代理(Claude Code、Gemini CLI 等)的 spec 写作框架。核心论点:巨型 spec 会撞上 context window 限制与模型的"注意力预算",好 spec 应该清晰、聚焦、可演化。文章给出五原则、六大核心区域清单、三层边界系统与反模式清单,主张 spec 驱动的工程流程。

## 关键主张

- 原则 1:**高层愿景先行**——先给简洁 goal,让 AI 扩写成详细 spec;用 Plan Mode(只读)强制先规划后编码;spec 成为人与 AI 共享的事实源
- 原则 2:**按 PRD/SRS 结构化**——GitHub 对 2,500+ 代理配置文件的分析显示,有效 spec 覆盖六区域:commands / testing / project structure / code style / git workflow / boundaries
- 原则 3:**模块化优于巨型 prompt**——"curse of instructions"研究证明指令越多遵循越差;用扩展 TOC 摘要、子代理、并行代理把上下文切小
- 原则 4:**内置自检与人类专长**——三层边界(Always/Ask first/Never)、自验证清单、[[llm-as-a-judge]]、[[conformance-testing|一致性测试]]、注入领域知识("把导师经验写进 spec")
- 原则 5:**测试-迭代-演化**——spec 是活文档,测试失败即修正 spec;配合 RAG/MCP 上下文工具
- 反模式:模糊提示、超长上下文不摘要、跳过人工审查、把 [[vibe-coding]] 当生产工程、忽视 [[lethal-trifecta|致命三要素]]、漏掉六区域

## 与现有 wiki 的关系

- 本 wiki 第一篇源文档,全部相关页面为新建:[[ai-agent-spec]]、[[spec-driven-development]]、[[agents-md]]、[[three-tier-boundaries]]、[[context-engineering]]、[[curse-of-instructions]]、[[conformance-testing]]、[[llm-as-a-judge]]、[[vibe-coding]]、[[lethal-trifecta]]
- 实体:[[addy-osmani]](作者)、[[simon-willison]](被反复引用)、[[github]](实证研究来源)、[[anthropic]](工具与模式来源)
- 无与既有页面的冲突(此前无页面)

## 待办 / 后续

- 找 "curse of instructions" 原始论文(openreview 链接在文中),核实其适用范围与实验规模
- 找 GitHub 2,500+ agents.md 分析原文,提取六区域的具体统计口径
- 读 Willison 的 vibe engineering 文章(2025-10),确认"写文档先行"论点的上下文
- 关注 Addy Osmani 的新书《AI-assisted engineering》(O'Reilly),可作为后续源文档
