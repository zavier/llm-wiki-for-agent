---
type: entity
tags: [organization, llm, agent-tools]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [anthropic, agent-readability, harness-engineering]
sources: [2026-02-11-codex-agent-first-engineering]
status: active
---

# OpenAI

前沿模型与智能体工具开发商(GPT 系列、Codex、Aardvark);与 [[anthropic]] 并列的代理工程实践另一大阵营。

## 关键信息

- 身份:AGI 研究公司;模型线 GPT-5/5.6(2026);编码代理 **Codex**(CLI + Agent SDK);Aardvark(另一智能体,参与同一代码库协作)
- 与 Anthropic 的对照:同出"harness engineering"话语(2026-02-11 也发 harness 工程文,见 [[2026-02-11-codex-agent-first-engineering]]),但实践立场有分歧——OpenAI 倾向**智能体对智能体评审 + 减少人类阻塞门**,Anthropic 文档更强调人类审查与验证闭环
- 工程文化信号:"不手动编写代码"实验(3-7 名工程师驱动 Codex 产出 100 万行);智能体可读性优先的仓库设计
- 与 [[anthropic]] 的竞争关系推动双方工程博客高产出,本 wiki 的实践文献主要来自这两家

## 与其他页面的关系

- 实验细节: [[2026-02-11-codex-agent-first-engineering]];概念: [[agent-readability]]
- 立场对照: [[anthropic]]、[[addy-osmani]](人工签字不可替代)
