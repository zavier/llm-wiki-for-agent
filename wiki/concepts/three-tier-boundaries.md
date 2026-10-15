---
type: concept
tags: [ai-agents, guardrails]
topic: ai-agents
created: 2026-08-02
updated: 2026-10-15
refs: [ai-agent-spec, agents-md, governance-as-code]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-21-ai-native-sdlc-playbook]
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

**边界的可执行化(hook 三层映射)**(来源: [[2026-08-21-ai-native-sdlc-playbook]],Anthropic):三层边界在工具层有直接映射——**Always → `permissions.allow`**(预批准安全内环,防止 deny 列表变成 prompt 疲劳)、**Ask first → ask hook**(批准提示放在 gates 而非 build,避免人重新进入并行会话的关键路径)、**Never → deny + managed settings**(不可被本地配置放宽:`allowManagedPermissionRulesOnly`);边界从"写给代理的建议"升级为"系统替代理执行的策略"——skill 建议层 + hook 确定层的双层控制(见 [[governance-as-code]])。原三层是**表达格式**,hook 是**执行机构**

## 与其他页面的关系

- 是 [[ai-agent-spec]] 原则 4 的组成;常与 [[agents-md]] 一起落地
- 与 [[conformance-testing]] 互补:边界管"别做什么",一致性测试管"做对没有"
