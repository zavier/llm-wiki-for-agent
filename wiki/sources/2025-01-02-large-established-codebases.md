---
type: source
tags: [ai-agents, goedecke, large-codebases, engineering-culture]
topic: ai-agents
created: 2026-08-04
updated: 2026-08-04
status: active
---

# Mistakes engineers make in large established codebases (2025-01-02)

- 原文: `raw/Mistakes engineers make in large established codebases.md`(AI 直抓版 2026-08-04;raw frontmatter 由抓取脚本补全)
- 类型: 个人博客文章([[sean-goedecke]]);本 wiki **第四十七篇源文档**
- 出处核实: 发布 **2025-01-02**(站点页头 "January 2, 2025" 确认;tags: tech companies, software design, large codebases);URL https://www.seangoedecke.com/large-established-codebases/;HN 讨论 https://news.ycombinator.com/item?id=42627227
- 定位: Goedecke 大代码库主题的**奠基操作篇**——纯前 AI(正文零 AI 提及;目前摄入最早的 Goedecke 源);为 [[2025-12-24-nobody-knows-how-software-products-work|nobody-knows]](战争迷雾)、[[2025-04-12-wicked-features|wicked-features]]、[[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]] 提供**实现侧原则**(一致性/prior art/删除代码)

## 摘要

大代码库(单数位百万行 ~5M、100-1000 工程师、首个可用版本 ≥10 年)的首要错误 = **不一致**——用"最合理的方式"实现、远离遗留代码以保持干净,必须抵制;要尽可能深地沉入遗留代码库以维持一致性(既有功能 = 穿过雷区的安全路径;不一致 = 负反馈循环,通用改进不可能)。其余:生产足迹、测试限制(靠监控)、依赖谨慎、删除代码(instrument 驱动调用者到零)、小 PR + 前置跨团队改动。辩护:大代码库产生**90% 的价值**;不先理解就无法拆解。

## 关键主张

- **定义**:~5M 行 / 100-1000 工程师同库 / 首个版本 ≥10 年;无法提前练习(开源不提供同等经验,个人项目必然小而全新)
- **首要错误 = 不一致**:限制与既有代码的接触点、把功能做成"最合理方式" = 让小角落比代码库其余部分更漂亮——必须抵制;**一致性为什么重要**:①防地雷(你不知道 bots 概念/内部工具可代表用户认证/"另外一百件你不知道的事"——**既有功能 = 穿过雷区的安全路径**)②减缓滑向混乱 ③通用改进的前提(新用户类型只需更新 auth helpers;不一致则逐个更新测试,通用改动不发生或"最难 5% 端点被留出范围"→ 一致性进一步下降 = **负反馈循环**)
- **操作铁律**:实现任何东西前先找 prior art,尽可能跟随;不跟随现有模式必须有非常充分的理由
- **生产足迹**:哪些端点最常打/最关键(付费客户、不可优雅降级)/热路径——常见错误 = "小调整"意外落在关键流程热路径
- **测试限制**:大项目累积状态(如 GMail 的用户种类),无法测所有组合——测关键路径 + 防御性编码 + 慢发布 + 监控
- **依赖谨慎**:代码活得比你的任期长;依赖 = 持续安全漏洞/更新成本;选广泛使用可靠的,或易 fork 的
- **删除代码**:有机会就删(大代码库风险最高的工作,别半吊子:先 instrument 识别生产调用者、驱动到零,确定安全才删);"很少有比安全移除代码更有价值的事"
- **小 PR + 前置跨团队改动**:依赖其他团队的领域专家预判你漏掉的东西;小而易读的 risky 改动让专家更容易救你
- **90% 价值辩护**:大公司多数收入活动来自大代码库("legacy mess" = 公司实际做的事,"这就是你的工作");**不先理解就无法拆解**——只见过"已能流畅在内部交付功能"的团队成功拆解,无法从第一性原理重新设计任何真正赚钱的项目(太多偶然细节支撑数千万美元收入)

## 与现有 wiki 的关系

- 新建概念页 [[codebase-consistency]];更新 [[theory-building]](一致性 = 理论的供给侧条件)、[[pure-impure-engineering]](90% 价值 = impure 是公司实际工作的论证)、[[sean-goedecke]]、[[ai-feature-implementation-loop]](规范层"参照既有模式"获得一手依据)
- 互证:prior art 安全路径 ↔ [[2025-12-24-nobody-knows-how-software-products-work|战争迷雾]](代码库 = 唯一可靠答案源,雷区 = 未知地雷);"不能拆解除非先理解" ↔ [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]] 的"成功重写 = 先切块再逐块重写"——**机制闭合**;不一致负反馈 ↔ [[2025-04-12-wicked-features|wicked features]] 连锁与认知债累积;小 PR/领域专家 ↔ [[pr-contract]];删除代码(证据化) ↔ 验证纪律([[agent-verification]])
- 同标签相关文:staff-engineer-promotions(职业向,弱相关);HN 讨论可作社区反应样本

## 待办 / 后续

- 开放问题:agent 的一致性维护(LLM 默认"最合理方式"而非 prior art——如何让代理跟随既有模式;不一致的量化检测,见主题页与 [[codebase-consistency]])
- "90% 价值"为作者经验判断(非数据)——待核;HN 讨论(42627227)可作社区观点样本
