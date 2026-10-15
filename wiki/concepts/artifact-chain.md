---
type: concept
tags: [ai-agents, sdlc, process, artifacts]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [intent-debt, spec-driven-development, plan-mode, pr-contract, loop-engineering, control-bands, process-over-prose, governance-as-code, agent-verification, claude-md, factory-model, anthropic]
sources: [2026-08-21-ai-native-sdlc-playbook]
status: active
---

# Artifact chain

提交工件链:AI-native SDLC 的交接与触发机制——**每个阶段以向版本控制提交一个工件结束,下一阶段读取它开始;接受工件 = 触发下一关;提交链即审计链**;流程从线性变循环([[2026-08-21-ai-native-sdlc-playbook|Anthropic 官方 playbook]] 的核心主线)。

## 关键信息

**链条**(来源: [[2026-08-21-ai-native-sdlc-playbook]]):

| 阶段 | 工件 | 提交触发什么 |
|---|---|---|
| Plan | `intent.md`(意图:要什么/为什么/约束,originator 自己的话) | 被产品负责人接受(merge/开启评审)→ Design pass |
| Design | `spec.md`(需求+设计,受 org skills 约束,含 flagged concerns) | 产品负责人接受 → Build 的 plan mode |
| Build | `plan.md`(点名文件/顺序/证明测试) | 计划被接受 → 实现;偏离时同 commit 更新 |
| Build | diff + tests | merged PR → pipeline |
| Deploy | PR + review findings(REVIEW.md 三 pass:bugs/security/compliance) | code owner 批准 → merge → 流水线 |
| Maintain | incident record / breached control band | 写成新的 `intent.md` → 回到 Plan,**循环闭合** |

- **markdown 是早期阶段的载体**:因为产品负责人与代理读、行动于**同一文件**;Build 之后工件是代码与其记录(来源: 同上)
- **人的注意力在 gates**:起点是手动逐段 prompt(人推每个阶段),终局是"每个被接受的工件触发下一关"——人审的是**代理标记的内容**,而非每个阶段从零开始;plays 另有**依赖图**(Prerequisites)——采纳顺序 ≠ 阶段顺序,无入边的 play 可先行(来源: 同上)
- **审计性**:工件记作者/时间戳/修订史;"谁要的、代理产出了什么、谁批准"都在提交链上;审批动作本身也是记录(merge/关闭评审 = 接受/拒绝)(来源: 同上)
- **家的形态**:单产品最简 = 产品 repo 里的 `intent/` 目录(工件链挨着由它派生的代码);跨多仓库才值得独立 intent repo;monorepo 里就是一个目录;非工程师经 connector(如 GitHub)让 Claude 代提交,无需直接使用 git(来源: 同上)
- **与 legacy 记录系统共存**:每个工件**指定唯一 source of truth**——①repo 为事实源(markdown 权威,legacy 引用 commit)②legacy 为事实源(Jira/ServiceNow 权威,markdown 为工作副本,经 MCP 读入/写回)③linkage 为最低标准(两边互相引用 ID/SHA,双事实源——过渡期起点)(来源: 同上)
- **每阶段的度量都从工件链读出**:git 时间戳(intent→spec、plan 批准→merge)、返工(plan 首 commit 之后的 spec.md commit)、一致性(merged diff vs plan.md)、存活率(intent 接受率)——链路本身就是测量仪表(来源: 同上)

**为什么是"工件"而不是"消息"**:工件是**持久、可寻址、可机器读、可审计**的交接物;代理人读工件即可开工(会话冷启动不再从零);这与"代理每次会话从零构建理论"的意图债诊断直接互补——工件链是把关键意图/计划**在便宜时刻**落盘,而不是在评审/事故时刻重建(见 [[intent-debt]])。工件还让"退出标准"有了物理形态:过程胜过散文的"以证据终止",在 SDLC 尺度上 = 以**提交的工件**终止(见 [[process-over-prose]]、[[agent-verification]])。

## 与相关机制的区别

- **vs spec-driven development**:[[spec-driven-development]] 定义流程形状(四阶段门禁);本页是它的**载体与触发机制**(阶段之间传什么、什么算接受、接受触发什么)
- **vs plan mode 工具化**:[[plan-mode]] 讲只读规划;**plan.md 文件化**把计划从会话内提升为仓库工件——playbook 与 pi 的 PLAN.md 在此**殊途同归**(机制的两种来源,结论一致:计划应入库)
- **vs PR contract**:[[pr-contract]] 是工件链 Deploy 环节的**内容规范**(作者对评审者的证据义务);工件链是它上层的过程状态机
- **vs 循环工程**:[[loop-engineering]] 的循环面向"自动发现/派活";工件链是其**状态与交接格式**——control band 越界写出的 `intent.md` 与人的想法写出的 `intent.md` **同一格式、同一入口**(见 [[control-bands]])

## 边界与风险(本 wiki 记录)

- 工件链假设**每个阶段有明确的接受者与接受动作**(产品负责人/code owner);没有清晰 owner 的组织,链会退化为"文件堆积"
- "接受工件触发下一关"的自动化 = [[governance-as-code|gates 由 hook/config 实现]];**未自动化的版本就是人工逐段 prompt**——playbook 自认起点如此
- 与"AI 生成文档不可靠"张力:工件链上的早期文本由代理起草、人审改(originator 修正/产品负责人审 spec)——**人审是链条完整性的前提**,否则链只是又一次生成的文档(见 [[comprehension-debt]] 的赝品效应)

## 与其他页面的关系

- 载体: 本页;内容规范: [[pr-contract]]、[[agent-verification]]
- 反馈闭环: [[loop-engineering]]、[[control-bands]];治理执行: [[governance-as-code]]
- 意图侧: [[intent-debt]]、[[spec-driven-development]]、[[plan-mode]];配置侧: [[claude-md]]
