---
type: concept
tags: [testing, ai-agents, contracts]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [simon-willison, spec-driven-development, ai-agent-spec]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Conformance testing

语言无关的一致性测试套件(常为 YAML):规定期望输入/输出,任何实现必须全部通过——从 spec 直接导出的契约。

## 关键信息

- 比临时单元测试更严格:用例直接源于 spec,可跨实现复用;是"API 契约"而非"顺手测试"(来源: [[2026-01-13-good-spec-for-ai-agents]])
- 建议把一致性标准写进 spec 的 Success 节:"必须通过 conformance/api-tests.yaml 的全部用例"
- 由 [[simon-willison]] 倡导;与健壮测试套件一起构成"代理的超能力"——失败即可快速反馈迭代
- 在 [[spec-driven-development]] 中作为任务验收的客观标准,配合门禁流使用
- 自验证的加强版:spec 里写"这些样例输入应产生这些输出",代理可实际执行验证

## 与其他页面的关系

- 概念出处与倡导者: [[simon-willison]]
- 在 [[ai-agent-spec]] 中属于原则 4(自检);验收场景见 [[spec-driven-development]]
- 与 [[llm-as-a-judge]] 分工:前者管客观对错,后者管主观好坏
