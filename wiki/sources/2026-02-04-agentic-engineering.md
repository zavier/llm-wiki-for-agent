---
type: source
tags: [ai-agents, terminology, vibe-coding, agentic-engineering, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Agentic Engineering (2026-02-04)

- 原文: `raw/Agentic Engineering.md`
- 类型: 技术博客([[addy-osmani]],发布于 **2026-02-04**,frontmatter 已标注)
- 备注: 本 wiki 第二十八篇源文档;术语定名文——vibe coding 成为"行李箱词"(suitcase term)后,为纪律化版本正名的过程记录;Karpathy 提出 "agentic engineering" 后 Osmani 采纳;配套书籍 *Beyond Vibe Coding*(O'Reilly,beyond.addy.ie);Karpathy 推文与 Willison 文为外部引用(待核)

## 摘要

一年前 Karpathy 造出 "vibe coding" 描述一种"兴高采烈地鲁莽"的编程方式:prompt、把键盘交给 AI、全盘接受、不读 diff、把错误贴回去迭代——**"人是 prompt DJ,不是工程师"**。问题是 vibe coding 变成了行李箱词:从周末黑客到有纪律的工作流全被叫成 vibe coding,混为一谈造成真实困惑与真实损害。本文给出:①vibe coding 的正确定义与合法用途(绿地 MVP/原型/hackathon、个人脚本、学习探索、创意头脑风暴——"如果 vibe coding 让数百万原本不能的人能造软件,那是真实的胜利");②失败模式("演示时很棒,现实到来就完了"——"这不是工程,是碰运气 hoping");③术语谱系(AI-assisted engineering → Willison 的 vibe engineering → Karpathy 的 **agentic engineering**,"vibe" 一词负资产太重——"跟 CTO 说你在 vibe engineering 他们的支付系统,你能看到他们脸上的担忧");④agentic engineering 的实践与技能差距。

## 关键主张

**Agentic engineering 为什么成立**(三个理由):①**描述实际发生的事**——你编排能执行/测试/精化代码的代理,同时作为架构师/评审者/决策者;你可能只手写一小部分代码,其余来自你指导下的代理;是 agentic;全程施加工程纪律;是 engineering ②**职业上可读**——能对工程 VP 说出口、能进职位描述、能建团队实践 ③**划出干净界线**——vibe coding = YOLO;agentic engineering = AI 做实现、**人拥有架构/质量/正确性**;术语本身强制执行区分;光谱:vibe coding ↔ AI-assisted engineering(中间)↔ agentic engineering

**实践四步**(不复杂但需要 vibe coding 明确抛弃的纪律):①**从计划开始**——prompt 之前先写设计文档或 spec(可 AI 辅助),拆成明确定义的任务,决定架构——vibe 党跳过、项目出轨的地方 ②**指挥,然后评审**——给代理良好界定的任务;以对人工队友 PR 同样的严格度评审;"**如果你解释不了一个模块是干什么的,它就不该进**" ③**测试不倦**——**最大的区分器**;有扎实测试套件,代理能循环迭代到测试通过,给你高置信;没有测试,它会兴高采烈地在坏代码上宣布"完成";"**测试是你把不可靠的代理变成可靠系统的方式**" ④**拥有代码库**——维护文档、版本控制+CI、监控生产;AI 加速工作,但你为系统负责

**反讽:AI 辅助开发比传统开发更奖励好工程实践**——spec 越好,AI 输出越好;测试越全面,委派越自信;架构越干净,AI 越少幻觉出奇怪抽象;"AI 没造成问题;跳过设计思考造成了"

**技能差距(不舒服的真相)**:agentic engineering **不成比例地惠及资深工程师**(深层基础 → 巨大杠杆;知道好代码长什么样 → 高效评审与纠正);初级工程师在建立基础前依赖 AI 有 **skill atrophy** 风险——"一代能 prompt 但不会 debug、能生成但不会推理自己生成物的开发者",工程领导已标记为浮现中的危机;不是反对 AI 辅助开发的论据,是对它要求什么的诚实论据;**"agentic engineering 不比传统工程更容易——它是另一种难:拿打字时间换评审时间、实现努力换编排技能、写代码换读与评估代码"**

**前进方向**:诚实术语(agentic engineering = 有监督的纪律化开发;vibe coding = 有趣的鲁莽原型,别用一个词叫两件事);**更好的评估框架**(系统化衡量 AI 辅助工作流是否产出可靠软件,而不只是更快的软件);投资基础(架构思考/安全意识/系统设计的溢价上升而非下降);金句:"**AI 编码的兴起不取代软件工程的技艺——它抬高了对它的要求**。茁壮的不是 prompt 最快的人,是对自己在建什么和为什么想得最清楚的人";"vibe coding 展示了丢下所有约定的可能;现在是时候把工程带回来了"

## 与现有 wiki 的关系

- 新建概念: [[agentic-engineering]](纪律化工作流的正名)
- 更新了 [[vibe-coding]](行李箱词问题 + 谱系 + 失败模式)、[[simon-willison]](vibe engineering 术语提案)、[[addy-osmani]](书籍)、[[ai-feature-implementation-loop]]
- 关键互证:"测试是把不可靠的代理变成可靠系统的方式" ↔ [[agent-verification]]/[[factory-model]] 验证是瓶颈;"AI 更奖励好工程实践" ↔ spec 杠杆([[ai-agent-spec]])与 [[conformance-testing]];"解释不了就不该进" ↔ [[comprehension-debt]]/[[pr-contract]] 知识转移义务;skill atrophy ↔ Anthropic RCT 理解力 -17% 与 [[cognitive-surrender]] 的路径依赖(同一危机的两个表述);术语谱系 ↔ [[simon-willison]] 的 vibe engineering 与 [[vibe-coding]] 页;频谱图 ↔ [[conductor-orchestrator]] 的角色光谱(术语与角色两个坐标系)

## 待办 / 后续

- Karpathy 推文(2019137879310836075)与 Willison vibe-engineering 原文核实;"一代能 prompt 不能 debug"危机的量化研究(与 Anthropic RCT 的关系)
- 评估框架("可靠软件 vs 更快软件"的测量)进展;Beyond Vibe Coding 书籍框架
