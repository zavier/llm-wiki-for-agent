---
type: concept
tags: [ai-agents, cognition, theory, naur]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-09
refs: [comprehension-debt, cognitive-surrender, intent-debt, distillation-anxiety, sean-goedecke, pure-impure-engineering, expertise-leverage, senko-rasic]
sources: [2026-02-09-cognitive-debt, 2026-03-23-triple-debt-model, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2026-07-24-llms-reward-expertise, 2026-04-03-programming-with-ai-agents-as-theory-building, 2025-12-24-nobody-knows-how-software-products-work, 2025-06-22-pure-and-impure-engineering, 2025-01-02-large-established-codebases, 2026-08-08-code-was-never-the-hard-part]
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

**应用延伸:理论 = LLM 使用杠杆**(来源: [[2026-07-24-llms-reward-expertise]]):对代码库有理论就能把 LLM 推得*更狠*——"不,可以更简单""但我们不是已经做了 X 吗""能用熟悉的术语表达吗";没有理论只能接受模型第一版(cling 着 LLM 得 *something*,"不坏"但上限低);Tao×ChatGPT 案例:对数学有理论才能从多段输出中抓想法/提替代表述/识别"看起来不对劲";与"部分理论+承诺猜测"第三路径一致——部分理论已足以把模型推得更狠;**专长杠杆的资本(理论)正被 AI 使用侵蚀**(RCT quiz -17%,见 [[expertise-leverage]])——in-defense 的"LLM 双刃剑未定论"在使用侧向"理论决定你能把模型用多狠"收敛

**Ryle 复读**(Goedecke 脚注):Ryle 比 Naur 更宽容——know-how 自动随行动形成,纯靠摸索代码建立理论是可能的

**Goedecke 第二论辩:LLM 与理论构建**(来源: [[2026-04-03-programming-with-ai-agents-as-theory-building]],2026-04-03;反驳"LLM 让工程师跳过理论构建所以不该用"与"LLM 没有理论所以好结果皆假象")

- **承认 + 反驳(批评一)**:LLM 让工程师(甚至尽责者)构建**更不详细**的心智模型——offload 认知努力是有意为之;但所有心智模型本来就略过细节("breadth of your stack":依赖/Linux 抽象/进程/套接字/汇编),放弃任何细节 ≠ 灾难;理论不必详细到"告诉你每行代码怎么写"才有用
- **80/20/10 评审漏斗(工作流实证,单一样本自报)**:2-3 并行 agent → 扫描 + snap judgement(是否契合我的系统理论)→ ~80% 不匹配即 kill 或"你没考虑 X" → 20% 仔细评审 + 自己摸代码/手测 → 约一半进 PR;**仅 ~10% agent 输出进入产出**;理论略欠详细但**仍是"我的"理论**(否则会接受大部分而非拒绝几乎全部)——"部分理论够用"的量化
- **LLM 能否构建理论(批评二)**:①能做出有效修改 → 或 pattern-match 训练数据中足够接近的理论,或构建**局部理论**(local theories:够用即可,只要不层层堆叠)②**日志可见**:agent 日志充满显式理论构建(假设→验证/证伪→调整→重复);作者调试时与 agent 赛跑,**有时它们赢**——"不信能无理论调试百万行代码库"③开放问题:普通应用(CRUD/代理,训练数据充分)表现好,真怪异的东西可能挣扎(Taelin 推文轶事)
- **保留 > 构建(关键区分)**:agent 的**大问题 = 无法保留理论,每次从零构建**——文档只能部分帮助(Naur"严格不可能"完整捕获);agent 永久处于"每次 spin up 从零构建"的不幸位置 → "agent 这么有效是小奇迹";**下一个大创新 = 长期理论保留**:权重内化(continuous learning:把代码库知识编码进权重,几天/周构建理论而非几分钟)或超长上下文(数周改动同一 run)——连接 [[long-running-agents]]/[[file-as-memory]] 的跨会话记忆问题
- 脚注 2:全委托工程师 = 薄包装("是改进但职业前景不好",呼应 [[2026-05-09-ai-makes-weak-engineers-less-harmful|weak-engineers-less-harmful]]);脚注 3:理论是否"真实"是形而上问题,实践上"看得见它测试假设、答对系统问题"就够了

**时间性理论**(Joel Adejola 推文,Goedecke 转述):理论可能本质是**时间性**的——能答"为什么此时建 X""Y 何时加入";连接 [[intent-debt]](意图的时间维度)

**经验证据:战争迷雾**(来源: [[2025-12-24-nobody-knows-how-software-products-work]]):大系统基本问题常只有少数人能答,有时**零人**——回答 = 研究;结构性原因:[[wicked-features|wicked features]] 影响每个其他功能,系统复杂到禁止理解;代码库 = 唯一可靠答案源("能回答问题"是工程团队核心职能,是工程师机构权力的结构性原因);reorg 摧毁默会知识 → 回答退化为调查(交互产品/读码/"探索性手术"——改代码或强制检查恒真,独立于写码的稀缺技能);答案不持久(每次变更引入新细节与例外,同一问题反复研究);很多行为**没有自觉意图**、从"默认选择"的相互作用中涌现——文档写作者"第一次发现系统如何工作"

**文化层**(来源: [[2025-06-22-pure-and-impure-engineering]]):全理解是 pure 文化理想(小系统、低流动可行),部分理解是 impure 文化常态(大系统、高流动);pure 在线上过度代表;AI 对两种文化帮助不对称(impure ~30% 提速 vs pure 几乎无)——见 [[pure-impure-engineering]]

**一致性:理论的供给侧条件**(来源: [[2025-01-02-large-established-codebases]],纯前 AI 操作篇):一致代码库 = 理论可构建/可维护——prior art = 可复用的既有理论片段("既有功能 = 穿过雷区的安全路径",雷区 = [[2025-12-24-nobody-knows-how-software-products-work|战争迷雾]] 中的未知地雷);不一致 = 每个端点一个局部变体,理论碎片化,且"最难 5% 端点被留出范围"→ 部分理论干脆无法成立(负反馈循环);"不先理解就无法拆解" ↔ in-defense 切块重写**机制闭合**(理解先行是拆解前提,成功拆解者 = 已能流畅内部交付的团队);删除代码(先 instrument 驱动调用者到零)= 理论修改的安全手术;AI 时代接口:LLM 默认生成"最合理方式"而非 prior art——一致性维护成为代理时代新问题(见 [[codebase-consistency]])

**外部话语:craft 辩护与稻草人**(来源: [[2026-08-08-code-was-never-the-hard-part]],[[senko-rasic|Senko]],2026-08-08):把理论派画成"程序即证明、FTP 一个 PHP 文件是原罪"的漫画后批判其脱离客户——但 Goedecke 已主动反对激进 Naur 论(部分理论是常态、impure 文化合理),此反驳打的是极端派稻草人;两者在"理解系统 + 理解为什么"并存上其实一致(¿Por qué no los dos?);漫画本身 = "程序即证明"说教在实践者中的舆论形象(与 [[pure-impure-engineering]] 的 pure 说教面相呼应)

## 与其他页面的关系

- [[comprehension-debt]]:理论构建受损 = 理解力债务的认知侧;Goedecke 对冲:部分理解是常态,债务要标定(见该页)
- [[cognitive-surrender]]:不构建理论 = 投降;部分理论 + 承诺猜测 = 第三路径
- [[distillation-anxiety]]:"理论可否从代码重建"之争 = 知识导出恐惧的学术底牌(可重建的 vs 随人消失的)
- [[intent-debt]]:temporal theory = 意图的时间维度;决策日志记 what/why 也记 why-then
