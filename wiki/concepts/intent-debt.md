---
type: concept
tags: [ai-agents, debt, intent, externalization, failure-mode]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-03
refs: [comprehension-debt, cognitive-surrender, agents-md, ai-agent-spec, factory-model, distillation-anxiety, addy-osmani, agent-readability, loop-engineering, ralph-loop, pr-contract, plan-mode, orchestration-tax, theory-building]
sources: [2026-06-05-intent-debt, 2026-06-15-agentic-code-review, 2026-05-24-orchestration-tax, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2025-12-24-nobody-knows-how-software-products-work]
status: active
---

# Intent debt

意图债:外部化的 rationale/目标/约束(系统为什么是现在这样)的缺失或侵蚀;债务三元组(技术债/认知债/意图债,Storey 的 Triple Debt Model)中**唯一 AI 无法代付**的一角——*why* 是模型唯一只能捏造的东西。

## 关键信息

**债务三元组**(一手论文: [[2026-03-23-triple-debt-model]],Storey,arXiv 2603.22106,v4;此前 Osmani 转述与 [[2026-02-09-cognitive-debt|博客版]] 现全部一手化)

| 债务 | 住在哪 | 性质 | AI 能代付吗 |
|---|---|---|---|
| 技术债 | 代码层 | 实现取舍牺牲未来可改性;最易管理(可见+成熟实践) | ✅ 自动重构/异味识别/测试生成日益贡献 |
| 认知债(团队级) | 人(分布式心智) | **共享理解随时间的侵蚀**——团队级/项目级属性,不是个人现象;使系统难理解 | ⚠️ 部分:可总结/按需重建,但"使隐式知识显式的实践"不可外包,且 AI 可能加速累积 |
| 意图债 | 工件(非代码) | 外部化 rationale/目标/约束缺失或侵蚀;关键词"外部化";
**意图最好在决策时刻捕获,事后恢复困难甚至不可能** | ❌ **不能**(AI 可帮捕获,不能代付——意图是唯一必须来自人的输入) |

- 三者**独立**:低技术债 + 高意图债完全可能;你完全理解系统(对你无认知债)而意图只在你脑子里(对所有人是巨额意图债);"从内部看它们感觉相似,但各自分别向你收费"
- **认知债 ≠ comprehension debt**(论文明确区分,修正):认知债 = 团队共享理解侵蚀(团队级纵向,Starr & Storey 2026);comprehension debt = **个人**"AI 产出与真实理解的差距"(Alakmeh et al. 2026,AIRELI 分类)——个人差距堆积成团队侵蚀,但测量单位不同(见 [[comprehension-debt]])
- **因果循环**:意图债→认知债(目的不清→无法建准确心智模型);认知债→技术债(不理解→糟糕实现决策);技术债→认知债(乱代码难推理)——三者相互强化,也可相互缓解
- **AI 是风险倍增器**:若人类投降认知且不主动捕获意图——AI 减少技术债的同时加速认知/意图债累积;反馈循环断裂是机制(Tornhill:AI 处理方案构建时,问题模型-系统模型循环被切断)

**为什么代理帮不上**:模型能推断"看似合理的理由",但**对意图的猜测不是意图**——300ms debounce 是刻意 UX 决策、基准结果、还是随手输入的数,模型不知道,还会编出听起来自信的理由(比承认不知道更糟);意图是唯一必须来自人的输入

**意图优先工作流 + 意图工件**(一手: [[2026-03-23-triple-debt-model]]):可执行意图(BDD spec——失败时显示系统偏离意图)/决策与理由记录(ADR,Nygard;DDD ubiquitous language)/情境工件(skills/agent 指令/playbook;会议意图捕获[Ulloa et al. 2026]);"intent debt" 的常见症状 = practitioners 所称 "context debt"(代理缺信息);意图捕获工具复兴 = McLuhan "retrieval"(新技术复活旧实践)

**意图债诊断**:行为漂移(测试或客户事故才发现)/AI 代理挣扎(要求大量澄清/技术上正确但错失重点/token 超支)/已阐述约束丢失(NFR 只少数人知道)

**冷启动经济学**:人的意图靠走廊对话/评审评论/事故记忆逐人传递(四年的老工程师 = "意图文档",昂贵但有损);**代理每次会话冷启动**,不带任何隐性意图——"给团队加代理 = 一夜之间团队规模翻倍,全是没有长期记忆的初级员工";未外部化意图从"偶尔付一次(入职/离职)"变成"**每个会话付一次 × 每个代理**";orchestration tax 很大部分就是意图税(管理多代理累 = 在补供从未写下的意图,出处: [[2026-05-24-orchestration-tax]]);Storey 认知债博客(2026-02-09)已一手核实(债务框架旁证 ✓,见 [[2026-02-09-cognitive-debt]])

**先 AI 形态**(来源: [[2025-12-24-nobody-knows-how-software-products-work]]):很多系统行为**没有自觉意图**——从一系列"默认选择"的相互作用中涌现,文档写作者常常"第一次发现系统如何工作";意图债不全是 AI 时代的新债,AI 把既有的"未外部化意图"成本从偶尔(入职/离职/文档危机)变成**每个会话 × 每个代理**(呼应冷启动经济学)

**高意图债的形态**(不是摩擦,是无助感):代理"修 bug"删掉承重 guard clause 无人能辨;重构改掉用户依赖的行为,测试全绿但只编码了旧行为、从未编码意图;问"两个服务为什么走队列不走直连"答"代理建议的,当时看着没问题"——已经开始计息的意图债

**与投降的关系**:投降是个体当下的姿态(见 [[cognitive-surrender]]);意图债是几百次那样的时刻留在仓库里的沉淀——"团队规模、被写下来的投降";金句:"**代码是答案,意图是它本该解决的问题。AI 极其擅长产出你忘了写下来的问题的答案。**"

**偿付:把意图外部化成一等工件**("近几个月我写的所有东西到头来都是意图债管理")

1. **spec 写意图而非实现**:目标/约束/不可妥协项/显式 done(快、可访问、安全、愉悦,超越"功能正确")——spec 承载代码自己承载不了的意图(见 [[ai-agent-spec]])
2. **AGENTS.md = 意图账本不是配置**:反对 /init 自动生成——自动生成的文件描述代码是什么;意图文件描述团队想什么("我们不这么干因为"、任何单文件看不见的约束)(见 [[agents-md]])
3. **决策当场记录(ADR/决策日志)**:决定时记 why 几乎不花钱,八个月后人已转组时重建贵得要命;代理让记录比以往更便宜,"旧借口没了"
4. **学习循环写回意图**:自改进代理的 learnings 文件 = 反向运行的意图泵——每条"我们试了 X 没用因为 Y"都是本会死于记忆的意图

## 与其他页面的关系

- 债务谱系: [[comprehension-debt]](认知债,互补论证:"无法捕捉全部意图不是捕捉零的许可证"——承重 why 必须记)、[[cognitive-surrender]](个体姿态 → 团队沉淀)
- 偿付机制: [[ai-agent-spec]]、[[agents-md]]、[[agent-readability]](意图放代理能读的地方 = 可读性的一部分)
- **决策日志 = 意图外部化的评审形态**(来源: [[2026-06-15-agentic-code-review]]):agent 推理在 diff 产生时被丢弃 → 评审者被迫重构从未写下的意图(441% 更久);修复:代理在 PR 上写决策日志(想做什么/排除了什么/为什么)——意图在便宜时(生成时)捕获,而非昂贵时(评审时)重建(见 [[pr-contract]]);Kun Chen 极端版:意图 upfront 写进 plan(计划质量决定代理无人值守时长)——"意图没消失,人提前写好了"(见 [[plan-mode]])
- 组织侧: [[distillation-anxiety]](知识必须显性化的恐惧面)、[[factory-model]](spec 杠杆 + 假设复合);倡导者: [[addy-osmani]]
- **时间性意图**(来源: [[2026-07-11-in-defense-of-not-understanding-your-codebase]]):"理论是时间性的"——理解 = 能答"为什么此时建 X""Y 何时加入";意图债的**时间维度**:rationale 不只含 what/why,还含 why-then(决策时的语境与先后);决策日志/ADR 若只记"为什么"不记"为什么是现在",意图仍会随时间丢失(见 [[theory-building]])
