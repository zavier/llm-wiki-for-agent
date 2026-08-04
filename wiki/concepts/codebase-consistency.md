---
type: concept
tags: [ai-agents, engineering-culture, large-codebases, legacy]
topic: ai-agents
created: 2026-08-04
updated: 2026-08-04
refs: [theory-building, wicked-features, pure-impure-engineering, comprehension-debt, sean-goedecke, pr-contract, agent-verification]
sources: [2025-01-02-large-established-codebases, 2025-12-24-nobody-knows-how-software-products-work, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2025-04-12-wicked-features]
status: active
---

# Codebase consistency (代码库一致性)

大代码库(~5M 行/100-1000 工程师/≥10 年)的**首要工程原则**:沉入遗留代码、跟随 prior art、抵制"让小角落比代码库其余部分更干净"的冲动——不一致 = 首要错误([[sean-goedecke|Goedecke]] 2025-01-02,纯前 AI 操作篇)。与 [[wicked-features]](需求侧:影响每个其他功能的需求)互补的实现侧原则:wicked features 决定了"有哪些雷",一致性决定"你走不走安全路径"。

## 关键信息

**为什么一致**(来源: [[2025-01-02-large-established-codebases]])

- **防地雷**:你不知道代码库所有令人惊讶的事(bots 概念/内部工具可代表用户认证/"另外一百件你不知道的事")——**既有功能 = 穿过雷区的安全路径**;跟随存活已久的端点 = 不用知道所有地雷就能安全行进
- **减缓滑向混乱**:一致性是代码库的防腐剂
- **通用改进的前提**:一致 → 新用户类型只需更新 auth helpers 集合;不一致 → 逐个更新+测试每个实现 → 通用改动不发生,或**最难 5% 端点被留出范围** → 一致性进一步下降 = **负反馈循环**(与 wicked 连锁/认知债累积同构)

**操作原则**(来源: [[2025-01-02-large-established-codebases]])

- 实现任何东西前先找 prior art,尽可能跟随;不跟随 = 必须有非常充分的理由
- 理解生产足迹(最常打的端点/付费客户关键路径/热路径——"小调整"落在热路径 = 经典事故)
- 测试限制:无法测所有状态组合 → 关键路径 + 防御性编码 + 慢发布 + 监控
- 依赖谨慎(代码活得比任期长)、删除代码(先 instrument 驱动调用者到零 = 证据化安全删除,见 [[agent-verification]])
- 小 PR + 前置跨团队改动:让领域专家能预判你漏掉的东西(见 [[pr-contract]])

**90% 价值辩护**:大公司多数收入活动来自大代码库——"legacy mess" = 公司实际做的事,**这就是你的工作**;不先理解就无法拆解(成功拆解者 = 已能流畅内部交付的团队;无法从第一性原理重新设计真正赚钱的项目)——与 [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]] 的"成功重写 = 切块再逐块重写"**机制闭合**

**理论侧**(见 [[theory-building]]):一致代码库 = 理论可构建/可维护——prior art = 可复用的既有理论片段;不一致 = 每个端点一个局部变体,理论碎片化,"最难 5% 留出范围"= 部分理论干脆无法成立;删除代码(证据化)= 理论修改的安全手术

**AI 时代接口**(本 wiki 综合;源文纯前 AI):LLM 默认生成"最合理方式"而非 prior art——一致性维护成为代理时代的新问题;规范层对策 = "参照既有模式"(指向源码/示例,见 [[ai-feature-implementation-loop]]);AI 生成不一致代码 → 理论碎片化加速([[comprehension-debt]] 供给侧)

## 与其他页面的关系

- [[wicked-features]] — 需求侧(哪些雷)vs 本页实现侧(走不走安全路径);"老兵=熟悉全部 wicked features" ↔ "prior art 检索 = 用代码库回答这里该怎么做"
- [[theory-building]] — 一致 = 理论可维护的供给侧条件
- [[pure-impure-engineering]] — impure 工程的操作原则;90% 价值 = impure 是公司实际工作的论证
- [[2025-12-24-nobody-knows-how-software-products-work|nobody-knows]] — 雷区 = 战争迷雾的实现侧面貌
- [[pr-contract]]、[[agent-verification]] — 小 PR/证据化删除的评审与验证侧
