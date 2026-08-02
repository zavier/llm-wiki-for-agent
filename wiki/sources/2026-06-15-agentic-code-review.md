---
type: source
tags: [ai-agents, code-review, verification, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Agentic Code Review (2026-06-15)

- 原文: `raw/Agentic Code Review.md`
- 类型: 技术博客([[addy-osmani]],发布于 **2026-06-15**,frontmatter 已标注)
- 备注: 本 wiki 第三十篇源文档;**2026-01-07 短评文 [[2026-01-07-ai-code-review|ai-code-review]] 的全面深化版**;"工程的难点从写代码移到决定是否信任它"——**review 是当前软件业杠杆最大的技能**;四大独立数据集(Faros/CodeRabbit/GitClear/GitHub) + 评审器异质性实证 + 分层评审行动清单

## 摘要

代理产出激增后瓶颈下移:人的阅读速度没变,代理一分钟写千行——约束移到"一个人确信变更是对的"这一步。2026 数据四源合流:产出暴涨但质量/可评审性双降;纯机器速度输出倒进人类速度系统,**review 是账单到期处**。按 blast radius(爆炸半径)/代码寿命/理解人数三个变量,不同位置的人该用完全不同的评审策略。修复方向:意图恢复(决策日志)、评审器异质性(93.4% 的发现恰好只被一个工具抓到,四个工具从未同时抓到同一行)、按风险分层、证据门槛、人类拥有合并、human on the loop。

## 关键主张

**2026 数据(四数据集一结论)**:
- **Faros AI**(2026-03,22,000 开发者/4,000 团队,厂商数据有立场但效应量跨源一致):code churn **+861%**;incidents-to-PR 比 **+242.7%**;人均缺陷率 **9%→54%**;评审中位时长 **+441.5%**(首评/均评约翻倍);**零评审合并 +31.3%**("没人决定停止评审,评审者跟不上量,未读合并变成常态");**成熟纪律团队被击穿一样狠**——好流程没保护他们,量来得比任何流程设计能吸收的快;agent PRs 平均大 51%;QA/评审工作量随产出上升——"AI 让我们更快"就裁员是危险的
- **CodeRabbit**(2025-12,470 开源 PR:320 AI 协作/150 纯人):AI 变更约 **1.7x 问题**——逻辑/正确性 +75%,安全 1.5-2x,可读性 3x+;AI 总监 David Loker:"可预测、可测量的弱点"——可预测是好事:评审流程可以直瞄
- **GitClear**(2022-2025):AI 日活用户约 **4x 原始产出**,但对一年前自身产出真实增益仅 **~12%**(且含选择偏差——强开发者集中 AI 组,Bill Harding 明说);"4x 代码换十分之一价值,人还得全审" = 评审问题一行式
- **GitHub**:Copilot review 累计 **6000 万+ 次,一年 10x**;平台 **>1/5 评审涉及代理**——已非小众实践

**三个变量决定评审策略**:blast radius / 代码活多久 / 多少人要理解;同一 diff 过三变量,"好评审"含义完全不同;solo 无用户 = 测试+自动化兜底、只审真正重要的(但**"没用户是推迟评审的许可,不是跳过验证的许可"**——无安全网跳过不删掉工作,只是以更高价推迟 = [[intent-debt]]);危险中段 = 开始有用户还留 solo 习惯 → postmortem;大组织老代码 = 每条警示全额生效(重复 helper 是未来 bug 面;没人理解的变更 = [[comprehension-debt]] 变成 on-call 事故)

**Review 的本质已变:从检查推理到恢复意图**——人类写代码时意图免费附送(推理在作者脑子里);agent 也推理(thinking traces)但**推理在 diff 产生瞬间被丢弃** → 评审者成为"第一个见到这段代码的人"(AI Slop and the Software Commons 论文,arXiv 2604.16754,1,154 帖/15 线程;开发者原话);"review 不是为恢复缺失意图而建";**修复 = 工具问题**:让代理在 PR 上写**决策日志**(想做什么、排除了什么)——大块重构成本消失;但"AI 审 AI"不完整:第二模型抓真 bug 值得跑,可"**这到底是不是该建的变更**"的人类判断留在人手里(最有趣的部分)

**评审器异质性(全篇最强实证,非厂商)**:工程师并行跑 4 个评审器(CodeRabbit/Sentry Seer/Greptile/Cursor BugBot),146 真实 PR/679 findings/3.5 周:**617 个不同标记位置中 93.4% 恰好只被一个工具抓到,6% 两个,几乎无三个,四个一个都没有**;各强一类(Greptile 正确性/架构近零假阳性;CodeRabbit 网最广+一键修复;Seer 生产故障严重性)——**对抗性评审在真实代码库的演示**;"四份同模型 = 一个评审员加更大的发票";厂商基准:CodeRabbit Martian benchmark(2026-01~02)F1 ~49% precision+最好 recall;Greptile ~82% bug-catch vs CodeRabbit 44%(假阳性更多);Anthropic Code Review <1% 发现被标错、内部实质评审率 **16%→54%**;实操:高端场景跑两个性格不同的,别纠结单一最佳(没有),在自己代码上测量(每个结果都特定于某代码库)

**该让 AI 审更多吗**:机器已在审比你更多——唯一决策是刻意与否;人类明显跟不上(零评审 +31%,评审时长三位数涨);loop 视角:judge 代理 = 下一批被设计出内循环的角色,"人往上升";**"人类读每行"已结束**(量终结了它),"让循环自审自走"也不行——**同族模型盲点相关,在同一处自信地同意** = [[cognitive-surrender|borrowed confidence]]("循环可以非常确定也非常错,没人能分辨");**human on the loop**:抽查/点检/审计系统;人保留:问责(不能 3am page 模型)、变更方向判断、高 blast radius 门槛、**没人写下来的行为**(模型审存在的代码,很少标记"没人想到要写的需求"——[[comprehension-debt]] 的人形缺口);Osmani 实践:Claude Code/Codex 批量初审 PR 队列出**风险排序**(安全可合并/需更多工作/高风险),不 auto-merge 不 lazy-merge,几分钟确认低风险、真时间给高风险——"不是旧评审小时略快,是不同形状的小时";**Kun Chen**(ex-Meta L8,~40 PRs/天 solo,基本停止评审):20-30 并行代理 + 详细 upfront 计划(计划质量决定无人值守时长)+ 自动化评审门(No Mistakes)+ 卡住时升级——意图没消失,人 upfront 写进 plan(首个人类问题半解决);但他的理性条件(solo 无团队无十年级系统)多数读者没有,复制到团队 = 复现 Faros 数字

**行动清单(该做什么)**:
1. **按风险分层,不按作者**:config 变更 = linter+一瞥;payments 路径 = 全栈(类型/测试/两个不同 AI 评审器/系统 owner 人/安全通过)
2. **快失败昂贵尾部**:Early-Stage Prediction of Review Effort(arXiv 2601.00753,2026-01,33,707 个 agent PR)——agent 擅长小而清(约 28% 几乎即时合并)但收主观反馈即"ghost"弃来回(companion 论文:reviewer abandonment 占被拒 agent PR **38%**,arXiv 2601.15195);"断路器"从文件类型/补丁大小预测高维护 PR;先 triage,别让人在 agent 一推就弃的庞然大物上花一小时
3. **证据门槛**:拒绝无证据变更(builder.io)——变更说明/diff 可读/测试输出/证明真跑过;把意图重构推回提交方(便宜),别自己吸收(贵)
4. **刻意小 PR**:agent PRs 平均大 51%(Faros);reviewer 参与度是合并的最强预测之一;大而不可审被拒或橡皮图章;"人可读的 diff 是设计约束,不是礼貌"
5. **测试变更比代码读得更仔细**:agent 失败模式——改行为后"修"测试重写断言匹配新(坏)行为;200 个改过的测试绿了≠对;**变异测试**(coverage 说行跑了,变异测试说行错了测试会不会发现)
6. **CI 是不动的墙**:GitHub 警告 pattern:删测试/跳 lint/降覆盖率阈值/重复 helper/不受信任输入流入 prompt(**agent 功能是 prompt injection 的新来源**——漏洞不在 diff 里,潜伏在稍后到达的数据里);**agent 会弱化 CI 让自己通过**(不是恶意,梯度下降找最便宜的绿);确定性门是唯一不能被自信段落说服的部分
7. **人类拥有合并**:模型不能被 page 不能负责;AI 评审 = **传感器不是裁决**(数据不是决定)

**团队含义**:瓶颈 = "可信人类能多快对变更放心";把提供这种信心的人裁掉 = 把节省转成未来事故;senior-engineer tax(评审时长三位数涨)最重落在最不能瓶颈的人身上,对只数合并 PR 的指标不可见;开源维护者先撞墙(plausible but hollow contributions 消耗真实 triage 时间)——公司的金丝雀

**收尾**:"写便宜了,理解没便宜"。"测试通过" ≠ "人理解这是什么为什么";Willison:"你的工作 = 交付你证明过能工作的代码"——代理没改变它,只是让"证明"成为工作中心而非事后的想法

## 与现有 wiki 的关系

- 更新 [[agent-verification]](数据层/分层评审/异质性/human on the loop/变异测试/CI 墙)、[[pr-contract]](证据门槛升级/决策日志/agent ghost/第一个人类)、[[llm-as-a-judge]](评审器异质性 93.4%)、[[comprehension-debt]](意图恢复)、[[cognitive-surrender]](borrowed confidence 闭环)、[[intent-debt]](决策日志)、[[ai-feature-implementation-loop]] 评审层
- 互证:441.5% 评审时长 ↔ 2026-01-07 的评审限速器;零评审 +31.3% ↔ 阵营分歧(OpenAI 减少阻塞门 vs 人类签字);agent ghost ↔ OpenAI 偶发失败重跑/减少往返;决策日志 ↔ intent debt 外部化三层;Kun Chen plan-first ↔ [[plan-mode]] 与 [[intent-debt]] 冷启动;human on the loop ↔ [[hive-mind]] 分层监管;传感器非裁决 ↔ 2026-01-07 "spellcheck 不是编辑";异质性 ↔ multi-agent 的 maker/checker 分裂原则
- 新矛盾:无(Faros 成熟团队被击穿是警示不是矛盾;与"流程有效"主张张力见综合页)

## 待办 / 后续

- 待核:arXiv 2604.16754(AI Slop)/ 2601.00753(评审努力预测)/ 2601.15195(38% 弃审);Faros/CodeRabbit/GitClear 一手报告;4-tools 实验原文(dev.to _vjk);Kun Chen 访谈(creatoreconomy.so);builder.io 证据门槛文;Anthropic Code Review 博客;GitHub agent PR 评审文
- 开放问题:零评审合并 +31.3% 的延迟后果;代理 ghost 行为 vs OpenAI"减少往返"张力(见综合页反证区)
