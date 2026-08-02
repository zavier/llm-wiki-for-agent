---
type: concept
tags: [ai-agents, workflow, spec-writing]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, agents-md]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Spec-driven development

以 spec 为中心的工程流程:spec 驱动实现、检查清单与任务分解,每一阶段验证通过才进入下一阶段;防"house of cards code"。

## 关键信息

四阶段门禁流(来源: [[2026-01-13-good-spec-for-ai-agents]],GitHub Spec Kit 落地):

1. **Specify** — 你给高层描述(做什么、为什么、用户旅程、成功标准),AI 生成详细 spec;强调用户体验与成功指标,而非技术栈
2. **Plan** — 你给技术约束(栈、架构、合规、遗留系统),AI 生成技术方案;可要求多个方案对比
3. **Tasks** — AI 把 spec+plan 拆成小任务:每个任务可独立实现、独立测试——"创建用户注册端点并校验邮箱格式",而不是"构建认证"
4. **Implement** — 逐个/并行实现;人类在每个阶段验证:spec 是否符合意图?plan 是否覆盖约束?有无漏掉的边界情况?

要点:

- 每阶段任务如同对 AI 代理做 TDD;审查聚焦小改动而非千行代码
- spec 是"活的、可执行工件",与版本控制、CI/CD 绑定;变更自动传播到任务分解与测试
- 门禁:spec 未验证前代理不能前进
- 防止 Willison 所称 "house of cards code"——脆弱的 AI 输出在审视下崩塌

## 与其他页面的关系

- 总览: [[ai-agent-spec]]
- 任务验收的客观标准: [[conformance-testing]]
- 人设文件形态: [[agents-md]];实证来源: [[github]]
