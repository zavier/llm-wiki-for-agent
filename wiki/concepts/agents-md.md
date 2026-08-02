---
type: concept
tags: [ai-agents, configuration]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [github, three-tier-boundaries, ai-agent-spec]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# agents.md

仓库内配置文件,定义 AI 代理(如 GitHub Copilot)的行为规范与专职人格;本质是"为代理写的 spec"。

## 关键信息

- GitHub 分析了 2,500+ 仓库的 agent 文件(来源: [[2026-01-13-good-spec-for-ai-agents]]),发现:**大多数因太模糊而失败**;有效者覆盖 [[ai-agent-spec|六大核心区域]]
- 用途:定义专职代理人格——@docs-agent(技术写作)、@test-agent(QA)、@security-agent(代码审查);每份文件是"该人格的聚焦 spec":行为、命令、边界
- 适合"不同任务用不同代理"而非一个万能助手
- 与 [[three-tier-boundaries]] 结合:边界层级明确后代理决策更稳
- 相关形态:Anthropic 的 Skills(可复用 Markdown 行为定义)、Claude Code 子代理(独立 system prompt 与上下文窗口)

## 与其他页面的关系

- 实证与研究来源: [[github]]
- 内容规范: [[ai-agent-spec]];边界: [[three-tier-boundaries]]
