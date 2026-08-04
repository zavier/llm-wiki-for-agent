---
type: entity
tags: [people, engineering-culture]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-04
refs: [theory-building, comprehension-debt, cognitive-surrender, distillation-anxiety, pure-impure-engineering, wicked-features, expertise-leverage, codebase-consistency]
sources: [2026-07-11-in-defense-of-not-understanding-your-codebase, 2026-07-24-llms-reward-expertise, 2026-05-09-ai-makes-weak-engineers-less-harmful, 2026-04-03-programming-with-ai-agents-as-theory-building, 2026-03-06-will-my-job-still-exist, 2025-06-22-pure-and-impure-engineering, 2025-02-10-engineers-who-wont-commit, 2025-12-24-nobody-knows-how-software-products-work, 2025-04-12-wicked-features, 2025-01-02-large-established-codebases]
status: active
---

# Sean Goedecke

GitHub Staff Software Engineer(Copilot 团队;此前 Zendesk),澳大利亚人,数学本科 + 道德哲学硕士,无传统 CS 背景;博客 seangoedecke.com 作者,大公司软件工程与 AI 采纳的务实评论者(HN 热门博主;2025 年 141 篇、月百万读者——播客简介二手,待核)。

## 关键信息

- **pure vs impure 工程文化**(一手化,来源: [[2025-06-22-pure-and-impure-engineering]]):小代码库/低流动(pure,完全理解)vs 大代码库/高流动(impure,局部理解)是两种不同的编程方式、实践与文化;pure 在线上讨论过度代表——"行业里反复出现的争论,很多是 pure 全理解文化撞上 impure 部分理解文化";**AI 对 impure 工程帮助最大**(~30% 自报,与类型系统/调试器同级;pure 工程师在自己专精领域几乎总是胜过 LLM)
- **为部分理解辩护**(来源: [[2026-07-11-in-defense-of-not-understanding-your-codebase]]):大系统里人人持部分错误理论;驳 Naur 的废弃重建论;理论维护只是众多权衡之一;LLM 双刃剑(自认未定论)
- **take a position**(来源: [[2025-02-10-engineers-who-wont-commit]]):房间内最有上下文/技能/权力者必须表态,哪怕 55-60% 信心;不表态=默许最终决定("工程师们不愿表态"原题)
- **Nobody knows**(来源: [[2025-12-24-nobody-knows-how-software-products-work]]):大公司对自己系统的"战争迷雾";代码库=唯一可靠答案源;"能回答软件问题"是工程团队核心职能
- **wicked features**(来源: [[2025-04-12-wicked-features]]):影响每个其他功能的需求——大系统"禁止理解"与"不可重建"的机制;公司老兵的价值 = 熟悉全部 wicked features
- **LLMs reward expertise**(来源: [[2026-07-24-llms-reward-expertise]]):领域专长 = 最重要的提示技能——同模型,懂行的人把 LLM 推得更狠("不,可以更简单""我们不是已经做了 X 吗");Tao×ChatGPT 案例(mode shunting/推回式纠错/自导下一步);**人=瓶颈而非模型**(信息已在模型里,要懂行的人拉出来);专长随模型变强继续有用;与 RCT 六模式互证(高分 Generation-Then-Comprehension 86% = 专长驱动使用,见 [[expertise-leverage]])
- **AI makes weak engineers less harmful**(来源: [[2026-05-09-ai-makes-weak-engineers-less-harmful]]):工程能力重尾分布,弱工程师传统净负;前沿 LLM **抬高弱工程师地板**(最差 PR 从"绝不可能工作"变"标准 LLM PR");薄包装现象自我选择地限于净负者(强工程师基线品味抓 AI 错误);三输:本人学更少/公司付人类薪水得 Copilot 订阅/"工程师给 AI 加什么价值"追问→失业风险;脚注自疑:LLM 输出持续优于自己可能是好的学习方式(对 skill atrophy 判断的限定)
- **Programming as theory building**(来源: [[2026-04-03-programming-with-ai-agents-as-theory-building]]):Naur 理论的 AI 化论辩——LLM 让心智模型略欠详细(非灾难)但 80/20/10 漏斗实证(仅 ~10% agent 输出进入产出,拒绝几乎全部 = 理论仍是"我的");LLM 能构建局部理论(日志可见);**agent 无法保留理论、每次从零构建**——"下一个大创新 = 长期理论保留";naur theory 标签下的第二论辩(见 [[theory-building]])
- **Mistakes in large established codebases**(来源: [[2025-01-02-large-established-codebases]]):大代码库(5M 行/100-1000 人/≥10 年)首要原则 = **一致性**(prior art 先行、沉入遗留代码、"抵制让小角落更干净");不一致 = 首要错误(雷区/负反馈循环);90% 价值辩护——大公司收入主要来自大代码库,不先理解就无法拆解;删除代码(先 instrument 驱动调用者到零);纯前 AI 时代的奠基操作篇(见 [[codebase-consistency]])
- **Will my job still exist in ten years**(来源: [[2026-03-06-will-my-job-still-exist]]):2026 不确定软件工程行业能否再活十年——staff 大概**最后被替换**("为什么雇一群工程师当手,而不花零头租 Claude Opus 4.6 实例?");超调/欠调框架(超调 → 资深需求中期上升);反驳 Jevons(AI 维护能力 = 生成能力);**与 llms-reward 的立场张力**:03-06 悲观(需求收缩)vs 07-24 乐观(专长升值)——调和:专长决定相对位置,行业收缩是绝对量
- 博客主题:大公司动态、"good engineers"系列(How good engineers write bad code at big companies、What makes strong engineers strong)、ship 项目、AI;naur theory 标签——Naur 程序理论是持续主题
- 金句:"如果你称职,那个人就是你"——不确定时不能等完美理解的人,做最 educated guess 并承担后果

## 与其他页面的关系

- 主要贡献: [[theory-building]] 反驳侧、[[comprehension-debt]] 对冲视角(部分理解是常态)、[[pure-impure-engineering]] 提出者、[[expertise-leverage]] 提出者(LLM 使用侧)
- 与 [[addy-osmani]]、[[simon-willison]] 同属独立评论者;视角偏大公司工程文化与人因,而非 AI 工具链内部
