---
type: entity
tags: [product, harness, ai-agents, open-source]
topic: ai-agents
created: 2026-08-08
updated: 2026-08-08
refs: [mario-zechner, context-engineering, harness-engineering, model-context-protocol, plan-mode, subagents, progressive-disclosure, agent-computer-interface, long-running-agents, parallel-agents, claude-code]
sources: [2025-11-30-opinionated-minimal-coding-agent]
status: active
---

# pi (coding agent)

[[mario-zechner|Zechner]] 自建的极简编码代理 harness:"极简派"的完整产品化——四工具 + <1000 token 系统提示、YOLO 默认、文件即状态;Terminal-Bench 2.0 上榜;本 wiki 的日常运行环境。

## 关键信息

**架构**(pi-mono monorepo 四包):

- pi-ai:统一 LLM API(Anthropic/OpenAI/Google/xAI/Groq/Cerebras/OpenRouter/任意 OpenAI-compatible 端点);流式、TypeBox 工具 schema、thinking、跨提供商上下文交接、token/成本跟踪(尽力而为——提供商 token 报告"狂野西部",无唯一 ID 可对账账单)
- pi-agent-core:代理循环(工具执行/校验/事件流);**无 max steps 旋钮**("从没遇到需要它的用例");消息排队(每轮回调注入)
- pi-tui:scrollback 原生 TUI(非全屏接管);retained mode 组件 + **差分渲染**(只重绘首个差异行起);同步输出转义(CSI ?2026h/l)防闪屏
- pi-coding-agent:CLI 组装——会话管理(continue/resume/branch)、AGENTS.md 全局→项目层级加载、slash commands(自定义模板)、Claude Pro/Max OAuth、主题热重载、模糊搜索编辑器、headless JSON streaming/RPC、HTML 导出、成本跟踪

**哲学偏差**(全部有意为之):

| 不做 | 替代方案 | 理由 |
|---|---|---|
| 富系统提示 | <1000 tokens + 注入 AGENTS.md | 前沿模型 RL 后天生懂编码代理 |
| 多工具 | read/write/edit/bash 四件套(+可选只读 grep/find/ls) | 模型对相同 schema 有训练;Codex 同样极简 |
| 权限弹窗/安全检查 | YOLO 默认 | security theater;能力三元组无解 |
| 内建 to-do | TODO.md(checkbox) | 列表给模型加状态负担 |
| Plan mode | PLAN.md(Goal/Approach/Current Step)+ 全观测 | 文件可跨会话、可版本化 |
| MCP | CLI 工具 + README 按需读;mcporter 包装 | 上下文税(7-9% 窗口) |
| 后台 bash | tmux | 可观测、可人机协同调试 |
| 子代理 | 独立会话产工件;`pi --print` 自派生 | 黑箱;并行子代理 = 反模式 |
| 内建 compaction | 无(issue #92 待办) | 个人单会话数百轮无压力 |

**证据**:Terminal-Bench 2.0 五轮/任务跑分(Claude Opus 4.5,可提交 leaderboard;gist f45e8f6e481e5ab7d3a50659da84edaa);bench runner 开源(pi-terminal-bench);第二跑仅限 CET——错误率在 PST 上线后变差

## 与其他页面的关系

- 哲学对照: [[minimal-vs-rich-harness]](综合)、[[harness-engineering]](富学派)、[[claude-code]](被比较对象)
- 概念落点: [[context-engineering]](完全控制论)、[[progressive-disclosure]](CLI-README)、[[agent-computer-interface]](输出双通道)、[[model-context-protocol]](反论)、[[plan-mode]](反论)、[[subagents]](替代)、[[long-running-agents]](to-do 张力)
- 本 wiki 即运行于 pi:当前会话的系统提示与四工具与 2025-11-30 文章逐字吻合(含"Be concise in your responses"等)

## 演变 / 争议

- 与主流 harness 的正面分歧均属设计立场;维护者独裁式(欢迎 fork);Armin Ronacher《Agents are hard》为其统一 API 取舍的动机参照(待收录)
