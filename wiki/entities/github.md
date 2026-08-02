---
type: entity
tags: [organization, ai-engineering]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agents-md, spec-driven-development]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# GitHub

微软旗下的代码托管与协作平台;在 AI 代理规范领域提供了两份被广泛引用的实证研究与工具。

## 关键信息

- **2,500+ 仓库分析**(Copilot 团队):"大多数 agent 文件失败是因为太模糊";有效 spec 覆盖六大核心区域(commands/testing/structure/style/git/boundaries);最常出现且最有效的约束是"绝不提交 secrets"(来源: [[2026-01-13-good-spec-for-ai-agents]])
- **Spec Kit**:开源工具包,把 [[spec-driven-development]] 落成四阶段门禁工作流,spec 成为与版本控制、CI/CD 绑定的可执行工件
- **GitHub Copilot**:支持 [[agents-md|agents.md]] 定义专职代理人格(@docs-agent、@test-agent、@security-agent 等)
- GitHub AI 团队推广 spec-driven development:spec 是"共享事实源……活的、可执行的工件,随项目演化"

## 与其他页面的关系

- 实证依据支撑 [[ai-agent-spec]] 的六区域清单与 [[three-tier-boundaries|三层边界]]
- 详见 [[agents-md]]、[[spec-driven-development]]
