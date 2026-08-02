---
type: concept
tags: [ai-agents, development-practice]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [simon-willison, lethal-trifecta, ai-agent-spec, cognitive-surrender, comprehension-debt, agentic-engineering]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-05-05-cognitive-surrender, 2026-02-04-agentic-engineering]
status: active
---

# Vibe coding

靠直觉与快速迭代让 AI 写代码的原型化开发方式;适合探索与一次性项目,但不应与生产工程混淆。

## 关键信息

- 定义:快速原型/探索性开发的模式,低纪律、高迭代(来源: [[2026-01-13-good-spec-for-ai-agents]])
- 与 **AI-assisted engineering** 的区别:后者需要 spec、测试、审查的完整纪律——"知道自己在哪种模式"是关键
- 风险:无纪律地把 vibe 代码直接上生产 = 自找麻烦;叠加 [[lethal-trifecta]] 后更危险
- 相关变体:"vibe engineering"(Willison)——先写好文档,模型可能仅凭文档生成匹配实现;这其实是"文档先行"的工程化版本
- **行李箱词问题**(来源: [[2026-02-04-agentic-engineering]]):vibe coding 从"不读 diff 的 YOLO"被滥用为从周末黑客到纪律工作流的统称——混为一谈造成真实损害;正确定义 = **going with the vibes + 不评审代码**("人是 prompt DJ,不是工程师");合法用途:绿地 MVP/原型/hackathon、个人脚本一次性工具、学习探索、创意头脑风暴("如果它让数百万人能造软件,那是真实的胜利");失败模式:"演示时很棒,现实到来就完了"——改/扩/加固时发现没人懂代码在干什么("这不是工程,是碰运气")
- **术语谱系定案**:vibe coding(YOLO)→ AI-assisted engineering(人在环)→ vibe engineering(Willison,"vibe" 负资产) → **[[agentic-engineering|agentic engineering]]**(Karpathy 命名,Osmani 采纳:AI 做实现、人拥有架构/质量/正确性;职业上可读、划出干净界线)
- Osmani 立场:原型用 vibe 没问题,上线必须切回工程模式
- **投降风险**(来源: [[2026-05-05-cognitive-surrender]]):"信任 vibe"的 solo 工作流正是 [[cognitive-surrender|认知投降]]的高发区——只审关键部分 + 依赖测试兜底 = "追认而非评审";Peter Steinberger 式"大部分代码我不读"即投降姿态;反制:先构建期望再读输出、把 diff 当成 AI 没写过、每周无 AI 键盘时间校准(见 [[comprehension-debt]])

## 与其他页面的关系

- 管理/风险视角: [[lethal-trifecta]]、[[simon-willison]]
- 工程化替代路径: [[ai-agent-spec]]、[[spec-driven-development]]、[[agentic-engineering]]
