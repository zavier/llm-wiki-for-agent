---
type: source
tags: [ai-agents, discourse, craft, career, llm-opinion]
topic: ai-agents
created: 2026-08-09
updated: 2026-08-09
status: active
---

# "Code was never the hard part" is an insult to all programmers (2026-08-08)

- 原文: `raw/Code was never the hard part_ is an insult to all programmers.md`
- 类型: 个人博客文章([[senko-rasic]]);本 wiki **第五十篇源文档**
- 出处核实: 发布 **2026-08-08**(raw frontmatter);URL https://blog.senko.net/code-was-never-the-hard-part-is-an-insult-to-all-programmers;作者 About 页核实身份(克罗地亚 Zagreb,~25 年软件开发者)
- 定位: AI 时代职业话语层的 **craft 辩护**——直接回应"code was never the hard part / coding is easy"话语;与 [[2026-03-06-will-my-job-still-exist|Goedecke 职业文]] 同构(what changes / what doesn't / how to thrive)但问题不同:Goedecke 问"行业是否收缩",Senko 答"技艺从未容易且仍相关"

## 摘要

反驳两条流行话语:①"编码从来不是难点/编码很容易"——是对所有程序员的侮辱;②"搞清楚要建什么才是难点"的单边论——若只此一项难,PM 应拿更高薪、过更严面试。正面立场:两者都难都重要(¿Por qué no los dos?)——对系统的深度理解 + 对为什么建它的深度理解。"编码容易"与"代码是艺术、不可自动化"是同一枚硬币的两面,都是 cope。

## 关键主张

- **编码难的经济学论证**:高需求高薪(甚至在 ZIRP 前)、stress/overwork/burnout、10x ninja 与 leetcode 面试、Clean Code/Pragmatic Programmer/TAOCP/SICP 等"门挡"、bootcamp 与大学学位、Carmack/Bellard 被当天才、代码被抄会愤怒、身份被剥夺感、软件如此 buggy——若编码容易,这些全不成立
- **"搞清楚做什么才难"的还原**:若它真更难,为什么 PM 没有严格 10 步面试、挣得没开发者多?为什么市场研究员/可用性专家/customer success 不是 rockstar、BA 被视为 pencil pushers?为什么 sales 许诺新功能时程序员会生气(他们发现了真需求)?为什么没人做十个变体试错看哪个成?
- **"没有中位数程序员"**:大多数程序员并不想跟 stakeholder 聊(例外:自由职业者与创始人,尤其软件作坊主);"我解决客户问题"转身 opine monads/内存安全/DRY,客户理解 = 编造的用户画像("affordance"= 周末零花钱)——讽刺两端的自我矛盾;承认有人既在乎技艺又在乎客户,但揶揄"可能需要看分裂人格障碍"
- **正面立场**:两者都重要;断言任意一端("code is easy"或"code is art 不可自动化")都是把头埋进沙子——**是 cope,而你要 thrive**;但也不等于"跳上 LLM 班车"或"AI 代码是偷来的垃圾,誓死抵抗"
- **不变的东西**:软件复杂度只增;维护/bit-rot/熵是事实;抽象之塔(摩天楼?)越来越高;用户想要更多付更少、仍说不清需求甚至不知自己要什么;客户(付钱)与用户(使用)的脱节、业务与客户需求的张力永在;蛇油贩子永不缺("还在等 VR 文艺复兴")
- **变的东西**:程序员一直在颠覆自己的行业——打孔卡 → 汇编/COBOL → C/C++ 内存战斗(Valgrind、PHP4 的 `mysql_real_escape_string()`,作者亲历)→ Rust/Go/Python/JS;dBase/Clipper/HyperCard/Access 时代的角落系统至今在店铺/咖啡馆/发黄的 midi-tower 里跑("backups?什么 backups?")
- **如何 thrive**:接受变化,等量好奇+批判;分辨 hype 与真有效(以及有效到什么程度);回看一年/五年评估变化速度(技术/经济/社会);投资相邻领域——资深:UX/客户访谈/本域商业策略;初级:指针/递归/内存层级/网络协议/HTTP/leetcode/算法,"别怕问 why 和 how exactly"
- **一条底线**:不要把理解、判断、共情、品味外包给 AI;不要 abdicate responsibility(链同站 your-code-is-your-responsibility-even-if-ai-wrote-it);不要当 **meat proxy**(链 gruhn.me 2026-08-03)

## 与现有 wiki 的关系

- 新实体: [[senko-rasic]]——独立开发者视角的 craft 辩护者,与 [[sean-goedecke]](大厂 staff)、[[mario-zechner]](极简 harness 作者)并列的第三种作者背景
- **话语对照**:
  - "程序即证明、FTP 一个 PHP 文件是原罪"的漫画 ↔ [[theory-building]]——Senko 把极端 pure 理论派当稻草人;Goedecke 本人已反对激进 Naur 论(部分理论是常态、impure 是合理文化),craft 辩护与其理论构建立场相容;"两者都要" = 对 pure/impure 之争的非 Goedecke 第三立场(见 [[pure-impure-engineering]])
  - "code is easy"论者 ↔ Goedecke 薄包装/托底观察([[2026-05-09-ai-makes-weak-engineers-less-harmful]])——同一现象两种评价:Senko 视为侮辱,Goedecke 视为地板抬高;调和:**"难度"是相对专长水平的**(对从未形成技艺的净负工程师编码确实变易,对有技艺者是侮辱)
  - "don't outsource understanding/judgement/empathy/taste" ↔ [[cognitive-surrender]]——meat proxy = 投降的职业形态(输出=你的输出且无可检查);责任观(自己署名就要负责) ↔ [[pr-contract]] 的作者义务/[[agentic-engineering]]"人拥有正确性"
  - thrive 建议 ↔ [[expertise-leverage]]:初级深基础 = 专长养成侧;资深扩展相邻域 = 专长杠杆跨界复用
  - "AI 代码是偷来的垃圾,誓死抵抗"的 cope 端 ↔ [[distillation-anxiety]] 的对抗性反应(弱相关)
- **互证**:what changes/what doesn't/how to thrive 结构 ↔ [[2026-03-06-will-my-job-still-exist]](同构;需求收缩 vs 技艺仍相关 = 不同问题维度,不冲突);"软件总是 buggy" ↔ 评审经济学"写便宜了,理解没便宜"([[2026-06-15-agentic-code-review]])与 [[comprehension-debt]] 维护侧;snake oil 永在 ↔ 对代理/基准 hype 的批判视角
- **分歧记录**:无事实矛盾;仅话语层张力(侮辱 vs 托底、理论派稻草人),均已标注
- 相关文(同站):[[2025-09-15-your-code-is-your-responsibility|your code is your responsibility even if AI wrote it]]——责任观姊妹篇/前身(2025-09-15,已收录第 51 源;2026-08 文引用其为底线);[[2026-08-03-dont-be-a-meat-proxy|gruhn 的 meat proxy]](2026-08-03,已收录第 52 源)——术语出处一手化,见 [[meat-proxy]]

## 待办 / 后续

- 开放问题:见主题页——"编码难度"话语的实证化(托底 vs 侮辱的判据);buggy-ness 常识论证与评审经济学之间的机制缺口
- HN/lobste.rs 讨论样本(可选)
