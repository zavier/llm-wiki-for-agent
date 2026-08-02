---
type: entity
tags: [people, ai-engineering]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [conformance-testing, lethal-trifecta, vibe-coding, agentic-systems, agent-management, agent-verification, agentic-engineering]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-effective-context-engineering-for-ai-agents, 2026-01-08-coding-agents-manager, 2026-02-04-agentic-engineering]
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
- **代理定义被官方采纳**:2025-09-18 博文提出简洁定义——"LLMs autonomously using tools in a loop",Anthropic 在 [[2026-08-02-effective-context-engineering-for-ai-agents|context engineering 文章]] 中明确转向该定义(行业术语收敛的例证)
- **并行代理的评审瓶颈论**(来源: [[2026-01-08-coding-agents-manager]],Osmani 转述):2025-10-05 parallel-coding-agents 文——自然瓶颈不是生成代码,是**评审它**;并行任务有价值,前提是对注意力带宽诚实、选不超载大脑的任务;被 Osmani 引为"并行代理生活方式的怀疑视角"锚点(与 [[agent-management]] 的 WIP 上限互证)
- **vibe engineering 术语提案**(来源: [[2026-02-04-agentic-engineering]],Osmani 转述):2025-10-07 文提出"vibe engineering"为纪律化 AI 开发命名(重拾 vibe 加 engineering 表纪律);Osmani 认为 "vibe" 负资产太重未采纳,最终用 Karpathy 的 agentic engineering(见 [[agentic-engineering]])

## 与其他页面的关系

- 详见 [[conformance-testing]]、[[lethal-trifecta]]、[[vibe-coding]]
- 与 [[addy-osmani]] 的 spec 框架相互印证
