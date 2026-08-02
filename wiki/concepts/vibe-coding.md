---
type: concept
tags: [ai-agents, development-practice]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [simon-willison, lethal-trifecta, ai-agent-spec]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Vibe coding

靠直觉与快速迭代让 AI 写代码的原型化开发方式;适合探索与一次性项目,但不应与生产工程混淆。

## 关键信息

- 定义:快速原型/探索性开发的模式,低纪律、高迭代(来源: [[2026-01-13-good-spec-for-ai-agents]])
- 与 **AI-assisted engineering** 的区别:后者需要 spec、测试、审查的完整纪律——"知道自己在哪种模式"是关键
- 风险:无纪律地把 vibe 代码直接上生产 = 自找麻烦;叠加 [[lethal-trifecta]] 后更危险
- 相关变体:"vibe engineering"(Willison)——先写好文档,模型可能仅凭文档生成匹配实现;这其实是"文档先行"的工程化版本
- Osmani 立场:原型用 vibe 没问题,上线必须切回工程模式

## 与其他页面的关系

- 管理/风险视角: [[lethal-trifecta]]、[[simon-willison]]
- 工程化替代路径: [[ai-agent-spec]]、[[spec-driven-development]]
