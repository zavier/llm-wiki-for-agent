---
type: concept
tags: [ai-agents, engineering-culture, human-factor]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-09
refs: [theory-building, comprehension-debt, cognitive-surrender, sean-goedecke, agentic-engineering, wicked-features, codebase-consistency, senko-rasic]
sources: [2025-06-22-pure-and-impure-engineering, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2025-02-10-engineers-who-wont-commit, 2025-04-12-wicked-features, 2025-01-02-large-established-codebases, 2026-08-08-code-was-never-the-hard-part]
status: active
---

# Pure / impure engineering

两种工程文化:pure(把技术问题做到尽可能完美——艺术/研究,开源典型)vs impure(尽可能高效解决现实问题——水管/施工,公司内交付典型)。不同领域而非能力等级;许多行业争论源于两种文化碰撞——互相以为对方不称职。

## 关键信息

**定义**(来源: [[2025-06-22-pure-and-impure-engineering]])

- pure = 美学驱动 + 开放式(可以永远打磨);impure = 美学从属于雇主需求 + 必须按时完成(意味着妥协)
- **不是能力等级**:认为 impure = 不够聪明的 pure,等于"工程师 = 不够聪明学物理"的同类谬误;两个领域需要不同技能(案例:Casey Muratori 技术判断对 ≠ 比 Windows Terminal 团队高明;George Hotz 进 Twitter"修搜索"失败后做 tinygrad = 回到 pure 主场)
- **2010s 失真**:公司靠 hype 雇佣,资助 pure 工程 = 开源门面 + 无底洞工作("隐性的开发者营销");微服务/CQRS 迁移潮 = impure 被 pure 殖民;时代结束后 pure 工程师觉得工作"变政治",实际是角色不再被资助
- **impure 工程是混战**:数十年技术决策 + 产品政治 + 共识 + [[wicked-features|wicked features]] 附带复杂度——"impure 工程这么高薪是有原因的";pure 工程师普遍低估它的难度

**AI 有用性差异**(来源: [[2025-06-22-pure-and-impure-engineering]])

- pure 工作:长时间打磨你比社区都懂的问题 + 无限时间 → 每个决策你都比 LLM 聪明,LLM 无用(pure 工程师对 AI 的轻蔑 = 视角局限)
- impure 工作:松散工作理解 + 问题对你新但对世界不新 + 截止日期 → LLM 部分决策点同样聪明或更聪明;作者自报 **~30% 提速,与类型系统/调试器同级**
- 解释"AI 对一些人神奇、对另一些人完全无用";METR impact-of-ai 佐证(脚注,待核):熟悉自己 pure 代码库的工程师从 AI 工具获得的提速很小
- **边界标定**(来源: [[2026-01-28-skill-formation-rct]],RCT 全文):"**需要新技能的任务无显著提速**"(n=52,完成时间 p=0.391)——只有完全委派子组(~20% 用户)快(19.5min vs 对照 23min)且以技能形成为代价;机制:写 query 的斟酌时间抵消生成收益;对照文献:熟悉任务中 Copilot +55.5%(Peng 2023)、+26.8%(Cui 2024)——**AI 提速依赖"任务所需知识已内化"的程度**;与 ~30% 自报的调和:impure 日常多为熟悉任务,而学习新库/新领域时 AI 既不快又伤技能(→ 技能形成边界,见 [[comprehension-debt]];也细化了"AI 对一些人神奇对另一些人无用":差异不只 pure/impure,还有任务新旧)

**与理解力的关系**(来源: [[2026-07-11-in-defense-of-not-understanding-your-codebase]]):pure 文化 = 全理解理想(小系统、低流动可行,Redis/The Witness);impure 文化 = 部分理解常态(大系统、高流动,Google 搜索后端/GitHub);pure 在线上讨论过度代表(开源作者更爱写博客、专有系统写不得)——"纯工程师的全理解偏好留给开源业余项目,工作中被付钱 = 采纳雇主的工程价值集"

**大代码库 = impure 的主场与 90% 价值**(来源: [[2025-01-02-large-established-codebases]],纯前 AI 操作篇):大型成熟代码库(~5M 行/100-1000 人/≥10 年)产生大公司**90% 的价值**——"legacy mess" = 公司实际做的事,"这就是你的工作";impure 工程的混战复杂度在此获得操作原则:**一致性**(prior art 先行/沉入遗留代码/抵制让小角落更干净,见 [[codebase-consistency]]);"不先理解就无法拆解" ↔ in-defense 的"成功重写 = 切块"闭合——**理解能力是 impure 工程的入场券**(给"impure 工程这么高薪是有原因的"补上机制)

**行为规范**(来源: [[2025-02-10-engineers-who-wont-commit]]):impure 文化要求最有上下文者 take a position(哪怕 55-60% 信心)——不表态 = 默许最终决定(见 [[cognitive-surrender]] 第三路径)

**外部声音:两派都要(¿Por qué no los dos?)**(来源: [[2026-08-08-code-was-never-the-hard-part]],[[senko-rasic|Senko]],2026-08-08):非 Goedecke 的第三立场——不站 pure 或 impure,主张两者是并存的技艺:"对系统的深度理解 + 对为什么建它的深度理解";"分裂人格"漫画(一边说"我解决客户问题",一边 opine monads/内存安全/DRY,客户理解 = 编造的用户画像)= 文化碰撞的讽刺画,呼应"两文化互相以为对方不称职"的机制;Senko 的"软件为什么这么 buggy"反问 = impure 混战难度的另一表述(见 [[comprehension-debt]] 维护侧)

## 与其他页面的关系

- [[theory-building]]:文化层——部分理解是 impure 的常态基线,全理解是 pure 的理想
- [[comprehension-debt]]:债务框架度量的是 impure 基线(松散理解)的 AI 恶化,而非从零到一
- [[cognitive-surrender]]:take a position 是该文化的决策义务
- [[agentic-engineering]]:纪律化 AI 开发的讨论隐含 pure 视角(架构/质量/正确性归人);AI 替代的是 impure 劳动还是增强?——两文化对"AI 该怎么用"给出不同答案
- 实体: [[sean-goedecke]](提出者)
