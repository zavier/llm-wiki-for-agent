---
type: concept
tags: [ai-agents, sdlc, monitoring, autonomy, loop]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [loop-engineering, artifact-chain, governance-as-code, agent-verification, long-running-agents, factory-model, orchestration-tax, intent-debt, anthropic, claude-tag, agent-identity, subagents, skills, agentic-memory, pr-contract]
sources: [2026-08-21-ai-native-sdlc-playbook, 2026-08-18-claude-tag-first-responder-ci-cd]
status: active
---

# Control bands

控制带:闭环自治的触发机制——对生产/流程指标做**确定性检测**(rolling baseline + Western Electric 类规则),越界才调用代理**一次**;响应按 σ 分级(1σ 只记日志 / 2σ 只读诊断 / 3σ 可行动且只走受闸路线);代理把发现写成 `intent.md` 回灌 SDLC([[2026-08-21-ai-native-sdlc-playbook]] Stage 6 的核心 play)。

## 关键信息

**机制**(来源: [[2026-08-21-ai-native-sdlc-playbook]]):

- **检测确定性**:脚本(均值/标准差 over rolling window + Western Electric 规则,捕慢漂移与尖峰)版本控制 + 单测,**不涉及模型**;代理只在越界后被调用一次——把"代理常驻看生产"换成"事件驱动 + 确定性门"
- **分级响应**(版本控制配置 `bands.yaml`):`1sigma: { action: log }` / `2sigma: { action: diagnose, tools: "Read,Grep,Bash(gh run view *)" }` / `3sigma: { action: propose, routes: [pull_request, runbook:rollback-deploy] }`——3σ 的行动**只经受闸路线**:开 PR 进评审门、或触发**预先批准**的 runbook
- **触发层**任意:定时 workflow(GitHub/GitLab)、监控栈 webhook、网络内 cron;代理无状态跑(CI 非交互步骤或 Agent SDK 沙箱服务)——"**循环的开始和结束都不需要人启动**"
- **输出即工件**:诊断写成 Stage 1 格式的 `intent.md`(异常+证据/建议结果/受影响系统/开放问题)→ 之后与任何工作同一条流水线(见 [[artifact-chain]])
- **人留在环上的方式**:service owner 或 on-call **triage 队列**(fix now / schedule / dismiss);dismiss 用来**调 band 降噪**;fix 上线后**补一条 eval** 防同类回潮
- **示例**:CI 失败率 3σ → 隔离 flaky 测试或开 revert PR(评审门决定);post-deploy 5xx 3σ 且窗口内有部署 → 触发既有回滚流水线;PR cycle time 触发漂移规则 → 给工程领导写报告(过程指标同样适用)
- **跨阶段置信门**:Stage 6 无人在调用路径中,**阶段之间由独立置信门**决定继续还是升级给人——确定性检查,或对抗性评审代理(见 [[agent-verification]])

**在自治阶梯中的位置**(来源: 同上):这是 playbook 六级自治的最高一级——人不再启动任何东西;低级形态是其构成件的单独使用:CI 里 `claude -p` 只读 triage(判断步骤)、写步骤走既有门、按环境分级的部署自治(dev 自由 / prod 具名授权 / staging 居中)、`@claude` 评论修复、Claude Tag 值班、定时安全扫描(发现验证+置信度,大的转 `intent.md`)。共同原则:**代理可以行动到生产闸口,但不能穿过它**。

**与循环工程的对照**(本 wiki 现有层,见 [[loop-engineering]],Osmani):两者都是"设计循环而非提示代理",差别在触发器的形态——Osmani 版是**心跳/自动化**(定时发现+triage inbox),playbook 版是**异常触发 + 分级响应**(指标越界);共同点:循环不替你做三件事——验证仍在你肩上、理解仍会腐烂、舒适姿势最危险;control bands 用**triage 队列 + 升级给人**把"验证在谁肩上"制度化(见下列边界)。

- **agent 无状态**是特性也是限制:跨事件的模式识别(慢漂移的根本原因)不在单次调用内——playbook 假设确定性检测负责发现,代理负责单次诊断;实装里 `lessons.md` 承担跨事件记忆(见下),把“单次”扩成积累式,但长期检索与腐化未解

**实装案例:Claude Tag 值班(2026-08)**(来源: [[2026-08-18-claude-tag-first-responder-ci-cd]]):Anthropic 把本页机制跑成了完整值班系统——[[claude-tag|Claude Tag]] 做 CI/CD 失败的第一响应者数月,**中位 14 分钟**发出首份证据化分析、最快 **4 分钟**点名根因(近期带 SITREP 的事故,第一份分析全由 Claude 写)。四个环节:
- **检测**:Claude 分析新服务头几天数据帮调规则;监控每条告警,按根 `oncall.md` 判据决定 page 还是等早上(“告警过程确定性,升级路径确定性+agentic 双轨”);触发另有频道内报告与内部 incident 单(自动开频道)
- **Triage**:**dynamic workflow**——编排 agent 派生 executor 子代理并行查各依赖(Grafana/日志库/PagerDuty/GitHub/K8s/Slack,经 MCP),综合成 SITREP;investigation skill 按 bug 类(**617 行** shadow divergence skill 由真实排障逐轮共建而成);**lessons.md** 自动追加、每次先读、重复模式提升进 skill
- **修复**:以 PR 为主(开给 on-call 评审合并);K8s drain/cordon 与扩容建议;渐进部署由**带操作者权限**的独立 agent 代跑——始终不过受闸路线
- **验证/交接**:同套 MCP 验证修复、post-mortem 回 lessons.md、**ci-weather** 汇总多事故信息发公开频道、日/周总结供轮值交接

两条对本页有增量的结论:①**自改进环**(lessons.md→skill)让“代理每次只被调用一次”的假设松动——单次调用的产出回流成系统知识;②官方口径:”**跟上 agentic 编码的唯一方式是 agentic CI**“;质量线靠每 PR 具名 human owner + 变更需批准 + 同一套 gates 兜住(与 [[pr-contract]] 收敛)。

## 边界与风险(本 wiki 记录)

- **检测质量决定一切**:band 太紧 → 告警疲劳与 dismiss 堆积;太松 → 错过慢漂移;基线需要"稳定滚动窗口"的指标(playbook 自选例:CI 失败率/5xx/PR cycle time)——不是所有指标都适合
- **triage 队列会变成新的瓶颈**:与 [[orchestration-tax]] 同构——产出的 findings 需要人的评审率匹配;dismiss 调 band 是官方承认的降噪旋钮,但"谁来审 dismiss 本身"未讨论
- **3σ 行动的正确性依赖预批 runbook 的覆盖**:runbook 之外的状况只能"开 PR"或升级;自治的实际半径 = 预批路线的集合
- **agent 无状态**是特性也是限制:跨事件的模式识别(慢漂移的根本原因)不在单次调用内——playbook 假设确定性检测负责发现,代理负责单次诊断

## 与其他页面的关系

- 闭环叙事与循环工程对照: [[loop-engineering]];工件与入口: [[artifact-chain]]
- 受闸路线 = 治理执行层: [[governance-as-code]];置信门: [[agent-verification]]
- 生产侧背景: [[factory-model]]、[[long-running-agents]];来源: [[2026-08-21-ai-native-sdlc-playbook]]
