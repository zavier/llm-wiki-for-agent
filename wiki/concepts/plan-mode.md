---
type: concept
tags: [ai-agents, workflow, planning]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, ai-agent-spec, spec-driven-development, pi-coding-agent]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents, 2025-11-30-opinionated-minimal-coding-agent]
status: active
---

# Plan mode

Claude Code 的只读规划模式:把探索与研究从实现中分离,避免解决错误的问题;是"先规划后编码"的工具化。

## 关键信息

- 机制:只读分析代码库、产出计划,不写码;对齐后才执行(来源: [[2026-08-02-best-practices-claude-code]])
- 推荐工作流四阶段:探索 → 规划 → 执行 → 验证——与 [[spec-driven-development]] 的 Specify→Plan→Tasks→Implement 同构
- **何时跳过**:能一句话描述 diff 的小任务(改 typo、加日志行、重命名变量)直接做——plan mode 有开销
- **何时使用**:方法不确定、改动跨多文件、不熟悉要改的代码
- 在 [[2026-01-13-good-spec-for-ai-agents|Osmani 指南]] 中:规划先行 + 让代理提问澄清,直到"没有误解空间"才执行;Claude Code 中为 Shift+Tab 切换

**反论:PLAN.md 文件化**(来源: [[2025-11-30-opinionated-minimal-coding-agent]],[[pi-coding-agent]]):极简派认为内建 plan mode 不必要——"让代理和你一起思考问题而不改文件"就够;跨会话规划应写进 PLAN.md(Goal/Approach/Current Step)——可跨会话共享、可版本控制、可协同编辑,且**全程可观测**(你能看到代理读了哪些源、漏了哪些;Claude Code 的 plan mode 在编排子代理时零可见性);只读限制用 `pi --tools read,grep,find,ls` 实现,而非内置模式。

> [!warning] 学派分歧:内建 Plan Mode([[claude-code]]) vs PLAN.md 文件化(pi)——前者把规划锁进会话内工具,后者把规划变成仓库工件;分歧在"规划是否该被工具化强制"与"可观测性优先还是工具化优先"(见 [[minimal-vs-rich-harness]])。

## 与其他页面的关系

- 工具: [[claude-code]];流程对应: [[spec-driven-development]];总框架: [[ai-agent-spec]]
