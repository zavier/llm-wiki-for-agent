---
type: source
tags: [ai-agents, orchestration, conductor, addy-osmani, roles]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# The Future of Agentic Coding: Conductors to Orchestrators (2026-01-02)

- 原文: `raw/The future of agentic coding_ conductors to orchestrators.md`
- 类型: 技术博客([[addy-osmani]],发布于 **2026-01-02**,frontmatter 已标注;Elevate 平台同步发表)
- 备注: 本 wiki 第二十六篇源文档;**conductor/orchestrator 分类学的原始定义**(2026-03 的 [[2026-03-26-code-agent-orchestra|Code Agent Orchestra]] 演讲即此文的展开);Osmani 2026 写作弧线的起点(future-agentic-coding 1 月 → factory-model 2 月 → orchestra 3 月 → harness 4 月 → agent-skills 5 月 → intent-debt/loop 6 月);背景数据(90% 工程师用 AI 编码、10+ PR/天)均为二手无出处,待核

## 摘要

AI 编码助手已从新奇变成必需(最高 90% 软件工程师用某种 AI 编码,二手待核);新范式是**自主编码代理舰队**,工程师角色从 implementer → manager,从 coder → conductor → 最终 orchestrator——"我该怎么写这段代码?" → "我怎么让正确的代码被写出来?"。Conductor = 与单个代理紧密同步协作(指挥家引导独奏者;人在环内逐步动态转向;GPS 式导航);**关键:大部分交互是 ephemeral 的**(会话结束、未捕获进代码的上下文与决策即丢失)。Orchestrator = 管理整个乐团(多代理并行;设定高层目标与任务,代理自主执行;人聚焦协调/质量控制/集成;异步、前台→后台;**跟踪式持久工作流**——分支/提交/PR 留在版本控制里,"git 痕迹";并发)。两角色是光谱两端而非刚性分类,同一个人可随时切换。

## 关键主张

**Conductor 工具**(2026-01 snapshot):Claude Code CLI(你触发每个动作、立即评审输出)、Gemini CLI(超大上下文窗口、规划+编码、一次一个)、Cursor(深度上下文集成——索引整个代码库)、VSCode/Cline/Roo Code(持续人工引导);生产率提升明显,但**本质是单代理、同步**

**Orchestrator 工具**(2026-01 snapshot):GitHub Copilot Coding Agent(GH Actions 临时环境、开 PR 带描述与有意义的 commit 消息、@copilot 迭代、自动化簿记)、Jules(云 VM 克隆代码库、**计划先呈现批准后执行**、transparency/control/user steerability、音频 changelog、并发多任务)、OpenAI Codex 云代理(并行多任务、沙箱容器、npm CLI、ChatGPT 手机 app 通知、**Slack 邀请 @Codex 派活**、\"实时协作与异步委派无缝切换\")、Claude Code for Web(托管版、**teleport 功能**把会话传回本地、文件系统/网络隔离——\"自主性 + 安全\")、Cursor 2.0 Background Agents(多代理界面、隔离分支端到端执行、桌面/手机实时仪表盘)、Conductor by Melty Labs(名字反讽、worktree+dashboard)、Claude Squad(tmux 多路复用)、Azure AI Foundry(Build 2025 宣布代理编排 SDK,agent-to-agent 通信)

**五轴对比**:

| 维度 | Conductor | Orchestrator |
|---|---|---|
| 控制范围 | 微观:单代理单任务 | 宏观:多代理/多步项目 |
| 自主度 | 低:每步等提示 | 高:内部计划并执行几十步 |
| 同步性 | 同步实时循环 | 异步(像长 CI 任务) |
| 工件与可追溯性 | 大量交互未显式记录 | 分支/commit/PR 持久保存——\"留下 git 痕迹,团队可见甚至可自己触发\" |
| 人力分布 | 几乎 100% 时间在场 | 前载(写好任务描述/spec)+ 后载(评审测试),中间几乎不用——\"以广度吞吐换细粒度控制\" |

**角色流动**:同一开发者此刻是 conductor 下一刻是 orchestrator;工具也在模糊界线(Codex 的无缝切换);\"光谱的两端,中间是大量混合工作流\"

**为什么重要**:自主编码代理是下一个抽象层(汇编 → 高级语言 → 框架 → 自动补全 → 自主代理);想象 80-90% 代码由 AI 起草、人类提供 10% 关键指导与监督——不是替代工程师,是**提升到战略监督角色**;\"每个工程师都以某种程度成为 AI 开发者们的经理\"(人人有一支个人初级工程师团队);高需求技能:规划、prompt 工程、验证、监督

**\"AI 团队\"专业化流水线**(愿景,已有早期迹象):Planning Agent(拆任务)→ Coding Agent(s)(实现)→ Testing Agent(生成运行测试)→ Code Review Agent(评审 PR)→ Documentation Agent(更新文档)→ Deployment/Monitoring Agent(发布+盯生产);人 = 全流程监督与编排(批计划、解决冲突、最终部署批准);早期迹象:Azure AI Foundry、公司内部实验(代理评审代理的 PR,\"AI/AI 互动、人最后在环\")、Claude Squad + 脚本链、MCP 作为代理共享状态/通信标准

**六大挑战**:

1. **质量控制与信任**:人眼没有盯每个改动——bug/设计缺陷可能溜过;人工监督仍是最终保险;\"developers maintain expertise to evaluate AI outputs\"(Stack Overflow CTO 引述)+ 需要新\"信任模型\";知道**何时介入 vs 何时信任代理计划**是编排技能的一部分
2. **协调与冲突**:工作区隔离(git 分支/独立环境)+ 一代理一任务 + 最小化重叠;未来或由代理间协商协议解决,今天由 orchestrator 划边界
3. **上下文/共享状态/交接**:多代理需要共享上下文/记忆/平滑过渡;没有统一的\"工作流编排层\",每个代理成为孤岛(\"一个代理创建特性分支、另一个跑测试、第三个合并——第一个没给第二个期望的元数据标记,就崩了\")
4. **提示与规格**:反讽——AI 干得越多,人的\"编码\"越上移到写规格;spec-driven development 兴起;\"写好的 spec 和测试这个非常老派的技能在 AI 时代重新变得重要\"
5. **工具与调试**:代理出错时(卡住/产出失败 PR)orchestrator 要诊断:坏 prompt?误读 spec?回滚重试还是手动介入?checkpointing/rollback 命令、监控仪表盘;**有时要降级到 conductor 模式修完再升回**;AI 可观测性工具(成本/性能/准确度)将成开发者工具的一部分
6. **伦理与责任**:许可合规/安全漏洞/偏见谁负责——最终是人的 orchestrator(或其组织);内置防护(不引入已知漏洞版本、可指示跑安全审计);\"信任,但要验证\"

**结论**:早期采用者每天委派 10+ PR、把代理当独立队友(二手待核);初级工程师从 conductor 开始,资深工程师更早采用 orchestrator(镜像职业成长:初级实现、资深设计与集成);\"持续委派给 AI\"可能像 CI 一样成为常规;一两年内不会全部代码由代理驱动;金句:**\"编码的未来不是 AI 或人,是 AI 和人——人在舵位,作为指挥与编排,指挥一支强大的乐团去达成软件抱负\"**;附:Osmani 新书 *AI-assisted engineering*(O'Reilly,beyond.addy.ie)

## 与现有 wiki 的关系

- 新建概念: [[conductor-orchestrator]](角色光谱的完整五轴定义)
- 更新了 [[multi-agent-systems]](指挥→编排条目精确化)、[[ai-feature-implementation-loop]]
- 关键互证:orchestrator 的\"git 痕迹\" ↔ [[file-as-memory]](工件即记忆)与 [[pr-contract]](PR 作为评审单元);\"代理评审代理的 PR、人最后在环\" ↔ [[2026-02-11-codex-agent-first-engineering|OpenAI 智能体对智能体]] 与阵营分歧;spec 上移 ↔ [[ai-agent-spec]]/[[factory-model]] 的 spec 杠杆与 [[intent-debt]](spec 写意图);六大挑战 ↔ 综合页验证瓶颈/协调原语/上下文共享条目;'AI/AI 互动人最后在环' ↔ [[pr-contract]] 人类签字立场(中间观察);ephemeral vs git-trail ↔ [[comprehension-debt]](未捕获上下文丢失的另一个出口)

## 待办 / 后续

- 核实 90% 采用率与 10+ PR/天(均无出处);Stack Overflow CTO 引述出处
- 2026-01 工具 snapshot 的演化(大部分工具已在 [[2026-03-26-code-agent-orchestra]] 更新到三层谱系);Azure agent-to-agent 协议进展;AI 可观测性工具落地
