---
type: concept
tags: [evaluation, llm]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, anthropic]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# LLM-as-a-judge

用第二个 LLM(或独立 prompt)评审第一个代理的输出,针对难以自动测试的主观标准:代码风格、可读性、架构模式遵循。

## 关键信息

- 适用场景:语法检查覆盖不到的**语义/主观评估**(来源: [[2026-01-13-good-spec-for-ai-agents]])
- 典型用法:"对照我们的风格指南审查这段代码,标记违规";评审反馈要么被采纳、要么触发重写
- 与自验证互补:自验证(把输出对照 spec 要求清单逐项核对)抓"遗漏",judge 抓"主观质量"
- Anthropic 等团队已证实其对手写评估的有效性(同源引用)
- 是 [[ai-agent-spec]] 质量门的一环;可用便宜/小模型承担评审角色以降本

## 与其他页面的关系

- 见 [[ai-agent-spec]] 原则 4;实践方: [[anthropic]]
- 与 [[conformance-testing]] 分工:一致性测试管"对错",judge 管"好坏"
