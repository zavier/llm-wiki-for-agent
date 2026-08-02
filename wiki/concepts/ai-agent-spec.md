---
type: concept
tags: [ai-agents, spec-writing]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [spec-driven-development, curse-of-instructions, three-tier-boundaries, agents-md, context-engineering, conformance-testing, llm-as-a-judge]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# AI agent spec

写给 AI 编码代理的规范文档:清晰、聚焦、可演化,避免巨型 prompt 导致的上下文过载与"注意力预算"耗尽。

## 关键信息

五原则(来源: [[2026-01-13-good-spec-for-ai-agents]]):

1. **高层愿景先行**——先给 goal 与核心需求,让 AI 扩写成详细 spec;Plan Mode 强制规划先行;spec 成为唯一事实源
2. **按 PRD/SRS 结构化**——覆盖六大核心区域
3. **模块化任务**——一次一个聚焦问题,配合扩展 TOC 摘要与子代理
4. **内置自检**——三层边界、自验证清单、LLM-as-a-Judge、一致性测试、注入人类领域知识
5. **测试-迭代-演化**——spec 是活文档,失败即修正 spec 再继续

**六大核心区域清单**(GitHub 2,500+ 配置文件实证):

| 区域 | 要点 |
|---|---|
| Commands | 完整命令含 flags(`npm test`、`pytest -v`),代理会反复引用 |
| Testing | 怎么跑、什么框架、测试放哪、覆盖率期望 |
| Project structure | 明确 `src/`、`tests/`、`docs/` 各放什么 |
| Code style | 一个真实代码示例胜过三段描述;命名、格式、好输出范例 |
| Git workflow | 分支命名、commit 格式、PR 要求 |
| Boundaries | 绝不碰的区域;"never commit secrets"是最常见有效约束 |

- **具体化技术栈**:说"React 18 + TypeScript + Vite + Tailwind CSS",别说"React 项目";含版本与关键依赖。模糊 spec 产生模糊代码
- **结构化格式**:Markdown 标题或 XML 标签分节,LLM 对结构化文本处理明显更好;"minimal 不等于 short"
- **goal-oriented**:初期多写 what/why(用户是谁、要什么、成功长什么样),少写 how
- **匹配任务复杂度**:不过度规范简单任务(如"居中一个 div"),不欠规范复杂任务(如 OAuth 流程)
- 用 in-line TODO 注释把代码变成 mini-spec,让代理逐个填充

## 与其他页面的关系

- 落地闭环综合(如何让 AI 更好实现功能): [[ai-feature-implementation-loop]]
- 执行流程: [[spec-driven-development]]
- 边界系统: [[three-tier-boundaries]]
- 人格/配置文件: [[agents-md]]
- 上下文管理: [[context-engineering]]、[[curse-of-instructions]]
- 质量门: [[conformance-testing]]、[[llm-as-a-judge]]
