---
type: source
tags: [ai-agents, prompting, goedecke, expertise]
topic: ai-agents
created: 2026-08-04
updated: 2026-08-04
status: active
---

# LLMs reward expertise (2026-07-24)

- 原文: `raw/LLMs reward expertise.md`(AI 直抓版 2026-08-04;raw frontmatter 由抓取脚本补全)
- 类型: 个人博客文章([[sean-goedecke]]);本 wiki **第四十四篇源文档**
- 出处核实: 发布 **2026-07-24**(站点页头 "July 24, 2026" 确认);URL https://www.seangoedecke.com/llms-reward-expertise/
- 定位: Goedecke "部分理解"体系的**使用侧**——前五篇讲大系统里的理解是什么、为什么、怎么办;此篇讲"理解(专长)如何决定你从 LLM 榨出的价值";与 [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]] 的"LLM 双刃剑"未定论在此向"专长升值"一侧收敛

## 摘要

LLM 让每个人成为通才(委托式 CSS),但这不意味着提示没有技能——**最重要的提示技能是领域专长**:对你要提示的领域越懂,同一模型能榨出的价值越高。Terence Tao 与 ChatGPT 的数学对话是例证(短准消息/mode shunting/推回式纠错/自导下一步,但技巧不可复制——关键是懂数学本身)。工程侧:对代码库有 theory 就能把 LLM 推得*更狠*。结论:对许多任务**人=瓶颈而非模型**——信息已在模型里,要懂行的人拉出来;人类专长随模型变强继续有用。

## 关键主张

- **核心论点**:LLM 让每个人成为通才(人人能写 sort-of-okay CSS),但"skilled prompters 与新手同结果"是错的——**提示最重要的技能 = 你提示的领域的专长**;LLM 奖励专长,领域知识让你从同一模型榨出更多
- **Tao × ChatGPT 五观察**(Jacobian 猜想反例对话,chatgpt.com/share/6a5fdc7a-d6f8-83e8-bbea-8deb42cfed56):①消息短而准,只回应主旨、不逐点反驳 ②**mode shunting**:信号专长把模型推入"与数学家对话"模式而非"给外行解释"模式(输出明显更简洁——对比作者自己与 GPT-5.6 Sol 的数学对话)③不直接反驳,用"这看起来比我期望的更复杂"式推回 ④自己跳跃/提建议,几乎不采纳模型对下一步的建议 ⑤**但技巧不可复制**:关键是真懂数学——从多段输出中抓相关想法、提替代表述/方法、识别"什么看起来不对劲"
- **理论 = 推模型的杠杆**:对代码库有好的 theory(见 [[theory-building]])就能把 LLM 推*更狠*——"不,可以更简单""但我们不是已经做了 X 吗""能用熟悉的术语表达这个问题吗";反之只能接受模型的第一版
- **具体细节主导设计**(引 "you can't design software you don't work on"):Tao 问"X 在这里有效吗""给定 Y 和 Z,为什么 A"——这类问题他只能对数学问,作者只能对 GitHub 的系统问;宁可要代码库熟悉度,不要软件系统的通识深度
- **无专长 ≠ 坏**:没领域知识时抱 LLM 至少得到 *something*(引 "ai makes weak engineers less harmful"),"这不坏";有专长则同模型价值倍增;**大多数人混合两种模式**(一些领域有专长,另一些没有)
- **人=瓶颈**:许多任务上困难部分 = 向模型精确传达"想要什么样的解决方案";信息"已在模型里",但需要很懂行的人才能拉出来 → 人类专长即使模型变强仍有用

## 与现有 wiki 的关系

- 新建概念页 [[expertise-leverage]];更新 [[theory-building]](应用延伸:理论=LLM 使用杠杆)、[[cognitive-surrender]](镜像:steering 而非 surrender)、[[sean-goedecke]]、[[ai-feature-implementation-loop]](理解力层)
- 互证:与 [[2026-01-28-skill-formation-rct|RCT 六模式]] 闭合——高分模式(Generation-Then-Comprehension 86%)正是专长驱动的"生成后理解+纠偏"用法,低分模式(AI Delegation 39%)是零专长纯委托;与 [[cognitive-surrender]] 互为镜像(同模型同输出,区别在用户是否带理论进场);"传达想要什么=瓶颈" ↔ [[intent-debt]] 的"意图外部化是唯一必须源于人的输入";与 [[pure-impure-engineering]] 的"AI 帮助 impure 最多"同族(回报 = 代码库熟悉度)
- 文内引用两篇未摄入:ai-makes-weak-engineers-less-harmful、you-cant-design-software-you-dont-work-on;同标签相关文 Powerful AIs might escape containment(开权重逃逸/boxing problem)——潜在新源

## 待办 / 后续

- 发布日已核(2026-07-24);作者自谦"Tao 比我更擅长编程"不构成论点,不展开
- 开放问题:专长×提示行为的受控实验、mode shunting 的机制验证(见主题页与 [[expertise-leverage]])
- 潜在新源:ai-makes-weak-engineers-less-harmful(与"无专长不坏"直接相关)、you-cant-design-software-you-dont-work-on(具体细节主导设计的原始论证)、powerful-ais-might-escape-by-releasing-open-weight-models(AI 安全向,与当前主题弱相关)
