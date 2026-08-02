---
type: concept
tags: [ai-agents, risk]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [simon-willison, vibe-coding, agentic-workflow-patterns]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-building-effective-ai-agents]
status: active
---

# Lethal trifecta

[[simon-willison|Willison]] 提出的 AI 代理三种危险属性组合:速度、非确定性、成本——单独无害,合起来致命。

## 关键信息

三个属性(来源: [[2026-01-13-good-spec-for-ai-agents]]):

1. **速度** — 代理产出快过你审查的速度,审查成为瓶颈
2. **非确定性** — 相同输入、不同输出,难以复现与归因
3. **成本** — 便宜的迭代鼓励在验证环节偷工减料("省掉测试再跑一次")

应对原则:

- spec 与审查流程必须**同时**针对三者设计:速度→门禁/分阶段审查;非确定性→版本控制 + 日志追踪 + 一致性测试锚定;成本→模型分级(便宜模型做重复活,顶级模型做关键推理),并控制上下文 token 预算
- 忽视它是 [[vibe-coding]] 上生产的主要事故源
- 工程化印证(来源: [[2026-08-02-building-effective-ai-agents]]):Anthropic 明确把**错误复合(compounding errors)**列为自主代理的主要风险(非确定性的多步放大);其 **routing** 模式(easy→Haiku/难→Sonnet 分级)是成本维度的标准缓解——与 Osmani 的模型分级建议一致(见 [[agentic-workflow-patterns]])

## 与其他页面的关系

- 出处: [[simon-willison]];关联实践: [[vibe-coding]]
- 缓解工具: [[conformance-testing]]、[[spec-driven-development]]
