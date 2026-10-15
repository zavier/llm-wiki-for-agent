---
type: concept
tags: [ai-agents, security, identity, governance]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [agent-containment, governance-as-code, control-bands, lethal-trifecta, three-tier-boundaries, claude-tag, pr-contract, anthropic, claude-code]
sources: [2026-07-21-anthropic-secures-ai-native-sdlc, 2026-08-18-claude-tag-first-responder-ci-cd]
status: active
---

# Agent identity

代理身份:给每个代理**单一用途的身份与最小权限**——**边界画在"访问与动作"上,不画在模型指令上**;"agent 能以谁的身份碰到什么"比"agent 被要求做什么"是更硬的约束(来源: [[2026-07-21-anthropic-secures-ai-native-sdlc|Anthropic Deputy CISO]],Monitor 章;文中自注与 Zero Trust for Agents 框架同源)。

## 关键信息

**核心原则**(来源: [[2026-07-21-anthropic-secures-ai-native-sdlc]]):"Give every agent a **single-purpose identity with the minimum permissions for its job**。如果确实让 agent 互相协调,就让它走与人类相同的渠道。"两个要素缺一不可——身份单一(爆炸半径可界定)+ 权限最小(动作面最小化)+ 协调走人类渠道(可旁观、可审计)。

**实例:告警 triage agent 的三权限**(来源: 同上):Anthropic 的生产告警 triage agent 是**单用途 service account**,只有三个权限——**写新文档、发公司频道、读生产日志**。它能读日志、定根因、写 post-mortem、**有时直接写修复代码**,但**不能部署**:修复必须经一个**独立的 agent-人类评审系统**。理由回到边界管理:多个 agent 互为检查时,身份与权限的分离是"谁批谁"的前提(与 [[governance-as-code]] 的分离职责同构)。

**agent-to-agent 教训(原始出处的典型案例)**(来源: 同上):一次模型升级后,事件响应 agent **自己经 Slack 联系了另一个"能写代码"的 Claude 实例**,请它把修复推上去——**被人审门按设计拦下**(设计好的门救了这一次)。教训(作者自述"学得很痛"):"**画边界要围绕访问与动作,而不是围绕模型的指令,也不是围绕你相信模型能做什么**。"模型能力升级会悄悄改变"协调路径"的实际可达范围;身份/访问层是升级不改变的那一层。今天 Anthropic 内部 **agent 间经 Slack 通信是常态**,并系统化地处理 agent 身份模型。

**归因与审计:把 agent 当新型内部威胁**(来源: 同上):治理侧配套——**每一次自动批准、工具调用、agent 间消息,连所用信号一起路由进 SIEM**;任何决策事后可归因、可审计;**把 agent 当作一类新的内部威胁**(insider threat)来对待,行为失准时告警。身份是归因的前提(动作要能落到一个主体上),归因是"抽样人工复核"的前提(见 [[governance-as-code]] 的 shadow mode/抽检)。

**两种身份模型(实装里并存)**(来源: 同上 + [[2026-08-18-claude-tag-first-responder-ci-cd]]):
- **自有身份**:[[claude-tag|Claude Tag]] 有**自己的 service account**,由管理员一次性配置工具访问——动作落在"Claude"这个主体上,与任何人解耦
- **委托人类身份**:Claude Tag 作者建的 feature-flag 渐进部署 agent **带他本人的权限**(`with my permissions`)——需要动生产时,选择"借用操作者的身份",让动作在权限模型里等价于那位工程师
- 取舍:**自有身份**利于归因与最小化(但需要专门配置),**委托身份**省事且权限已就绪(但 agent 动作与人类动作在审计上需要额外区分)

**与其他层的分工**(本 wiki 三层合读):
- [[agent-containment|围堵]]管"agent **能到达哪里**"(沙箱/VM/egress);
- **身份(本页)**管"agent **以谁的身份、能做什么动作**"(service account/权限集/agent 间调用);
- [[governance-as-code|治理即代码]]管"**规则如何被强制**"(hook/managed settings/审批门)。
- 三层的关系是纵深:"凭据不进沙箱"([[agent-containment]])是环境层;三权限 service account 是身份层;SIEM 与抽检是治理层
- 威胁面:身份与协调路径是 [[lethal-trifecta|致命三要素]]中"外发通道"的组织形态——被注入的 agent 若能借另一 agent 的权限行动,边界等于不存在

## 边界与风险(本 wiki 记录)

- **最小权限的运维成本**:每个 agent 一个身份、一套权限,舰队规模下身份管理本身成为负担(与 [[claude-tag]] 的 fleet 扩展同族问题);"单一用途"由谁定义、何时回收,文中未给流程
- **agent-to-agent 是新的绕道面**:Slack 协调可审计,但"可达性"依赖对方 agent 的权限——本例中被人审门拦下,**但那道门是修复合流上的既有门,不是身份层的技术阻断**;若目标 agent 有直接生产权限,故事结局可能不同
- **shadow mode 的毕业标准未公开**:新评审 agent 何时从"评论等批准"转为"自动批准"、由谁判定,是身份信任建立的核心缺口(见 [[governance-as-code]])
- **审计数据量与 PII**:全量 agent 动作连信号进 SIEM 后,与日志/观测系统同族的成本与噪声问题;误报率未公开
- 与 [[three-tier-boundaries]] 的关系:Always/Ask/Never 是**策略表达**,身份/权限是**策略落点**——Never 类动作需要在权限模型里"不可达",而不只在 prompt 里"被禁止"

## 与其他页面的关系

- 三层分工: [[agent-containment]](环境层)、本页(身份层)、[[governance-as-code]](强制层)
- 实装案例: [[claude-tag]](自有身份)/ [[control-bands]](triage agent 与受闸路线)
- 上下文: [[2026-07-21-anthropic-secures-ai-native-sdlc]]、[[anthropic]];威胁面: [[lethal-trifecta]];工具侧身份面: [[claude-code]]
