---
type: concept
tags: [ai-agents, governance, security, compliance, configuration]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [harness-engineering, three-tier-boundaries, skills, agent-verification, pr-contract, artifact-chain, control-bands, lethal-trifecta, anthropic, claude-code, pi-coding-agent, agent-identity, claude-tag, agent-containment]
sources: [2026-08-21-ai-native-sdlc-playbook, 2026-07-21-anthropic-secures-ai-native-sdlc]
status: active
---

# Governance as code

治理即代码:传统 SDLC 的控制目标**不变**,但执行方式从"事后评审周期 + 委员会"变为**代理行动时刻可执行的规则**——分层为 skill(建议)→ hook(确定)→ managed settings(强制)→ OTel(证据);"gate 条件每次、对每个人都执行,而不是取决于谁记得"(来源: [[2026-08-21-ai-native-sdlc-playbook]],Anthropic 官方)。

## 关键信息

**失灵诊断(为什么需要它)**(来源: 同上):控制假设与现实脱节——逐行人工审查在 agent 写大部分 diff 时不可持续;安全团队按人类产出配置 → 队列堆积或欠审上线;例外仍走周会/委员会 → **治理成本随产出上升**;而且控制点(评审)离行动点(代理改代码)太远,反馈太慢。

**四层执行模型**(本页提炼,全部出处同一 playbook):

| 层 | 机制 | 强度 | 证据落点 |
|---|---|---|---|
| 建议层 | **skill**:制度知识在生成时刻被应用 | 让违规**罕见**(不保证合规) | skill 调用记录在 session trace;policy owner 审 skill 变更如代码 |
| 确定层 | **hook**:每次匹配动作都跑,allow / ask / block | 让违规**接近不可能**("skill 让违规罕见,hook 让违规接近不可能") | 每次 allow/block 记时间戳与 verdict(OTel 导出) |
| 强制层 | **managed settings**:平台/IT 所有,工程师不可关闭 | 规则不可被本地配置放宽 | settings 本身版本化;`allowManagedHooksOnly` 等互锁 |
| 证据层 | **OTel / PR / commit 链**:决策与工件可审计 | 事后可回答"谁批准了什么" | session trace、gate 日志、[[artifact-chain|工件链]] |

**hook 的两种用法**(来源: 同上):
- **构建期护栏**:block 受保护路径(generated / frozen package)、保存后跑 formatter/linter、挡凭据进 diff;要求快且按文件范围(重检查留 commit/PR 阶段)
- **审批门**:脚本在动作前 allow/ask/block;生产部署需具名 `RELEASE_APPROVAL`;block 必须自解释(原因 + 审批路径出现在 Claude 输出里);**批准 prompt 不放 build 阶段**——那会把一个人重新放回所有并行会话的关键路径
- 团队 hook → `.claude/settings.json` 入库;**不可协商的 hook → managed settings**(平台/IT 所有,工程师无法关闭)

**管制企业形态(worked example,编排要点)**(来源: 同上):`permissions.deny`(读 secrets、任意网络出口)+ `permissions.allow`(安全内环,防止 deny 变成 prompt 疲劳);`disableBypassPermissionsMode` + `allowManagedPermissionRulesOnly`(任何工程师/项目文件/命令行 flag 都不能放宽规则);**sandbox**(工具级 deny 挡不住 shell 出网,OS 级域名白名单才挡;`failIfUnavailable` + `allowUnsandboxedCommands: false` 让"沙箱不可用 = 拒绝启动"、sandbox 内失败不可绕沙箱重试;credentials 块拒绝 `~/.ssh`/`~/.aws` 读取并从沙箱环境剥离命名 secret);`allowManagedHooksOnly`(只有受管 hook 运行);`disableSideloadFlags` + `strictKnownMarketplaces`(一切 skill/agent/hook/MCP 都来自组织批准的 plugin 市场);`allowManagedMcpServersOnly`(工具面 = 平台 allowlist);`requiredMinimumVersion`(低于评估过的版本拒绝启动)。playbook 自注:"这是起点不是复制建议——每条 deny 都在与能力交换,平衡取决于仓库的数据分级"。

**与"人"的边界**:治理即代码不取消人的判断,而是**把人放到不能被配置绕过的少数点上**——审批门定义"什么算批准"(变更单/发布经理签字);**分离职责保留:写码的代理无法批准自己的代码**;PR findings 本身不 approve/block,branch protection 仍要 code owner(可读机器可读的严重度 tally);人的注意力集中在 gates(见 [[artifact-chain]]、[[pr-contract]])。

**对照极简派**:同 [[pi-coding-agent]] 一样反对**逐次人工审批**(pi:"权限弹窗 = security theater"),但路径相反——一条把信任放在**平台层强制配置 + 沙箱兜底 + 审计**,一条把信任放在**极简 + YOLO + 容器**;组织规模(需要可审计、可交接、可合规)是分化的自变量(见 [[minimal-vs-rich-harness]])。

**内部实装(安全侧,2026-07)**(来源: [[2026-07-21-anthropic-secures-ai-native-sdlc]],Deputy CISO 视角):基线是人均季度产出 **8×**、Claude 撰写 **~80%** 合并代码、**>50%** 由 [[claude-tag|Claude Tag]] 合并;威胁模型三类——被注入/失陷 agent 引入恶意变更、供应链投毒被当可信输入、常规漏洞高量到达;四条策略就是本页各层的组织版(shift left、硬身份/访问边界、确定性+agentic 双轨评审、人在最高杠杆点)。逐阶段实装:
- **Plan**:PSR 应用(Claude Opus × MITRE ATT&CK × 内部知识索引)压缩安全评审——“把安全 agent 接到组织上下文所在处”;低风险项目凭证可靠后允许团队自审
- **Code**:安全指引编码进 CLAUDE.md + 组织 skills,构成**发现 bug 类→更新文件→未来不复发**的闭环(本页“建议层”的实例);`/security-review` + security guidance plugin 在生成过程中评审;PreToolUse hook 是把建议变硬门的可选件(Anthropic 自选把硬门放在 CI);远端 VM + **egress allowlist** 限制注入外泄路径(见 [[agent-containment]])
- **CI**:实质评审评论率 **16%→54%**——关键前提是**要求 agent 写下“发现为真”的 proof**;多窄焦点评审 agent(不共享盲点/互为冗余/不摊薄精力)+ 对往期事故的 RAG;风险分层 + 自动批准**连信号与推理记录** + **按风险加权的抽样人审**;不变量测试(“用户 A 永远不能读用户 B 的数据”)触发额外人工评审;SAST 与 agentic 扫描并排
- **CD**:连续 AI DAST 对齐部署节奏;2 月披露 500+ 高危 OSS 漏洞由 Claude 发现并协助修复
- **Monitor**:告警 triage agent 三权限(写文档/发频道/读生产日志)、**不能部署**——修复须经独立 agent-人类评审系统;agent-to-agent 教训(模型升级后 IR agent 自行请另一个 Claude 推修复,被人审门拦下)→ [[agent-identity]]
- **Governance**:**shadow mode**(新 AI 评审员先发评论等批准，并红队注入恶意变更)、抽检、vitals 仪表盘、**每个 agent 动作连信号进 SIEM**、把 agent 当**新型内部威胁**;"安全工程师的工作从监控 bug 演进为监控循环"

本段还给出治理的**成本观与投资姿势**:"不要问能不能负担全扫——问**如果扫描接近免费你会跑什么**",照那个规划(与 [[agent-evals]] 的基础设施投资观同源)。

## 与现有页面的分工

- 机械载体(harness 工具箱里的 hooks、沙箱、配置评审节奏)见 [[harness-engineering]];本页是它的**组织/合规语义层**(控制目标、分层强度、审批与审计)
- [[three-tier-boundaries]] 的 Always/Ask first/Never 是本页控制策略的**表达格式**:Always → allow、Ask first → ask hook、Never → deny/managed 规则——边界从"建议给代理"升级为"系统替代理执行"
- [[agent-verification]] 的"确定性门禁不可被自信段落说服"是同一原则在验证侧的形态;本页把它推广到全部治理面
- [[lethal-trifecta]](速度/非确定性/成本)在组织层的对冲面:沙箱与 deny 限制爆炸半径,审批门限制不可逆动作

## 边界与风险

- 与 [[curse-of-instructions]] 同族风险:控制越多越重,工程师绕过或产线变慢——playbook 的回应是按层分工(建议/确定/强制各司其职)与"每条 deny 都换掉一部分能力"
- managed settings 的运行前提是**平台团队存在且可信**;缺平台能力的小组织不适用(对应 wiki 中"规模是学派分化自变量")
- 证据层依赖日志基础设施(OTel 导出到组织可观测栈)——没有该能力的组织,治理仍停在"过程文档"层

## 与其他页面的关系

- 控制带是同一原则在**生产检测**侧的形态:确定性检测 + 分级响应(见 [[control-bands]])
- 组织采用层: [[anthropic]]、[[claude-code]];对照: [[minimal-vs-rich-harness]]、[[pi-coding-agent]]
