---
type: source
tags: [agent-evals, hiring, benchmarking, long-running-agents]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# Designing AI-resistant technical evaluations (2026-01-21)

- 原文: `raw/Designing AI-resistant technical evaluations.md`
- 类型: Anthropic 工程博客(作者 Tristan Hume,performance optimization team lead;anthropic.com/engineering/AI-resistant-technical-evaluations)

## 摘要

Anthropic 性能优化团队用一道"为模拟加速器优化代码"的 take-home 招聘,over 1,000 名候选人做过,但每个新 Claude 模型都迫使重设计:Opus 4 超越多数人类申请者、Opus 4.5 追平最强申请者。作者复盘三次迭代——原版、基于 Opus 4 失败点重做的 version 2、被 Opus 4.5 逐条击破后的两次尝试(换优化问题失败、改用 Zachtronics 风格极小指令集谜题成功)——并开放原版为无限时间挑战,附各模型/harness 的 cycle 数。

## 关键主张

- **问题**: 随着 AI 能力提升,今天能区分人类技能水平的技术 take-home 明天可能被模型轻松解掉而失效
- **背景**: 自 early 2024,performance engineering 团队用一道"为模拟加速器优化代码"的 take-home;**over 1,000 candidates** 完成过,数十人现已在此工作,包括搭建 Trainium cluster、参与 Claude 3 Opus 以来每个模型发布的工程师
- **模型逐版击败**: 同一时间限制下,**Claude Opus 4 超越大多数人类申请者**;**Claude Opus 4.5 追平最强申请者**;给无限时间人类仍能超过模型,但在 take-home 约束下团队已无法区分最强候选人与最强模型的产出
- **设计目标**: 4 小时窗口(后改为 2 小时)、真实环境(无人旁观/无旁白/自己的编辑器)、留出理解系统与造调试工具的时间、**兼容 AI 辅助**(Anthropic 一般候选人指引要求不用 AI,但该 take-home 明确指示相反——因为长时任务更难被 AI 完整解掉,候选人可像工作中一样用 AI,同时仍需展示自己的技能);通用原则:代表真实工作、高信号(避免单点洞见、留足够深度让强者也做不完)、不要求特定领域知识、有趣(快速迭代循环)
- **模拟机器**: 用 Python 模拟一个特性像 TPU 的假加速器,候选人优化其上的代码,配合热重载的 **Perfetto** trace 显示每条指令;机器特性包括手动管理的 scratchpad memory、VLIW(每周期多个执行单元并行,需高效指令打包)、SIMD、multicore;任务是并行树遍历,刻意不做深度学习味;灵感来自 branchless SIMD decision tree inference;原版还含一个候选人需先调试的 bug 以考察造工具能力
- **早期结果与预测性**: 初始 take-home 效果很好——Twitter 批次里一人得分显著高于其他人,他 2024-02 入职;测试有预测力——他立刻开始优化 kernel,并绕过一个涉及张量索引数学 32 位溢出的启动阻塞编译 bug;**约 1,000 名候选人**在一年半里完成,团队多数成员由此招入;对履历经验有限的人尤其有价值(数名最强工程师直接来自本科)
- **2023 live interview 已被击败**: Claude 3 Opus 打败第一部分;Claude 3.5 Sonnet 打败第二部分;该题仍在用,因为其他 live 题也不抗 AI
- **Opus 4 击败原版**: 到 2025-05,Claude 3.7 Sonnet 已到"**超过 50% 的候选人不如直接委托给 Claude Code**"的程度;随后测 pre-release Opus 4,它在 4 小时限制内给出比几乎所有人类都更优的解
- **version 2 的应对**: 用 Claude Opus 4 找出它开始吃力的地方,把那里作为新起点;写更干净的起始代码、加新机器特性增加深度、移除 multicore(Claude 已解掉且拖慢迭代);时间限制从 4 小时缩到 2 小时(排期开销曾造成数周延迟);version 2 强调巧妙的优化洞见而非调试与代码量,管用了几个月
- **Opus 4.5 击败 version 2**: 看 Claude Code 在 pre-release Opus 4.5 checkpoint 上做了 2 小时——解掉初始瓶颈、实现所有常见微优化、**不到一小时就达到通过阈值**,然后停下、认定撞上不可逾越的内存带宽瓶颈(多数人类也这么认为);但存在利用问题结构绕过瓶颈的巧妙技巧;当被告知可达的 cycle count 后它想了会儿找到技巧,再调试、调优、继续优化;**到 2 小时其分数匹配最佳人类表现(而那位人类大量用了 Claude 4 并带 steering)**;内部 test-time compute harness 进一步确认它既能 2 小时胜过人类、也能随时间继续爬升;发布后改进了 harness 还拿到更高分
- **为何不禁止 AI + 工作样貌已变**: 除了执行困难,作者认为既然人仍在工作中扮演关键角色,就应能在**带 AI**的场景里让人脱颖而出,不想接受"人类只在超过数小时的任务上有优势";也担心把门槛抬到"显著超过 Claude Code 单独水平"会让人类因读题/理解慢而永远落后,最优策略变成坐看;如今 performance engineer 的工作更像艰难调试、系统设计、性能分析、验证系统正确性、让 Claude 的代码更简单优雅——这些**难以在客观、短时或缺乏共同语境的情况下测试**
- **Attempt 1(换优化问题)失败**: 基于作者在 Anthropic 做过的棘手 kernel 优化——2D TPU register 上的高效数据转置并避免 bank conflicts;Claude 不到一天实现改动;**Opus 4.5 找到作者自己都没想到的优化**——通过仔细分析发现可以转置整个计算而非想办法转置数据,并重写整个程序;作者打补丁移除该路径后 Claude 仍能推进但找不到最高效解;用 Claude Code 的 "ultrathink" 加长思考预算再验,**它解出来了,还知道修 bank conflicts 的技巧**;事后看不该选此题——许多平台的工程师都头疼数据转置与 bank conflicts,Claude 有大量训练数据可依
- **Attempt 2(更怪)成功**: 需要 human reasoning 能胜过 Claude 更大经验库的、足够 out-of-distribution 的问题,但这与"像工作"冲突;想到 Zachtronics 编程解谜游戏(如 Shenzhen I/O,程序分在多块通信芯片上、每块约 10 条指令、一两个状态寄存器,巧解常靠把状态编码进 instruction pointer 或 branch flags);设计了一套用极小、强约束指令集、以最小指令数为目标的解谜 take-home,实现了一道 medium-hard;测 Opus 4.5——**它失败了**;补齐更多谜题,让同事验证比作者更不了解该问题的人仍能超过 Claude;刻意不提供可视化/调试工具(造工具是考察内容);低方差(由更多独立子问题组成)、早期结果有希望:分数与候选人过往工作水平相关性好,作者一位最强的同事得分高于迄今任何候选人;代价是放弃了原版的真实性与多样深度——"原版因像真实工作而有效,替代版因模拟新工作而有效"
- **开放挑战与 cycle 数**: 把原版 take-home 以无限时间开放;人类专家在足够长时间地平线上仍有优势;史上最快人类解显著超过 Claude 即便用大量 test-time compute 的成绩;发布版从零开始(像 v1)但用 v2 的指令集与单核设计,cycle 数可与 v2 比较;测得的 clock cycles:**2164** = Opus 4 在 test-time compute harness 里许多小时;**1790** = Opus 4.5 一次随意 Claude Code 会话、约等于最佳人类在 2 小时的成绩;**1579** = Opus 4.5 在 test-time compute harness 里 2 小时;**1548** = Sonnet 4.5 用远超 2 小时的 test-time compute;**1487** = Opus 4.5 在 harness 里 11.5 小时;**1363** = Opus 4.5 在改进后的 test-time compute harness 里许多小时;低于 1487 cycles(即超过发布时 Claude 最好成绩)可发邮件附代码与简历

## 与现有 wiki 的关系

- 更新 [[agent-evals]]:AI-resistant eval 设计是该概念页的对抗性/招聘侧维度
- [[long-running-agents]]:take-home 的优势在更长时地平线;援引 METR 时间地平线([[2025-03-19-measuring-ai-long-tasks]])
- [[harness-engineering]]:test-time compute harness 是一等应用——同一模型换 harness 就把 1579 推到 1363 cycles
- [[minimal-vs-rich-harness]]:Claude 在 harness 里随时间爬升,harness 改进直接抬高分数
- [[tool-evaluation]]:造调试工具/自建工具是考察信号,与工具评测循环呼应
- [[claude-code]]、[[anthropic]]:Opus 4 / 4.5、Sonnet 4.5 的代际对比与官方招聘实践

## 待办 / 后续

- 原文自认:作者"好奇(新版)能撑多久";realism 可能已是奢侈,替代版牺牲真实感
- Attempt 1 的教训:训练数据丰富的经典优化问题不抗 AI
- 开放挑战 GitHub 仓库(anthropics/original_performance_takehome)可持续跟踪人类/模型成绩
