---
type: entity
tags: [product, anthropic, slack, agent]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [anthropic, control-bands, agent-identity, skills, agentic-memory, subagents, governance-as-code, claude-code, model-context-protocol]
sources: [2026-08-21-ai-native-sdlc-playbook, 2026-07-21-anthropic-secures-ai-native-sdlc, 2026-08-18-claude-tag-first-responder-ci-cd]
status: active
---

# Claude Tag

Anthropic 的 **Slack 团队代理**(public beta):以**自有身份**(own service account)加入频道、持频道记忆、按日程执行例行动作、经 MCP 连接外部工具,并在标准指令(skills)下自主行动。在 Anthropic 内部:它是 **CI/CD 事故的 on-call 第一响应者**,也是**超过一半代码的合并者**(来源: [[2026-07-21-anthropic-secures-ai-native-sdlc]]、[[2026-08-18-claude-tag-first-responder-ci-cd]])。

## 关键信息

**构成四件套**(来源: [[2026-08-18-claude-tag-first-responder-ci-cd]]):一个值班 agent 需要 ①**memory**(记住做过什么——Claude Tag 持 on-call 频道记忆)②**connections/access**(调查、理解、行动——管理员一次性接入 Datadog/Grafana 等工具)③**schedules**(何时回来干活——自然语言排期,"run CI handoff every Monday at 9:00am EST")④**instructions**(做什么——入 GitHub 仓库的 markdown skills,含路由、政策与 **lessons learned 日志**)。还以成员身份旁听其他相关频道(服务告警、配置变更、PR 更新)补上下文。

**内部用法一:CI/CD on-call 第一响应者**(来源: 同上):近期所有带 SITREP 的事故中,**第一份分析都由 Claude 撰写**;通常 15 分钟内发布,**中位 14 分钟**,最快 **4 分钟**在首报点名根因。全流程:检测(规则调优 + 监控每条告警 + 确定性/agentic 双轨升级)→ triage(dynamic workflow:编排 agent + executor 子代理并行查各依赖,经 MCP 接 Grafana/日志库/PagerDuty/GitHub/K8s/Slack;investigation skill 按 bug 类;lessons.md 先读后写)→ resolution(最频繁 = 开 PR 给 on-call 评审合并;另有 K8s drain/cordon、扩容建议;渐进部署由独立 agent 代跑)→ 验证与交接(同套 MCP 验证、post-mortem、**ci-weather** 新闻室式公开报告、日/周总结)。完整机制见 [[control-bands]]。

**内部用法二:代码合并者**(来源: [[2026-07-21-anthropic-secures-ai-native-sdlc]]):**超过一半**的合并代码由内部版 Claude Tag 完成;质量线由外部约束兜住——每个 PR 有具名人类 owner、每次变更需批准才合并、走同一套 CI gates(playbook 亦录:"ticket/频道内被 @ 的活同样 triage,小而清晰的修 → PR 过评审门,更大的 → `intent.md` 回 Plan")。

**身份与治理**(来源: 同上 + [[2026-07-21-anthropic-secures-ai-native-sdlc]]):自有 service account;每次动作进 SIEM 可归因;作为"新型内部威胁"被监控;feature-flag 渐进部署用**带操作者权限**的独立 Claude Code agent 实现(两种身份模型见 [[agent-identity]])。

**上手(官方清单)**(来源: [[2026-08-18-claude-tag-first-responder-ci-cd]]):Claude Team 或 Enterprise 计划;组织 owner 经 Claude Tag 把 Claude 加进 on-call Slack 频道;接好 connectors、GitHub 仓库,设置 **Claude Code Remote**;把 Claude 加进事故频道并指示它监控与立即 triage。**开源 oncall-kit**(github.com/anthropics/oncall-kit)可把团队自己的事故历史转成 triage playbook,留下只读的频道内 Claude(diagnose→escalate→learn);约十分钟可看它对着虚构历史跑一遍。

**自改进环**(来源: 同上):**lessons.md** 自动追加每次事故(发生了什么/根因/修复/坑),每次调查先读;**重复模式提升进 investigation skill**;ci-weather 汇总多事故信息对外播报;"先查数据,再推理。配置告诉你可能出什么错;指标告诉你实际出了什么"(lessons.md 里最著名的一条,写的是它的作者 Sachin Malhotra)。

## 与现有 wiki 的关系

- 机制层: [[control-bands]](值班闭环的机制页)、[[agent-identity]](service account/权限)、[[skills]](instructions 载体与 investigation skill 共建法)、[[agentic-memory]](lessons.md)、[[subagents]](dynamic workflow 编排/executor)、[[model-context-protocol]](connectors)
- 组织侧: [[anthropic]]、[[governance-as-code]](SIEM/shadow mode/抽检)、[[claude-code]]([[claude-code]] Remote 与 Claude Code agent 形态)
- 三源交叉:playbook(概念引入)→ securing 篇(身份与治理)→ 值班篇(全流程与数据)

## 待办 / 后续

- 待核:Claude Tag 的 beta 状态与 GA 时间线;oncall-kit 实测;`Claude Code Remote` 的文档细节
- 开放问题:值班 agent 向非 CI 事故(安全/数据事件)泛化的边界;lessons.md 长期增长的检索与腐化;漏报(该 page 未 page)的审计方法
