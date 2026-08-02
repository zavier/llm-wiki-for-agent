---
type: concept
tags: [ai-agents, spec-writing]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [spec-driven-development, curse-of-instructions, three-tier-boundaries, agents-md, context-engineering, conformance-testing, llm-as-a-judge, agent-verification, plan-mode, factory-model, intent-debt]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-02-25-factory-model-coding-agents, 2026-06-05-intent-debt]
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
- **具体化提示四策略**(来源: [[2026-08-02-best-practices-claude-code]]):scope 任务(指定文件/场景/测试偏好,如"覆盖登出用户的边界情况,避免 mock");指向源码("翻 ExecutionFactory 的 git 历史,总结其 API 由来");参照既有模式("照 HotDogWidget.php 的模式实现日历组件,只用现有库");描述症状(现象 + 可能位置 + "修好"长什么样)
- **采访式开局**:大功能先让 Claude 用 AskUserQuestion 采访你(技术实现、UI/UX、边界、取舍),产出 SPEC.md 后**开新会话**执行——干净上下文 + 书面 spec;spec 自包含:点名文件与接口、声明 out of scope、以端到端验证步骤收尾
- **验证先行**:prompt 里直接给示例测试用例("validateEmail:[user@example.com] 为 true,[user@.com] 为 false"),让代理实现后跑测试
- 模糊提示也有用武之地:探索阶段("这个文件有什么可改进的?")能带出你没想到的问题
- **Spec 即杠杆**(来源: [[2026-02-25-factory-model-coding-agents]]):舰队规模(20-50 代理并行)下,平庸 vs 优秀输出的差距几乎全在 spec 质量——**模糊想法乘法式放大**(含糊需求在几十个并行运行里各自偏一点,糟糕架构决策传遍舰队);"spec 不再是 prompt,是产品思维的外显";代理无法澄清从未给它的需求,会用假设填补,假设会复合(见 [[factory-model]])
- **Spec 写意图而非实现**(来源: [[2026-06-05-intent-debt]]):spec 的首要职责是承载代码自己承载不了的意图——目标/约束/不可妥协项/显式 done(快、可访问、安全、愉悦,超越"功能正确");"无法捕捉全部意图不是捕捉零的许可证":spec 列不完隐性决策,但**承重决策的 why 必须记录**,因为 AI 会把意图空白填成合理猜测(见 [[intent-debt]])

## 与其他页面的关系

- 落地闭环综合(如何让 AI 更好实现功能): [[ai-feature-implementation-loop]]
- 执行流程: [[spec-driven-development]]
- 边界系统: [[three-tier-boundaries]]
- 人格/配置文件: [[agents-md]]
- 上下文管理: [[context-engineering]]、[[curse-of-instructions]]
- 质量门: [[conformance-testing]]、[[llm-as-a-judge]]
