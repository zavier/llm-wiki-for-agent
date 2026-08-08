---
type: entity
tags: [people, ai-engineering, open-source]
topic: ai-agents
created: 2026-08-08
updated: 2026-08-08
refs: [pi-coding-agent, context-engineering, harness-engineering, model-context-protocol, simon-willison, agent-computer-interface]
sources: [2025-11-30-opinionated-minimal-coding-agent]
status: active
---

# Mario Zechner

badlogic;libGDX 创始人,长期独立开发者;2025 年自建极简编码代理 pi(pi-mono),"极简 harness 学派"代表人物;本 wiki 运行环境 pi 的创造者。

## 关键信息

- 身份:libGDX(Java 游戏开发框架)创始人,笔名 badlogic;做过多个浏览器/代理类产品(如 Sitegeist,浏览器内 browser-use 代理)
- 2025-11-30 发表 [[2025-11-30-opinionated-minimal-coding-agent|What I learned building an opinionated and minimal coding agent]]:自建 pi 的完整复盘
- 使用史:ChatGPT 复制粘贴 → Copilot(对他无用)→ Cursor(一年半)→ Claude Code(2025-04 起)→ 自建 pi;对 Claude Code 的抱怨:80% 功能无用、每次发布改 system prompt/工具破坏工作流、闪屏、plan mode 审批地狱、子代理零可见性
- 核心立场:
  - **上下文工程 = 一切**,但"没有任何 harness 真的让你做上下文工程"——主流工具背后注入内容且不暴露;pi 的第一原则 = 完全控制 + 完全可观测
  - **极简主义**:"如果我用不到,它就不会被构建";四工具 + <1000 token 系统提示;反 MCP/to-do/plan mode/后台 bash/子代理(见 [[pi-coding-agent]])
  - **YOLO 安全观**:权限弹窗 = security theater;读数据+执行+联网三元组无解(引 [[simon-willison]] dual-LLM 自评);不介意就跑容器
- 构建动因呼应 Armin Ronacher《Agents are hard》(2025-11-21,lucumr.pocoo.org,未收录待核):直接用 provider SDK 而非 Vercel AI SDK 等统一层,获得完全控制与更小表面积
- 维护风格:开源项目"独裁式"维护,欢迎 fork 与贡献但保留关闭 issue/PR 的权利

## 与其他页面的关系

- 作品: [[pi-coding-agent]];哲学对照: [[harness-engineering]](富学派)、[[minimal-vs-rich-harness]](两派综合)
- 引用 [[simon-willison]] 的安全观;与 [[addy-osmani]] 同为独立实践者视角(Osmani 重纪律流程,Zechner 重控制与极简)
- 本 wiki 日常运行于其作品 pi 之上

## 演变 / 争议

- 与 Anthropic/Osmani/HumanLayer 的"富 harness"学派多处正面分歧(子代理、MCP、plan mode、to-do、权限),均已在对应概念页标注 callout;无事实性矛盾
