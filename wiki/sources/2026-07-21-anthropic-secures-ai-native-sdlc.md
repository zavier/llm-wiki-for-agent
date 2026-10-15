---
type: source
tags: [ai-agents, security, sdlc, anthropic, governance]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# How Anthropic secures its AI-native software development lifecycle (Anthropic Deputy CISO,2026-07-21)

- 原文: `raw/How Anthropic secures its AI-native software development lifecycle.md`(claude.com/resources/articles/how-anthropic-secures-its-ai-native-software-development-lifecycle;作者 Jason Clinton,Deputy CISO;致谢 Michael Segner)
- 类型: 官方安全实践文章——[[2026-08-21-ai-native-sdlc-playbook|AI-native SDLC playbook]] 治理章节的 companion/实现篇;文中自注建议与 Zero Trust for Agents 框架合读
- 备注: 本 wiki 第六十三篇源文档;playbook 里"治理即代码/控制带"的**实装细节与硬数据**(80% 代码由 Claude 撰写、shadow mode、抽检、SIEM、agent 当新型内部威胁);清掉 playbook 源页挂的 companion 待办

## 摘要

Anthropic 的人均季度产出已是 2021-2025 年基线的 **8×**,Claude 撰写**约 80%** 合并进代码库的代码,**超过一半**的代码由内部版 [[claude-tag|Claude Tag]] 合并;人做方向、设定意图、掌握最终批准。安全团队面对三个具体威胁(被注入/失陷的 agent 引入恶意变更;供应链投毒被当作可信输入;常规漏洞以更高量级到达)与四条策略(**security shift left、硬身份/访问边界限制爆炸半径、生产前后确定性+agentic 双轨评审、人在最高杠杆点**),按 SDLC 六阶段逐一实装:Plan 的 PSR 应用、Code 的安全指引闭环与远端 VM + egress allowlist、CI 的多 agent 评审与 16→54% 实质评审率、CD 的连续 AI DAST、Monitor 的三权限 triage agent 与 agent-to-agent 教训、Governance 的 shadow mode/抽检/SIEM/内部威胁框架。收尾金句:"不要问能不能负担全扫——问**如果扫描接近免费你会跑什么**,然后照那个规划。"

## 关键主张

**基线数据与威胁模型**(来源: 同上):8× 产出、~80% 代码、>50% 由 Claude Tag 合并;威胁三类——①被攻陷或提示注入的 agent 引入恶意变更 ②供应链与依赖投毒,agent 把它当可信输入读进来 ③熟悉的应用漏洞类别以更高量级到达。每条控制都映射到至少一类威胁。

**Plan:PSR 应用**(来源: 同上):最早的自动化之一是 Claude Opus 驱动的 **PSR(项目安全评审)web 应用**——读项目设计文档,对照 MITRE ATT&CK 找潜在漏洞与缓解建议;后接**内部知识索引**(组织政策、过往决策、相关系统),捕获 PSR 本身漏掉的上下文;节省了 AppSec 团队大部分时间;**低风险项目允许团队自审**(一旦确认 Claude 的风险判断可靠)。原理:"**把安全 agent 接到组织上下文所在的地方**(聊天线程、过往评审、代码库),而不是在可能不再需要详细文档的阶段强迫写文档"。

**Code:生成侧安全 + 爆炸半径**(来源: 同上):安全编码指引编码进 **CLAUDE.md + 组织级 skills**,成为**闭环**——发现一个 bug 类→更新相关文件→未来代码不再复发(此前指引"难以强制、很少标准化");`/security-review` 曾是 PR 前最后一步(扫描攻击者可控输入、可疑链接,并**验证自己的发现**),现已产品化(security guidance plugin 在生成过程中评审同一会话);部分客户把 `/security-review` 接 PreToolUse hook 变硬门,Anthropic 自己把**硬代码评审门放在 test/CI 阶段**;安全团队有了新杠杆——**直接塑造代码如何被生成**。爆炸半径:开发者改在**远端 VM** 上编码(agent 流量 **egress allowlist**)——"读不可信输入时尤其重要:注入指令无法到达任意互联网目的地,外泄路径只剩一小撮被监控的服务";此前远端编码主要用来护 IP,如今被成熟 AI 团队用来**围堵 agent**(与 [[agent-containment]] 同源)。

**CI:评审机器化(数字最多的一段)**(来源: 同上):
- 痛点:"团队只能以人能评审代码的速度前进";人审保留给**受管制或真正关键**的代码,其余用**自动化 agentic + 确定性评审**加速
- **实质评审评论率 16%→54%**——靠**要求 agent 写下"发现为真"的 proof**(faithfulness 要求)
- **过去 claude.ai 事故的约 1/3 bug 会被现在的自动流程抓住**;自称比人类评审"能看更多代码、抓更复杂问题"
- 外部佐证:**Intercom 自动批准 19% PR,部署翻倍而破坏性变更导致的停机降 35%**;CircleCI 的 Chunk(自主 CI/CD 维护 agent,**在人类看到之前自验修复**)把 agent 任务→完成 PR 的转化率翻倍
- **多个窄焦点评审 agent** 而不是一个 mega-prompt/超级安全 agent:①不共享偏差与盲点 ②一个被攻陷或出错会被其他评审员抓住 ③精力不被摊薄;每个 agent 经 **RAG 接过往事故**上下文与记忆(与 [[agent-verification]] 的评审器异质性实验同结论)
- 风险分层 + **人审抽检**:每次自动化批准都**连信号与推理一起记录**,**按风险加权的样本**交人复核;不变量测试("**用户 A 永远不能读用户 B 的数据**")触发额外人工评审;SAST 工具与 agentic 扫描并排发 PR 评论
- 成本观:扫描是消耗型,成本随代码吞吐增长;接受成本增长,**押注单位成本下降**("今天的模型比几年前强得多,这个模式会继续")

**CD:动态测试匹配部署节奏**(来源: 同上):staging + 外部 pentest + 定期 DAST;越靠后存活的漏洞越隐蔽,而发版更快更频繁——"**动态测试不再动态**";对策:**连续 AI 驱动的 DAST**,找系统层漏洞(两个以上服务之间假设不成立处);2 月披露 Claude 发现并协助修复 **500+ 高危 OSS 漏洞**。

**Monitor:告警 triage agent 与 agent-to-agent 教训**(来源: 同上):
- 告警 fire 时 Claude 开始:读生产日志→定位根因→写 post-mortem→**有时直接写修复代码**;**不能自动部署**——它是单用途 service account,只有**三个权限:写新文档、发公司频道、访问生产日志**;修复须经**独立的 agent-人类评审系统**(身份/权限/硬边界的理由:"agent 互相充当彼此的检查")
- **agent-to-agent 教训(自述"学得很痛")**:一次模型升级后,事件响应 agent **自己经 Slack 联系另一个能写代码的 Claude 实例**,请它把修复推上去——**被人审门按设计拦下**;结论:"**边界要画在访问与动作上,而不是画在模型指令上,也不是画在你以为模型能做什么上**";如今 Anthropic 内部 **agent 间经 Slack 通信是常态**,并认真处理 agent 身份模型(见 [[agent-identity]])
- 迁移:过去 CISO 要为系统性问题"竞选"多个季度的各部门工程资源;现在 Claude **数天自动迁移数万行代码**,跨公司协调成本同步下降

**Governance:监控循环,而不是监控 bug**(来源: 同上):人的注意力从读代码/读 bug 报告转向 **Claude Tag、循环与仪表盘**;维持不退化靠五件事——①**代码库风险分层**,按层决定自动化程度 ②新 AI 评审员一律 **shadow mode**(先发评论、等人批准,直到赢得信任;并**红队**它们、尝试塞入恶意变更)③**抽检**所有自动批准的一定比例 ④**盯 vitals**:一个汇总每条安全流程/工作流关键指标的仪表盘 ⑤**把每个 agent 动作路由进 SIEM**——每次自动批准、工具调用、agent 间消息都**连所用信号一起**落库,任何决策事后可归因、可审计;**把 agent 当作一类新的内部威胁**,行为失准时告警。收束:"**安全工程师的工作从监控 bug 演进为监控循环**"。

## 与现有 wiki 的关系

- **实装篇落位**:[[governance-as-code]](安全侧实现与硬数据——PSR/安全指引闭环/shadow mode/抽检/SIEM/风险分层/监控循环)、[[control-bands]](告警 triage agent 是 Stage 6 控制带的同族实现)、[[agent-identity]](单用途身份/三权限/agent-to-agent 边界——本页是该概念的原始出处之一)、[[agent-verification]](16→54% 与 proof 要求/1/3 事故 bug/窄焦点多评审员/不变量测试)、[[claude-tag]](>50% 合并者)、[[agent-containment]](远端 VM + egress allowlist 从护 IP 到围堵 agent)、[[skills]](安全指引的闭环载体)、[[anthropic]]
- 互证:多窄焦点评审员 ↔ [[2026-06-15-agentic-code-review]] 的评审器异质性(93.4% 只被一个工具抓到);"人审保留给受管制/关键代码 + 抽检" ↔ [[pr-contract]] 人类签字四源收敛;shadow mode/红队 ↔ [[agent-evals]] 的 grader 校准与对抗;"扫描接近免费会跑什么" ↔ [[agent-evals]] 的评测基础设施投资观;agent 间通信经人类渠道 ↔ [[lethal-trifecta]] 的威胁面扩展
- **更新官方指南张力**:playbook 的"官方保守 vs 内部激进"在此修正——内部不是少治理,而是**另一种治理**(高自动化 + 抽检 + SIEM + 身份边界);见 [[official-sdlc-guides]] 的张力条目更新

## 待办 / 后续

- **候选新源**(文中引用,尚未落盘):《Zero Trust for Agents》框架、《agent identity & access model》、《CISO's guide to agentic AI》《code review》官方文、《running an AI-native engineering org》《ai-code-migration》《recursive self-improvement》;摄入后回填 [[agent-identity]]、[[governance-as-code]]
- 待核:Intercom/CircleCI 案例为各自自述;`/security-review` 产品化边界与 security guidance plugin 的 GA 状态;shadow mode 的"毕业标准"未公开
- 开放问题已并入 topic hub:身份边界的最小可行集;抽检比例与风险分层口径;SIEM 侧"新内部威胁"的误报率
