---
type: synthesis
tags: [ai-agents, harness, comparison]
topic: ai-agents
created: 2026-08-08
updated: 2026-08-08
refs: [harness-engineering, context-engineering, pi-coding-agent, mario-zechner, claude-md, skills, model-context-protocol, plan-mode, subagents, long-running-agents, progressive-disclosure, three-tier-boundaries, agent-computer-interface, agent-verification, curse-of-instructions, agents-md, file-as-memory, orchestration-tax, parallel-agents, simon-willison, addy-osmani, anthropic]
sources: [2025-11-30-opinionated-minimal-coding-agent, 2026-04-19-agent-harness-engineering, 2026-03-12-skill-issue-harness-engineering, 2026-02-12-evaluating-agents-md, 2026-08-02-best-practices-claude-code, 2026-05-03-agent-skills, 2026-08-02-equipping-agents-with-agent-skills, 2026-08-02-effective-harnesses-for-long-running-agents]
status: active
---

# 极简 harness vs 富 harness

综合结论:编码代理的 harness 设计存在两个互斥的学派——**富学派**(Anthropic 官方/Osmani/HumanLayer:CLAUDE.md+hooks+skills+MCP、子代理、plan mode、特征清单、权限三档)与**极简派**([[mario-zechner|Zechner]] 的 [[pi-coding-agent]]:四工具+<1000 token 提示、YOLO、文件即状态、tmux、无 MCP/子代理)。两派都声称 daily-driver 级可用且有 Terminal-Bench 证据;分歧不是"配置多少"而是"信任放在哪"——富学派把信任放在**可强制的过程结构**里,极简派把信任放在**完全可观测的透明**里。

## 综合论点

**共同底线**(两派共享,本 wiki 现有共识不动摇):上下文是核心有限资源([[curse-of-instructions]]、指令预算、[[context-rot]]);工具要少而聚焦("最小可用工具集" vs "四工具够用"是同一原则的连续谱);文件系统是持久状态([[file-as-memory]]);从简单开始、失败后按需加、行为驱动设计([[harness-engineering]] 的棘轮与"说不出服务哪个行为的组件不该存在" = pi 的"如果我用不到它,它就不会被构建");验证是瓶颈([[agent-verification]])。

**分维度分歧**:

| 维度 | 富学派(Anthropic/Osmani/HumanLayer) | 极简派(pi) |
|---|---|---|
| 系统提示 | 10k token 级、原生 harness 提示的裁剪版(opencode 抄 Claude Code) | <1000 tokens;模型 RL 后天生懂编码代理 |
| 工具 | 数十个 + MCP 生态 | read/write/edit/bash 四件套 |
| 状态管理 | 特征清单 + progress 文件 + hooks 强制([[long-running-agents]]) | TODO.md/PLAN.md 普通文件,人判断 |
| 规划 | Plan Mode 只读分析 | 无需内建;PLAN.md + 全观测 |
| 子代理 | 上下文防火墙:独立窗口只回摘要 | 黑箱;独立会话 + 工件交接代替;并行子代理 = 反模式 |
| 外部集成 | MCP 标准协议 | CLI + README 按需读(渐进披露的 CLI 形态) |
| 权限 | 三档边界/权限弹窗/hooks 拦截([[three-tier-boundaries]]) | YOLO 默认(security theater) |
| 后台进程 | 后台 bash 特性 | tmux(可观测 + 人机协同) |
| 可观测性 | 子代理黑箱、UI 不暴露注入内容 | 完全控制每个 token + 完全可见代理读了什么 |
| 安全 | 沙箱/批准门/MCP 供应链治理 | 三元组无解,放弃(容器兜底) |

**证据对照**:

- Terminal-Bench 2.0:富学派"只改 harness 把代理从 Top 30 提到 Top 5"(调优增益);极简派 pi 五轮跑分上榜 + Terminal-Bench 团队自己的 Terminus 2(**纯 tmux、零工具**)名列前茅——**harness 差距论的两面:harness 可以增加表现,也可以削减负担**,机制未解(来源: [[2025-11-30-opinionated-minimal-coding-agent]]、[[2026-04-19-agent-harness-engineering]])
- ETH agentfile 反证([[2026-02-12-evaluating-agents-md]]):LLM 生成的长上下文文件损害性能(-0.5%/-2%)、人工写的短文件 +4%——支持"短而精",不支持"极简 = 零配置";"存在本身不是问题,内容质量才是"
- curse-of-instructions 与 56% skill 未触发([[progressive-disclosure]]):支持极简派的"披露失效"担忧;但富学派的回应是触发机制工程而非删除机制
- 决策依据差异:富学派有组织规模证据(OpenAI 零人工代码、Anthropic at scale、阿里 2-3×),极简派证据主要来自个人/小团队(Zechner:7 个生产项目用过 pi-ai;pi-mono 是唯一主战场)——**规模可能是学派分化的自变量**

**关键调和点**:两派在"**上下文隔离应该存在**"上其实一致——分歧在隔离的层级:富学派在**会话内**隔离(子代理),极简派在**会话间**隔离(独立会话 + 文件工件,与富学派的"报告文件交接"同构);pi 唯一保留的"子代理"用例 = 代码评审(`pi --print` 自派生,输出全可观测),恰是富学派公认的对抗性评审价值所在。

## 支持与反证

- 支持极简派:[[curse-of-instructions]](指令越多遵循越差);ETH agentfile(短而精);56% 未触发(披露触发不可靠);HumanLayer"从简单开始、失败后按需加、扔掉的多于在用的";Cursor 护栏演进史(组件随模型变强过时);Willison 对 dual-LLM 的自评(安全三元组无解)
- 支持富学派:Anthropic 官方"harness 决定表现超过模型本身"与五扩展点背书;OpenAI 零人工代码(环境规范决定产出);组织层证据(阿里、Cloudwalk);子代理上下文防火墙的量化收益(多代理 +90.2%);hooks 确定性执行不可被自信段落说服([[agent-verification]])
- 反证 / 未解决:
  - 两派证据都来自**各自的产品与 daily driver**,缺同模型同任务的 A/B;Terminal-Bench 排名受 harness 与模型的共训练耦合影响,跨 harness 可比性存疑
  - 极简派的无内建 to-do 与富学派特征清单门禁正面冲突——都外部化状态,但"列表是否应由 harness 强制"无直接实验
  - pi 的"模型不愿读全文"假说(训练分布使然)未验证;若是真,富学派的"给更多工具/更多上下文"与极简派的"先收集上下文"都会受益于理解其机制
  - 极简派证据主体为个人项目(样本偏差);"YOLO 默认"在组织/合规场景的可迁移性未论证
  - 子代理可观测性与上下文隔离能否兼得(富学派的摘要回流 vs 极简派的全输出)是产品设计开放问题

## 开放问题

- 极简 vs 富 harness 的同模型同任务 A/B(两派各自的 Terminal-Bench 与 daily driver 都自称够用)
- to-do 列表的冲突证据边界:特征清单门禁(防"提前宣布完成")vs"列表困惑模型"(pi)——什么任务规模/什么列表形态下各自成立
- "模型不愿读完整文件"假说的验证(训练数据分布的影响,是否随模型换代消失)
- 子代理黑箱 vs 全可观测的折中形态(富学派是否会在产品层面公开子代理会话,极简派是否会补会话内隔离)
- 规模与学派的相关性:个人/小团队 vs 组织场景是否必然分化
