---
type: entity
tags: [people, ai-engineering]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [conformance-testing, lethal-trifecta, vibe-coding]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Simon Willison

独立开发者、AI 工程评论家(博客 simonwillison.net),"AI 代理管理"思想的重要来源,被 [[2026-01-13-good-spec-for-ai-agents|Osmani 的 spec 指南]] 反复引用。

## 关键信息

- "house of cards code":AI 生成的代码看似坚固,遇到未测的边界情况就会崩塌——防它要靠门禁式流程与审查
- "先写好文档,模型可能仅凭文档就生成匹配的实现"(vibe engineering 文章,2025-10)
- 倡导 [[conformance-testing|一致性测试]]:语言无关的 YAML 契约测试,任何实现必须全部通过
- 提出 [[lethal-trifecta|致命三要素]]:速度、非确定性、成本——AI 代理危险的三个属性
- 管理隐喻:让编码代理出成果"近似管理人类实习生";并行代理"出奇地有效,但精神上很累"
- 个人规则:"我不会提交我无法向别人解释的代码"——AI 产出通过测试 ≠ 正确/安全/可维护
- 观点:版本控制习惯在 AI 辅助下更重要;模型读 git diff 能力很强

## 与其他页面的关系

- 详见 [[conformance-testing]]、[[lethal-trifecta]]、[[vibe-coding]]
- 与 [[addy-osmani]] 的 spec 框架相互印证
