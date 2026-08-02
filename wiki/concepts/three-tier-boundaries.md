---
type: concept
tags: [ai-agents, guardrails]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, agents-md]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Three-tier boundaries

AI 代理规范中的三层边界系统:比单一"禁止清单"更能指导代理何时自主行动、何时请示、何时硬停。

## 关键信息

三层定义(来源: [[2026-01-13-good-spec-for-ai-agents]],GitHub 2,500+ 配置文件分析):

- ✅ **Always do** — 无需询问直接做:"提交前总是跑测试""总按风格指南命名""总把错误记入监控"
- ⚠️ **Ask first** — 需人工批准:"改数据库 schema 前请示""加依赖前请示""改 CI/CD 配置前请示"——拦截高影响但未必有问题的变更
- 🚫 **Never do** — 硬性禁止:"绝不提交 secrets/API keys""绝不编辑 node_modules/""未获批准绝不删失败测试"

要点:

- 实证:最有效的 spec 用三层而非简单 don't 列表;"never commit secrets"是研究中**最常出现且最有效**的约束
- 效果:代理对 Always 自信推进、对 Ask first 挂起标记、对 Never 硬停,决策负担变小
- 更细粒度的边界沟通:把边界写进 spec 不如用真实示例锚定(边界 + 示例格式)

## 与其他页面的关系

- 是 [[ai-agent-spec]] 原则 4 的组成;常与 [[agents-md]] 一起落地
- 与 [[conformance-testing]] 互补:边界管"别做什么",一致性测试管"做对没有"
