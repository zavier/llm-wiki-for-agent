---
type: concept
tags: [ai-agents, engineering-discipline, workflow, terminology]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-09
refs: [vibe-coding, ai-agent-spec, agent-verification, conformance-testing, comprehension-debt, cognitive-surrender, factory-model, agent-management, addy-osmani, sean-goedecke, expertise-leverage, senko-rasic]
sources: [2026-02-04-agentic-engineering, 2026-05-09-ai-makes-weak-engineers-less-harmful, 2026-03-06-will-my-job-still-exist, 2025-09-15-your-code-is-your-responsibility]
status: active
---

# Agentic engineering

有纪律的 AI 辅助软件开发:代理做实现、**人拥有架构/质量/正确性**——相对 [[vibe-coding]](YOLO)的正式工作流;Karpathy 命名、Osmani 采纳的术语,频谱上位于 vibe coding ↔ AI-assisted engineering ↔ agentic engineering 的一端。

## 关键信息

**术语谱系**(来源: [[2026-02-04-agentic-engineering]]):vibe coding(Karpathy 造词,"人是 prompt DJ")→ AI-assisted engineering(Osmani 早期偏好,人在环)→ vibe engineering(Willison 提案,"vibe" 负资产太重:信号随意,CTO 听到会担忧)→ **agentic engineering**(Karpathy 提议,2026-02):三个理由——描述实际发生的事(编排能执行/测试/精化的代理,你作架构师/评审者/决策者)、职业上可读(能进职位描述)、划出干净界线(术语本身强制执行区分)

**实践四步**:

1. **从计划开始**:prompt 前先写设计文档/spec(可 AI 辅助),拆明确定义的任务,决定架构——vibe 党跳过、项目出轨的地方(见 [[ai-agent-spec]])
2. **指挥,然后评审**:以对人工队友 PR 的严格度评审;"**如果你解释不了一个模块是干什么的,它就不该进**"(见 [[pr-contract]] 知识转移义务;独立表述来源: [[2025-09-15-your-code-is-your-responsibility]],[[senko-rasic|Senko]]:提交 PR = 声明完全理解,与工具无关)
3. **测试不倦**:最大的区分器——有测试套件,代理循环迭代到通过,给你高置信;没测试,它兴高采烈地在坏代码上宣布"完成";"**测试是你把不可靠的代理变成可靠系统的方式**"(见 [[agent-verification]])
4. **拥有代码库**:维护文档、版本控制+CI、监控生产;AI 加速工作,你为系统负责

**核心反讽**:AI 辅助开发**比传统开发更奖励好工程实践**——spec 越好输出越好、测试越全面委派越自信、架构越干净幻觉越少;"AI 没造成问题;跳过设计思考造成了"(与 [[factory-model]] spec 杠杆互证)

**技能差距**:不成比例地惠及资深工程师(基础 → 力乘器);初级工程师有 **skill atrophy** 风险——"一代能 prompt 但不会 debug、能生成但不会推理自己生成物的开发者";"agentic engineering 不比传统工程更容易——**它是另一种难**:拿打字时间换评审时间、实现努力换编排技能、写代码换读与评估代码"(见 [[comprehension-debt]] 与 [[cognitive-surrender]] 的同一危机表述);RCT 全文核实( [[2026-01-28-skill-formation-rct]] ):学新库时 AI 辅助 quiz 低 **17%**(d=0.738)、**无平均提速**(p=0.391);高分交互 65-86% vs 低分 24-39%;论文明言 chat 界面 = 认知卸载**下界**——agentic 工具下技能损失更大("一代能 prompt 不能 debug"的担忧被坐实);**组织级印证**(来源: [[2026-05-09-ai-makes-weak-engineers-less-harmful]],Goedecke):弱工程师变 Claude Code 薄包装(同事视角 ≈ 与 LLM 实例经 Slack 协作)——地板抬高的"改进"与本人学得更少并存;没有强工程师薄包装化(基线品味抓 AI 错误),技能差距自我选择地只落在净负端;**经济追问**:"AI 给工程师加的价值"之后是"**工程师给 AI 加的价值**",没加多少的失业——skill atrophy 从个体风险升级为雇佣风险(与 [[expertise-leverage]] 的"人=瓶颈"互证:瓶颈侧价值上升,非瓶颈侧被压缩);**行业级版本**(来源: [[2026-03-06-will-my-job-still-exist]]):Goedecke 自认"没有真正的新能力 AI 代理需要才能取代我——只需更好更可靠";初级/中级先受苦(staff 的监督工作早就像 AI 代理管理);超调世界(停止雇人太早)→ 资深需求中期上升——skill atrophy 从个体/雇佣风险升级为**行业收缩风险**("我爱的这份工作正在消失")

**前进方向**:诚实术语(别一个词叫两件事);**更好的评估框架**(衡量"可靠软件"而不只是"更快软件");投资基础(架构/安全/系统设计溢价上升);"AI 编码的兴起不取代软件工程的技艺——**它抬高了对它的要求**"

## 与其他页面的关系

- 光谱另一端: [[vibe-coding]];纪律机制: [[ai-agent-spec]]、[[agent-verification]]、[[conformance-testing]]
- 人侧: [[comprehension-debt]](skill atrophy 的债务侧)、[[cognitive-surrender]];规模化: [[agent-management]]、[[factory-model]]
- 倡导者: [[addy-osmani]](书:Beyond Vibe Coding);来源: [[2026-02-04-agentic-engineering]]
