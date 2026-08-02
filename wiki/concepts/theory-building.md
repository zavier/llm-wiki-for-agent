---
type: concept
tags: [ai-agents, cognition, theory, naur]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-03
refs: [comprehension-debt, cognitive-surrender, intent-debt, distillation-anxiety, sean-goedecke, pure-impure-engineering]
sources: [2026-02-09-cognitive-debt, 2026-03-23-triple-debt-model, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2025-12-24-nobody-knows-how-software-products-work, 2025-06-22-pure-and-impure-engineering]
status: active
---

# Theory building (程序即理论)

Peter Naur 1985《Programming as Theory Building》:程序的主要产品不是代码,而是开发者头脑中的"程序理论"——对程序是什么、为什么的直觉性理解,只能被代码与文档部分捕获。本 wiki 的交锋点:[[2026-02-09-cognitive-debt|Storey]] 以它立认知债之论,[[sean-goedecke|Goedecke]] 直接反驳它。

## 关键信息

**原始主张**(Naur 1985;哲学基础 Ryle《心的概念》1949)

- 代码是理论的**副产品/部分表达**;理论 = 直觉性的 what's happening and why;丢了代码能重写程序,丢了理论(如团队 100% 换血)就看不懂代码
- Naur 激进推论:**理论不应从代码重建**——"仅从文档重建程序理论严格不可能……应废弃程序文本,让新团队重新解决"(废弃重建论)

**Storey 的沿用**(来源: [[2026-02-09-cognitive-debt]]、[[2026-03-23-triple-debt-model]]):理论碎片分布在许多(可能上千)开发者头脑——系统理论 = 团队级共享理解;**认知债 = 共享理论的侵蚀**(不需要一个人理解全部,需要"足够共享"以安全变更);三层系统健康中的 Shared understanding 层;警告信号:犹豫变更/部落知识/黑箱感

**Goedecke 的反驳**(来源: [[2026-07-11-in-defense-of-not-understanding-your-codebase]])

- ①**大系统无法从零重建**:有用户的系统含数千个无法重实现的 weird cases;成功重写 = 先切块再逐块重写(本质是对旧系统的修改)②**废弃代码库复活是常态**:从一条流端到端开始重建理论,逐步扩展——"建立新理论是可能的"
- 宽容解释:1985 的"大程序"(20 万行监控程序、编译器)比今天小几个数量级(GCC 1987 十万行 → 2015 一千四百万行);废弃重建论在当时或许成立
- 大系统里人人持**部分错误理论**——能力 = 带着部分正确的理论工作(take a position、educated guess、承担后果)
- 理论维护只是众多价值之一(别人写代码/法定功能/同事离职/安全补丁/依赖都在损害它);LLM 双刃剑:更难建详细理论 vs 快速建部分理论并更好利用(作者未定论)

**Ryle 复读**(Goedecke 脚注):Ryle 比 Naur 更宽容——know-how 自动随行动形成,纯靠摸索代码建立理论是可能的

**时间性理论**(Joel Adejola 推文,Goedecke 转述):理论可能本质是**时间性**的——能答"为什么此时建 X""Y 何时加入";连接 [[intent-debt]](意图的时间维度)

**经验证据:战争迷雾**(来源: [[2025-12-24-nobody-knows-how-software-products-work]]):大系统基本问题常只有少数人能答,有时**零人**——回答 = 研究;结构性原因:[[wicked-features|wicked features]] 影响每个其他功能,系统复杂到禁止理解;代码库 = 唯一可靠答案源("能回答问题"是工程团队核心职能,是工程师机构权力的结构性原因);reorg 摧毁默会知识 → 回答退化为调查(交互产品/读码/"探索性手术"——改代码或强制检查恒真,独立于写码的稀缺技能);答案不持久(每次变更引入新细节与例外,同一问题反复研究);很多行为**没有自觉意图**、从"默认选择"的相互作用中涌现——文档写作者"第一次发现系统如何工作"

**文化层**(来源: [[2025-06-22-pure-and-impure-engineering]]):全理解是 pure 文化理想(小系统、低流动可行),部分理解是 impure 文化常态(大系统、高流动);pure 在线上过度代表;AI 对两种文化帮助不对称(impure ~30% 提速 vs pure 几乎无)——见 [[pure-impure-engineering]]

## 与其他页面的关系

- [[comprehension-debt]]:理论构建受损 = 理解力债务的认知侧;Goedecke 对冲:部分理解是常态,债务要标定(见该页)
- [[cognitive-surrender]]:不构建理论 = 投降;部分理论 + 承诺猜测 = 第三路径
- [[distillation-anxiety]]:"理论可否从代码重建"之争 = 知识导出恐惧的学术底牌(可重建的 vs 随人消失的)
- [[intent-debt]]:temporal theory = 意图的时间维度;决策日志记 what/why 也记 why-then
