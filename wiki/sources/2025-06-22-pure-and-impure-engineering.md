---
type: source
tags: [ai-agents, engineering-culture, goedecke]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-03
status: active
---

# Pure and impure software engineering (2025-06-22)

- 原文: `raw/Pure and impure software engineering.md`(AI 直抓版 2026-08-03;curl+pandoc 全文,未经人工裁剪核对,raw frontmatter 由抓取脚本补全)
- 类型: 个人博客文章([[sean-goedecke]],seangoedecke.com);本 wiki **第四十篇源文档**
- 出处核实: 发布 **2025-06-22**(站点页头 post-meta 确认)
- 定位: [[2026-07-11-in-defense-of-not-understanding-your-codebase|In defense of...]] 的姊妹篇——后者引用的 "pure/impure 工程文化" 以本文为定义原文;两篇都引用 wicked features

## 摘要

两种工程工作:pure(把技术问题做到尽可能完美——艺术/研究,开源典型)与 impure(尽可能高效解决现实问题——水管/施工,公司内交付典型)。两者是不同领域而非能力等级,却常互相以为对方不称职。2010 年代 pure 工程在公司被过度资助(隐性的开发者营销),时代结束后大量 pure 工程师处境艰难。**AI 对 impure 工程帮助最大**:pure 工程师在自己专精领域几乎总是比 LLM 聪明;impure 工程师对问题只有松散理解,LLM 在不少决策点上同样聪明或更聪明——这解释"AI 对一些人神奇、对另一些人完全无用"。

## 关键主张

- **定义**:pure = 美学驱动 + 开放式(可永远打磨,艺术+研究混合);impure = 美学从属于雇主需求 + 必须按时完成(意味着妥协);作者自认 impure("pragmatic to a fault";学术哲学背景 ≈ pure)
- **2010s 失真**:hype 驱动雇佣,资助 pure 工程 = 开源门面 + 无底洞工作("隐性的开发者营销");monolith→microservices→CQRS 迁移潮 = impure 被 pure 殖民;时代结束后 pure 工程师觉得"工作突然变得政治",实际是角色不再被资助
- **公司需要两者但不等量**:组件尽量来自开源(Kafka/Redis/语言本身),需求特定才自建(GitHub 自研高性能 HTML 解析,因到处渲染 Markdown)
- **技能不对称**:pure 工程师做 impure 差(难妥协/截止日期恐慌/握不住庞大代码库);impure 工程师做 pure 差(过早接受 hacky 解/缺技术纵深);"电气工程师设计芯片 vs 业余者拼套件"式能力等级观 = "工程师=不够聪明学物理"的同类谬误
- **案例**:Casey Muratori vs Windows Terminal(技术判断对,但团队 2022-02 实现并非不合理时程);George Hotz 进 Twitter"修搜索"失败 → tinygrad(完美 pure 项目);Jonathan Blow/Jai——**impure 工程是混战**:数十年技术决策 + 产品政治 + 共识 + wicked features 附带复杂度("impure 工程这么高薪是有原因的")
- **性能权衡**:公司理性选择非最优性能(精英性能工程师不产生最多商业价值);"performance blunders 的最优率非零"(fraud 类比);作者自己用 VS Code 换掉更快的 Neovim/Alacritty
- **AI 帮助 impure 最多**:pure 工作 = 长时间打磨你比社区都懂的问题 + 无限时间 → 每个决策你都比 LLM 聪明,LLM 无用(pure 工程师轻蔑 AI 是视角局限);impure 工作 = 松散工作理解 + 问题对你新但对世界不新 + 截止日期 → LLM 部分决策点同样聪明或更聪明;**~30% 提速,与类型系统/调试器同级**(自报)
- **edit 补充**:HN 评论后澄清——pure 工程不会消失,永远有大量 pure 工作要做

## 与现有 wiki 的关系

- 新建概念页 [[pure-impure-engineering]];更新 [[sean-goedecke]]、[[theory-building]](文化层)、[[comprehension-debt]](impure 松散理解 = 基线)
- 互证:impure"握不住庞大代码库" ↔ [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]]"人人持部分错误理论";wicked features 附带复杂度 ↔ [[2025-12-24-nobody-knows-how-software-products-work|nobody-knows]](同作者)
- **METR 佐证(脚注)**:文后一个月 METR impact-of-ai 研究发布——"非常熟悉自己 pure 代码库的工程师从 AI 工具获得的提速很小"(Goedecke 视为实验验证;报告本身待核;方向性与 [[2026-01-28-skill-formation-rct|Anthropic RCT]] 一致)

## 待办 / 后续

- METR "Measuring the Impact of Early-2025 AI..."(impact-of-ai)报告核实——若一手化,与时间地平线报告([[2025-03-19-measuring-ai-long-tasks]])并列
- wicked-features 已收 ✓([[2025-04-12-wicked-features]];本文与 in-defense/nobody-knows 的机制层)
