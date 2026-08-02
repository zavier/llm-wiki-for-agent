---
type: concept
tags: [ai-agents, workflow, planning]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, ai-agent-spec, spec-driven-development]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents]
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

## 与其他页面的关系

- 工具: [[claude-code]];流程对应: [[spec-driven-development]];总框架: [[ai-agent-spec]]
