---
type: source
tags: [ai-agents, incident-response, cicd, anthropic, claude-tag]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# How Claude Tag serves as Anthropic's first responder for CI/CD failures (Anthropic,2026-08-18)

- 原文: `raw/How Claude Tag serves as Anthropic's first responder for CI_CD failures.md`(claude.com/resources/articles/ai-ci-cd-on-call;作者 Sachin Malhotra,CI 团队 technical staff;致谢 Michael Segner)
- 类型: 官方实践文章——[[2026-08-21-ai-native-sdlc-playbook|playbook]] "Claude Tag 值班"段的展开篇;附**开源 oncall-kit**(github.com/anthropics/oncall-kit)
- 备注: 本 wiki 第六十四篇源文档;清掉 playbook 源页挂的第二条 companion 待办;控制带/闭环的**值班实装全流程**

## 摘要

Claude Tag 在 Anthropic 做 CI/CD 失败的 on-call **第一响应者**已数月:**近期所有带 SITREP 的事故中,第一份分析都由 Claude 撰写,通常在 15 分钟内发布;中位耗时 14 分钟,最快的一次 4 分钟就在首报里点名根因**。构成四件套:记忆(on-call 频道)、连接与访问(Datadog/Grafana 等)、日程(自然语言排期,如"每周一 9 点跑 CI handoff")、指令(markdown skills 入 GitHub 仓库,含路由、政策、lessons learned)。检测上人定不好阈值、也扛不住告警疲劳——Claude 分析新服务头几天的数据帮调规则、监控**每一条**相关告警;排查用 **dynamic workflow**(编排 agent 派生 executor 子代理并行查每个依赖:MCP 接 Grafana、日志库、PagerDuty、GitHub、K8s、Slack);修复以 PR 为主(最频繁),渐进部署有独立 agent 代跑;**lessons.md** 自动追加、每次调查先读、重复模式提升为 investigation skill。收尾:"**跟上 agentic 编码的唯一方式是 agentic CI**"。

## 关键主张

**开场轶事 vs 旧流程**(来源: 同上):夜里 10 点同事 Slack "新服务约 44 个测试没在跑";旧流程 = 放下手头事、坐下、叹气、一小时调查;新流程 = @Claude 问它看到了什么——Claude 发现测试在某 feature flag 当早打开后消失、且**回滚该 flag 是安全的**;作者请同事回滚,3 分钟后 Claude 在 Slack 回报 skip 规则已移除、错误率回到基线。

**On-call agent 的四件套**(来源: 同上):一个值班 agent 需要 **memory**(记住做过什么)、**connections/access**(能调查、理解、行动)、**schedules**(知道何时回来干活)、**instructions**(知道做什么)。实装:**Claude Tag 持有 on-call 频道记忆**并提供逐轮指令接口;实时响应频道事件;日程用自然语言("run CI handoff every Monday at 9:00am EST");**有自己 service account**,由管理员一次性接入 Datadog/Grafana 等 CI 工程师用的工具;还以成员身份**旁听其他相关频道**(服务告警、配置变更、PR 更新)补上下文;标准指令是**入 GitHub 仓库的 markdown skills**(多人迭代、像代码一样管理变更),含路由、政策与 **lessons learned 日志(自改进环的一部分)**。整套设置"**花了数小时而不是数天**";开源 **oncall-kit** 把团队自己的事故历史转成 triage playbook,留下一个**只读的频道内 Claude**(diagnose、escalate、learn),约十分钟就能看它对着虚构团队历史跑一遍。

**Detection:规则调优与告警疲劳**(来源: 同上):两大失败模式——①人难以一直设定完美阈值,数据不足的新服务尤甚 → Claude **分析新服务头几天的数据与告警,建议补规则、调宽/调窄** ②告警疲劳 → **Claude 不会以人的方式疲劳**,监控每条相关告警,按根 `oncall.md` 的判据决定"可等到早上"还是"page on-call"(例:"错误率 >2% 持续 >5 分钟且不在已知部署窗口 → page;否则写 lessons.md");另两条触发路径:CI 团队成员在频道里报告;任何人开内部 incident 且标记为 CI 基础设施 → 自动开通 Slack 频道,值班 Claude 接手。要点:"**告警过程是确定性的,on-call 升级则确定性路径与 agentic 路径并存**"。

**Triage:dynamic workflow + 可积累的调查知识**(来源: 同上):
- Claude **中位 14 分钟**发出第一份证据化分析,最快 **4 分钟**在首报点名根因("有时在我们频道里已备好用证据支撑的假设")
- 机制:**dynamic workflow**——编排 agent 派生 **executor 子代理**,每个负责一个依赖与事实源(对 Anthropic 是 Grafana、日志库、PagerDuty、GitHub、Kubernetes、Slack 事故频道,全经 **MCP Connectors** 接通),**并行追多条线索**降 MTTR;执行者回报,编排者综合成一份连贯的 SITREP
- 子代理不是盲搜:**investigation skill** 按 bug 类附带细化的参考 markdown(例:**617 行的 shadow divergence 调查 skill**——作者在一次事故里与 Claude 逐轮排障,**事后让它把这套步骤写成文件**)
- **lessons.md**:我们解决过的每次事故的运行日志(发生了什么、根因、修复、值得记住的坑),**Claude 自动追加**;**每次新调查都先读它**——第一假设从最近发生的事开始;**同一模式出现足够多次就提升进 investigation skill**。作者最爱的一条是 Claude 写他本人的:"**先查数据,再推理。配置告诉你可能出什么错;指标告诉你实际出了什么。**"
- **多人在场(multi-player mode)**:团队与 Claude 可实时协同排障,任何一方都能引导调查或补假设——"人类直觉与经验仍然重要"

**Resolution:三条路径**(来源: 同上):绝大多数部署走 feature flag——作者建了一个**带自己权限**的独立 Claude Code agent,能做渐进部署(管 canary 流量、监控、自动加大/回退 flag);另外告知 K8s 是否需要 drain/cordon 某些部分;**最频繁的一条是开着 PR 让 on-call 评审、合并、部署**。

**Verification、communication、handoff**(来源: 同上):验证用与调查**同一套 MCP 连接与工具**;按 oncall.md 标准指令写 post-mortem 进 lessons.md 与交接 SITREP;**ci-weather** agent 汇总各事故频道、构建指标、合并队列统计与部署延迟,发成"新闻室风格"的公开频道报告——"工程师想决定要不要压住合并、或想回答'CI 到底怎么了',看那个频道就行,不用来 ping 我们";诚实注脚:报告格式**迭代了好几次**——"Claude 能一次生成一个状态报告 skill,但让它**可读**的是团队特有的品味。这是人类沟通,不是管道工程";此外每天/每周生成总结,让轮值的人周一能接着上周的跑。

**收束判断**(来源: 同上):工程师人均季度产出 8×;**质量线没降**——每个 PR 有具名人类 owner、每次变更需要批准才能合并、每次变更走同一套 CI gates;但"**跟上 agentic 编码的唯一方式是 agentic CI**";作者说 Claude 吸走的是"这份工作里枯燥的部分(深夜打扰、事故沟通)",留给他的是中长期架构改造;"最好的部分是它不散——我们的 on-call 流程活在 Slack,而现在 Claude 加入了那个频道"。从**监控事故**到**监控事故响应系统**。

**上手清单(TL;DR)**(来源: 同上):需要 Claude Team/Enterprise 计划;组织 owner 经 Claude Tag 把 Claude 加进 on-call Slack 频道;再接好相应 connectors、GitHub 仓库并设置 Claude Code Remote;把 Claude 加进事故频道并指示它监控与立即 triage。

## 与现有 wiki 的关系

- **值班实装落位**:[[control-bands]](本页是 Stage 6 "Claude Tag 值班"的完整展开:检测→triage→修复→验证→交接;确定性告警 + agentic 升级的双轨与 playbook 同构)、[[loop-engineering]](自改进环:lessons.md→skill 提升;"监控事故响应系统")、[[agentic-memory]](lessons.md 模式:自动追加/先读/固化)、[[skills]](617 行 investigation skill 的共建法 = "与 Claude 迭代,把成功路径沉淀为 skill"的实例)、[[subagents]](dynamic workflow 编排+executor 并行调查)、[[claude-tag]](产品实体页)、[[agent-identity]](service account/权限分离)
- 互证:Claude 于"人类看到之前自验修复" ↔ CircleCI Chunk([[2026-07-21-anthropic-secures-ai-native-sdlc]]);"每 PR 具名 owner + 变更需批准" ↔ [[pr-contract]] 四源收敛;lessons.md ↔ [[file-as-memory]] 的情景记忆("failures 日志最值钱")与 [[2026-01-31-self-improving-agents|self-improving agents]] 的学习回写;"先查数据再推理" ↔ [[agent-verification]] 的证据纪律

## 待办 / 后续

- oncall-kit(github.com/anthropics/oncall-kit)与 RUNBOOK.md 测试夹具可实测;`Claude Code Remote` 文档待核
- 待核:文章时点的 products/beta 状态;ci-weather 的公开样例;"15 分钟/14 分钟/4 分钟"为操作数据(非受控评测)
- 开放问题已并入 topic hub:值班 agent 向非 CI 事故(安全事件/数据事件)泛化的边界;lessons.md 长期增长的检索与腐化;triage 误判(该 page 未 page)的漏报审计
