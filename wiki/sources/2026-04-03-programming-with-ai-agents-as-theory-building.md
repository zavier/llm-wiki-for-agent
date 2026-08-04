---
type: source
tags: [ai-agents, goedecke, naur, theory-building]
topic: ai-agents
created: 2026-08-04
updated: 2026-08-04
status: active
---

# Programming (with AI agents) as theory building (2026-04-03)

- 原文: `raw/Programming (with AI agents) as theory building.md`(AI 直抓版 2026-08-04;raw frontmatter 由抓取脚本补全)
- 类型: 个人博客文章([[sean-goedecke]]);本 wiki **第四十六篇源文档**
- 出处核实: 发布 **2026-04-03**(站点页头 "April 3, 2026" 确认;tags: ai, naur theory);URL https://www.seangoedecke.com/programming-with-ai-agents-as-theory-building/
- 定位: Goedecke "部分理解"体系的**理论基础篇**——[[2026-07-24-llms-reward-expertise|llms-reward-expertise]] 引此文论证"对代码库有理论就能把 LLM 推更狠";与 [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]](驳废弃重建)并列为 Goedecke 对 Naur 的**第二论辩**(回应"LLM 不该用于工程/好结果皆假象"两类批评)

## 摘要

认同 Naur:程序的核心产出是头脑中的**程序理论**,代码只是副产品。回应两类批评——①"LLM 让工程师跳过理论构建":承认但非灾难(所有理论本就略过细节),工作流实证 **80/20/10 漏斗**(仅 ~10% agent 输出进入产出,拒绝几乎全部 = 理论仍是"我的")②"LLM 没有理论,好结果皆假象":可能 pattern-match 或构建**局部理论**,agent 日志可见显式理论构建,"调试时有时 agent 赢过我"。关键区分:**保留理论 > 构建理论**——agent 无法保留、每次从零构建,"下一个大创新" = 长期理论保留(权重内化/超长上下文)。

## 关键主张

- **Naur 立场复述 + 认同**:先改心智模型才能改代码;代码是理论的部分表达(与 [[2026-02-09-cognitive-debt|Storey]] 共享前提,但与废弃重建论分流)
- **承认 + 反驳(批评一)**:LLM 让工程师(甚至尽责者)构建**更不详细**的心智模型——offload 认知努力是有意为之;但所有心智模型本来就略过细节("breadth of your stack":依赖/Linux 抽象/进程/线程/套接字/汇编层)——放弃任何细节 ≠ 灾难;理论不必详细到"告诉你每行代码怎么写"才有用
- **80/20/10 评审漏斗(工作流实证,单一样本自报)**:2-3 并行 agent → 扫描 + snap judgement(是否契合我的系统理论)→ ~80% 不匹配即 kill 或"你没考虑 X" → 20% 仔细评审 + 自己摸代码/手测 → 约一半进 PR;**只有 ~10% agent 输出进入产出**;几乎所有时间花在"这段代码是否契合我的理论"——理论略欠详细但**仍是"我的"理论**(否则会接受大部分而非拒绝几乎全部)
- **LLM 能否构建理论(批评二)**:①能做出有效修改 → 或 pattern-match 训练数据中足够接近的理论,或构建**局部理论**(local theories:够用即可,只要不层层堆叠)②**日志可见**:agent 日志充满显式理论构建(假设→验证/证伪→调整→重复);作者调试时与 agent 赛跑,**有时它们赢**——"不信能无理论调试百万行代码库"③开放问题:任意代码库的工作理论——CRUD/代理等训练数据充分的普通应用表现好,真怪异的东西可能挣扎(Victor Taelin 推文:至少可能)
- **保留 > 构建(关键区分)**:agent 的**大问题 = 无法保留理论,每次从零构建**——文档只能部分帮助(Naur"严格不可能"完整捕获);agent 永久处于"每次 spin up 从零构建"的不幸位置 → "agent 这么有效是小奇迹";**下一个大创新 = 长期理论保留**:改自身权重(continuous learning 梦想:把代码库知识编码进权重,几天/周构建理论而非几分钟)或超长上下文(数周改动同一 agent run)或其他
- **脚注 2**:全委托工程师 = 薄包装——"对这种工程师是改进,但职业前景不好"(呼应 [[2026-05-09-ai-makes-weak-engineers-less-harmful|weak-engineers-less-harmful]]);脚注 3:理论是否"真实"是形而上问题,实践上"看得见它测试假设、答对系统问题"就够了

## 与现有 wiki 的关系

- 更新 [[theory-building]](Goedecke 第二论辩)、[[expertise-leverage]](杠杆机制量化)、[[cognitive-surrender]](拒绝率 = 投降的测量代理)、[[sean-goedecke]]
- 互证:80/20/10 ↔ 评审经济学(Faros churn/Keep Rate 的个人版数字, [[2026-06-15-agentic-code-review]]);局部理论 ↔ 部分错误理论(in-defense);**保留理论 ↔ [[long-running-agents]]/[[file-as-memory]]/[[intent-debt]]**(agent 每次从零构建理论 = 无长期记忆的认知侧表述,"陌生人对未外部化意图每个会话付一次"的镜像);引 how-does-ai-impact-skill-formation(即 [[2026-01-28-skill-formation-rct|RCT]] 总结帖,"文献已证实心智模型更不详细"——作者视为权衡非灾难);脚注 2 ↔ 薄包装现象
- 同标签相关文:will-my-job-still-exist(职业未来,与 05-09 源"价值追问"同族)——潜在新源

## 待办 / 后续

- 开放问题:agent 长期理论保留的机制与现状(权重内化/超长上下文/文件记忆,见主题页)
- 80/20/10 为作者单一样本自报——推广性待核;与 Keep Rate/采纳率的对照数据缺
- 文内链接未摄入:continuous-learning(权重内化梦想的出处)、will-my-job-still-exist;Victor Taelin 推文(怪异代码库理论构建,轶事)
