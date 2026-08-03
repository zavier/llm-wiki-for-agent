---
type: answer
tags: [ai-agents, comparison, human-factor]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-03
refs: [pure-impure-engineering, comprehension-debt, cognitive-surrender, intent-debt, orchestration-tax, lethal-trifecta, agent-verification, agentic-engineering, factory-model, management-collapse, distillation-anxiety, 2026-01-28-skill-formation-rct, theory-building, wicked-features]
sources: [2025-03-19-measuring-ai-long-tasks, 2025-06-22-pure-and-impure-engineering, 2025-12-24-nobody-knows-how-software-products-work, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2026-06-05-intent-debt, 2026-01-28-skill-formation-rct, 2026-05-24-orchestration-tax, 2026-02-25-factory-model-coding-agents, 2026-02-04-agentic-engineering, 2026-05-05-cognitive-surrender, 2026-03-14-comprehension-debt, 2026-01-13-good-spec-for-ai-agents, 2026-08-02-building-effective-ai-agents, 2026-05-08-ai-native-organization]
status: active
---

# AI coding 相比传统开发:解决什么、新增什么

综合结论:AI coding 解决的**都是"执行/获取"类问题**,新增的**几乎全部是"理解/判断/验证"类问题**——它把人的稀缺资源从"写代码"搬到"判断与理解";传统开发里最贵的隐性成本(知识获取、意图传递)变便宜,一套新的隐性成本(理解债、投降、编排税)在那里生长。

## 一、被优化/解决的传统问题

| 传统痛点 | AI coding 的解法 | 依据 |
|---|---|---|
| 实现速度:想法→代码的漫长路径(打字/查文档/样板/不熟技术栈) | 生成不再稀缺;AI 可处理任务时长每 7 个月翻倍(GPT-2 4 秒 → Opus 4.6 ~16h) | [[2025-03-19-measuring-ai-long-tasks]] |
| 知识门槛:新领域需长期内化,资深 vs 初级差距巨大 | "问题对你新但对世界不新"的领域,LLM 决策点同样聪明或更聪明——impure 工程自报 ~30% 提速,与类型系统/调试器同级 | [[pure-impure-engineering]] |
| 大系统战争迷雾:老代码库只有少数人能答"为什么这样",调查成本高 | AI 加速"探索性手术"与快速构建部分理论(Goedecke 承认的 LLM 正刃) | [[2025-12-24-nobody-knows-how-software-products-work]]、[[2026-07-11-in-defense-of-not-understanding-your-codebase]] |
| 意图传递:走廊对话/评审评论/事故记忆逐人传递,四年老工程师 = "意图文档" | 代理让记录变便宜——"旧借口没了":决策时刻写 ADR 几乎不花钱 | [[intent-debt]] |
| 验证成本:传统开发测试写得慢写得贵 | 测试成为"把不可靠代理变成可靠系统的机制";spec 是杠杆,舰队规模下平庸 vs 优秀几乎全由 spec 质量决定 | [[agentic-engineering]]、[[factory-model]] |
| 人手瓶颈:团队规模决定并行度 | 代理可并行(多代理研究 +90.2% 收益)——但见编排税 | [[multi-agent-systems]]、[[2026-08-02-how-we-built-our-multi-agent-research-system]] |

关键点:受益最大的是 **impure 工程**(松散理解 + 截止日期 + 混战复杂度);pure 工程(你比社区都懂、无限时间)里 AI 几乎无用——解释"AI 对一些人神奇、对另一些人无用"(见 [[pure-impure-engineering]] 的 AI 有用性差异)。

## 二、新增的问题

| 新问题 | 机制 | 为什么传统开发没有 |
|---|---|---|
| 理解力债务 [[comprehension-debt]] | AI 生成速度远超人类评估速度(速度不对称);"被评审的代码 = 被理解的代码"假设失效;虚假信心——代码库干净、测试全绿,清算在"最糟糕的时刻"到来 | 传统开发代码增长慢到人能跟上;AI 时代是几百次"看着没问题"的审查累积 |
| 认知投降 [[cognitive-surrender]] | offloading 退化为 surrender:AI 输出 = 你的输出;Wharton:AI 错时 73% 被接受、信心反升;路径依赖(跳过一块,下一块几乎必然继续投降) | 传统开发"抄 StackOverflow"也有,但 AI 让它系统化、规模化、无摩擦 |
| 意图债 [[intent-debt]] | 意图是唯一 AI 无法代付的债务(模型只会编出听起来自信的理由);代理每次会话冷启动 = "一夜之间团队规模翻倍,全是没有长期记忆的初级员工" | 先 AI 形态就有,但成本从"偶尔付一次(入职/离职)"变成"每个会话付一次 × 每个代理" |
| 编排税 [[orchestration-tax]] | 启动便宜、闭环贵;你是代理们的 **GIL**——唯一串行处理器;Amdahl:串行分数 = 判断;5 个代理 = 5 次上下文冷 reload + 后台焦虑 | 全新 overhead 类别——传统开发没有"代理舰队"要管理 |
| 致命三要素 [[lethal-trifecta]] | 速度 × 非确定性 × 成本组合:审查成瓶颈、无法复现归因、便宜迭代鼓励验证偷工减料 | 速度与成本传统开发也有,但**非确定性**是全新的 |
| 验证缺口 [[agent-verification]] | 验证是瓶颈不是生成;测试无法覆盖"没想到要指定的行为";LLM-as-a-Judge 与自验证共享盲区;AI 改几百条测试匹配新行为时,唯一能答"改动必要吗"的是人的理解 | 传统开发验证是质量门,现在是吞吐问题 |
| 技能萎缩 [[2026-01-28-skill-formation-rct]] | RCT(一手):AI 辅助组概念理解/代码阅读/调试均受损,平均无效率增益;**agentic 场景损失更大**(不写查询 = 失去斟酌过程);"一代能 prompt 但不会 debug" | 传统开发技能形成是默认发生的;现在必须主动设计"理解强制点" |
| 组织层新问题 [[management-collapse]]、[[distillation-anxiety]] | 管理塌缩非消失(10 件事命运分化);员工调教好的 agent 人走时的知识资产继承——无公司有方案;绩效评估失效 | 传统组织知识在人脑里跟着人走;现在知识在配置文件和 agent 里,交接问题变形 |

## 三、两张表的连接

1. **核心反讽**(来源: [[2026-02-04-agentic-engineering]]):AI 辅助开发**比传统开发更奖励好工程实践**——spec 越好输出越好、测试越全委派越自信、架构越干净幻觉越少。"AI 没造成问题;跳过设计思考造成了。"
2. **一条主线**:AI coding 把传统开发中"昂贵但低频"的成本(理解、意图、知识)变成"便宜但高频"的成本——每笔小到不值得注意,但按会话和代理数计息。这是 [[comprehension-debt]] 比技术债更危险的原因:**技术债通过摩擦自我宣告,理解债制造虚假信心**。
3. **瓶颈转移**(来源: [[2026-05-24-orchestration-tax]]):8 个代理不加速你的判断时间,只加深喂给它的队列——系统吞吐 = 评审步吞吐。新旧问题共同根:**人仍然是唯一的串行判断点**,AI 把喂给它的量放大了数量级。
4. **对冲**:并非全是 AI 引入的——战争迷雾(大系统零人能答基本问题)AI 之前就存在,意图债有先 AI 形态;准确说法:AI 加速了这些问题的**累积速率**,并把结算单位从"年"变成"会话"。因果机制见 [[wicked-features]](系统复杂到禁止理解的结构原因)与 [[theory-building]](理论侵蚀的日常性)。

## 背景问题

- 记录时的问题:"使用AI coding过程中,相比传统开发,可以优化解决哪些问题,同时新增了哪些新的问题?"
- 当时的 wiki 状态:43 份源文档已摄入;Goedecke 五篇与债务框架(Triple Debt Model)一手化完成;综合页与主题页覆盖理解力/编排税/意图债三层
