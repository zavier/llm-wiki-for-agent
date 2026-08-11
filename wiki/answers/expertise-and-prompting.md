---
type: answer
tags: [ai-agents, prompting, expertise, workflow]
topic: ai-agents
created: 2026-08-09
updated: 2026-08-10
refs: [expertise-leverage, theory-building, cognitive-surrender, meat-proxy, intent-debt, ai-agent-spec, agent-management, agentic-engineering, codebase-consistency, spec-driven-development, wicked-features, comprehension-debt, agent-verification, curse-of-instructions, context-rot, file-as-memory, long-running-agents, pr-contract, distillation-anxiety]
sources: [2026-07-24-llms-reward-expertise, 2026-01-28-skill-formation-rct, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2025-12-24-nobody-knows-how-software-products-work, 2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-02-04-agentic-engineering, 2026-03-26-code-agent-orchestra, 2026-01-08-coding-agents-manager, 2025-09-15-your-code-is-your-responsibility, 2025-04-12-wicked-features, 2026-05-05-cognitive-surrender, 2026-02-11-codex-agent-first-engineering, 2026-04-03-programming-with-ai-agents-as-theory-building, 2026-06-15-agentic-code-review, 2026-03-06-will-my-job-still-exist, 2026-08-02-building-ai-native-engineering-team, 2026-02-09-cognitive-debt, 2026-03-23-triple-debt-model]
status: active
---

# 领域专长与提问方式:从定义到绿地/存量开发的完整线

> 切面:与 [[ai-coding-full-lifecycle]](全流程能力建设)互补——那条讲"怎么做+学什么"的体系,这条聚焦"专长 × 提问方式"这一条纵线:专长是什么 → 提问方式为何差距巨大 → 业务/系统维度 → 绿地与存量两种开局 → 设计分工的分层。

## 一、什么是领域专长

领域专长 = 你对某个问题域的**理论**(见 [[theory-building]],Naur 1985):对"程序是什么、为什么"的直觉性理解。不是泛泛的技术知识,而是对特定系统、特定领域的具体把握——知道"X 在这里不适用"、能识别"这个输出看起来不对劲"。

三个关键特征(来源: [[2026-07-24-llms-reward-expertise]],[[expertise-leverage]]):

- **它是杠杆的资本**:对系统有理论,就能把 LLM 推得更狠——敢说"不,可以更简单""我们不是已经做了 X 吗";没有理论只能接受第一版
- **两端不对称**:无专长者被托底(至少得到 sort-of-okay 的结果),有专长者被放大(同模型价值倍增)
- **技巧不可复制**:Tao × ChatGPT 案例(mode shunting/推回式纠错/自导下一步)证明——关键不是 prompt 工程好,是数学好

一句话:**领域专长 = 带着独立观点进场,把 AI 输出当原料而非答案的能力。** 镜像面是 [[cognitive-surrender|认知投降]]:同模型同输出,区别在用户是否带理论进场。

## 二、提问方式对结果的影响

提问方式的影响远大于表面,但它不是独立的"prompt 技巧",而是**专长的外显**:

- **模糊 vs 具体**([[ai-agent-spec]]):模糊 spec 产生模糊代码,舰队规模下乘法式放大;具体化四策略——限定 scope / 指向源码 / 参照既有模式 / 描述症状;但探索阶段模糊提示合法
- **委托式 vs 专长驱动式**(差异最大,RCT 量化,来源: [[2026-01-28-skill-formation-rct]]):AI Delegation(纯委托)得分 **39%**,Generation-Then-Comprehension(生成后理解+纠偏)**86%**——同模型差一倍多
- **专家式提问四特征**(Tao 案例):短准只回主旨;mode shunting(信号专长 → "与专家对话"模式,输出更简洁);推回式纠错不直接反驳;自导下一步
- **写 brief 不是 vibe**([[agent-management]] 七字段):outcome / context / constraints / non-goals / acceptance criteria / integration notes / verification plan——模型无法澄清你从未给的需求,只会用假设填补,假设会复合
- **数量与结构**:[[curse-of-instructions|指令诅咒]](越多遵循越差)、[[context-rot|上下文腐烂]](token 越多召回越差);结构化(Markdown 标题/XML)明显更好;详细度匹配任务复杂度
- **验证先行**:prompt 里直接给测试用例,验收标准写进提问而非事后检查

## 三、专长的维度:业务知识与系统了解 > 通用技术深度

编码场景的专长主体是**对"这个系统"的理论**,不是对"编程"的理论:

- **"具体细节主导设计"**([[2026-07-24-llms-reward-expertise]]):"X 在这里有效吗"这类问题 Tao 只能对数学问、Goedecke 只能对 GitHub 系统问——**宁可要代码库熟悉度,不要通识深度**;[[pure-impure-engineering]] 闭合:AI 时代回报最高的是 impure 式系统熟悉(提速 ~30%),不是 pure 式技术完美主义
- **业务知识在理论之内**:理论的 why 大量是业务——[[wicked-features]](自助托管/组织策略/本地化/合规)全是业务需求却影响每个功能;[[2025-12-24-nobody-knows-how-software-products-work|战争迷雾]]:"Y 型用户能访问 X 吗"这类业务问题常零人能答,**能回答业务问题 = 工程团队核心职能**;业务规则已沉积为系统行为,懂系统就懂了一半业务
- **对系统不了解 → 无法判断 → 只能照单全收 → 失去把控**:这是 80/20/10 评审漏斗的反面(来源: [[2026-04-03-programming-with-ai-agents-as-theory-building]])——能 kill 80% 输出的依据是系统理论,无理论者无拒绝依据只能接受(投降);极端形态是 [[meat-proxy]](人退化为原样转发层,评审责任反转)
- **修正:门槛是"自己的部分理论",不是完全理解**([[2026-07-11-in-defense-of-not-understanding-your-codebase]]):大系统里人人持部分错误理论是常态;能力 = 有自己的部分理论 + take a position(做 educated guess、承担后果);部分理论已足以拒绝 80%

## 四、绿地开发:没有代码可读,义务转化而非消失

绿地没有存量代码,但下列义务原样存在且权重更高(无 prior art 托底):

1. **意图全在你脑子里**——why 是模型唯一只能捏造的东西([[intent-debt]]),绿地是零存量可反推,不写必猜
2. **架构/技术栈/边界是 Own 侧**(delegate/review/own 三分法,[[agent-management]])——"委派任务不委派判断,代理会货搬运烂架构"([[2026-03-26-code-agent-orchestra]])
3. **一致性从第一天开始**——开局代码就是这个系统未来的全部 prior art,烂模式会自我复制([[codebase-consistency]])
4. **理论构建从第一天建仓**——今天 AI 写的每一行就是三个月后你要维护的存量;全程 AI 写、人不读 = 从第一天放弃理论构建,六个月后面对没人懂的生产系统,连"曾经懂过"的阶段都没有(RCT -17% 与错误即学习机制,[[2026-01-28-skill-formation-rct]])

"直接沟通需求、AI 设计实现即可"的合法例外只有**原型/个人脚本/学习/头脑风暴**——"原型 vibe 没问题,上线切回工程模式"([[2025-09-15-your-code-is-your-responsibility]]、[[agentic-engineering]]);证据:generator-evaluator 对比实验中一句话 prompt solo($9/20min)与带 harness($200/6h)的质量差距立现([[agent-verification]])。

**实务结论**:绿地开发前的准备 = 写 spec(六区域,why 来自你)+ 自己定架构与技术栈 + 定验收标准与测试策略(绿地写测试成本最低)+ 小步实现每步评审(评审的目的是为自己持续建仓理论)。一句话:**存量系统吃历史理论的红利,绿地没有红利可吃——必须从第一天亲自建仓,否则 AI 会以你追不上的速度帮你把战争迷雾建好。**

## 五、存量系统(新人接手老系统)

**不能不读代码,三个硬伤**:

- AI 默认生成"最合理方式"而非你系统的 prior art([[codebase-consistency]]);"参照既有模式"策略要求你知道模式是什么——不读代码连这条都用不了
- 新人理论为零 → AI 给什么接什么 → 评审退化为追认([[cognitive-surrender]])
- 老系统是战争迷雾:代码库 = 唯一可靠答案源,"探索性手术"是独立于写码的稀缺技能,跳过读码 = 跳过获得它的唯一途径

**但正确姿势不是"人工读三个月"**:废弃代码库复活的标准做法 = **先端到端理解一条流,再逐步扩展**(部分理论即可,[[2026-07-11-in-defense-of-not-understanding-your-codebase]]);LLM 是加速构建部分理论的杠杆——用 AI 做 agentic 检索、解释陌生模块、陪做探索性手术;RCT 的"概念询问"模式(拿 AI 当老师问"为什么这么设计")是 65-86% 高分模式。一句话:**用 AI 加速你理解系统,而不是替代你理解系统。**

## 六、设计分工:心中有数是底线,程度按任务分层

"零思考 → AI 设计 → 人检查"的结构性漏洞:**检查设计本身需要理论**——反制启发式第一条"读输出前先构建期望"([[cognitive-surrender]]);没有期望的检查 = Wharton 73% 错也接受。设计环节一旦外包,评审/测试/验收全部失去锚点——检查的对象与依据成了同一来源。

分层([[agent-management]] + [[spec-driven-development]]):

| 任务层 | 设计分工 |
|---|---|
| 小任务(一句话 diff) | 跳过计划,直接做 |
| 常规功能 | 采访式 co-design:AI 采访你 → 共同产出 SPEC.md → 新会话执行;AI 摆全选项,**拍板的是你** |
| 架构/新抽象/模糊需求/安全关键 | Own 侧,不委托设计 |
| 探索阶段 | 模糊提示合法,但产出回到自己判断里过滤 |

两种模式的 RCT 落点:零思考委托 = AI Delegation(39%);有大致思路 + AI 实现 ≈ Generation-Then-Comprehension(86%)——差距不在努力程度,在**认知参与发生在哪一环**。

## 七、为什么"理解"不可委托,只能加速

"为什么不能让 AI 替人理解代码"的四层答案:

1. **理解不是可搬运的工件,是人的认知状态**(Naur 1985,[[theory-building]]):程序的真正产品是活在开发者头脑中的理论,代码/文档只能部分捕获;技术债住在代码里,**认知债住在人脑里**([[2026-02-09-cognitive-debt]])。AI"理解"了,理解在它的上下文里,不在你的头脑里——委托理解如同委托别人替你健身;AI 能交付的是关于理解的**报告**,而"仅从文档重建程序理论严格不可能"。
2. **理解的全部下游功能都挂在人身上**:判断与拒绝(80/20/10 漏斗;所有验证体系的隐性前提 = 有人理解系统)、问责(on-call 时 AI 不在场;"AI 写的"=狗吃作业)、意图(why 只能源于人)、回答业务问题(战争迷雾里"能回答问题"是工程团队核心职能)。委托执行的逻辑是"交 how 留 what"——但理解恰恰就是 what 层,委托理解 = 连检查委托结果的能力一起交出(**递归塌陷**:不能用外包来的理解检查外包的理解)。
3. **AI 的"理解"不可靠、不持久**:agent 每次会话从零构建理论、无法保留(保留 > 构建,[[2026-04-03-programming-with-ai-agents-as-theory-building]]);自评系统性偏乐观;同族模型写/审/修全链条 = 盲点相关、在同一处自信地错("循环可以非常确定也非常错,没人能分辨")。
4. **最危险的是赝品效应**:用 AI 生成文档/解释替代真理解 = 表面替代真实,使认知债更难检测([[comprehension-debt]])——理解债制造虚假信心(代码干净、测试全绿、解释头头是道),清算在最糟糕时刻到来;且"错误即学习"机制决定理解在搏斗过程中形成,委托理解 = 绕过理解形成本身,现在没有,未来也不会有(RCT -17% 且无效率补偿)。

**正确分工:AI 是理解的加速器,人是理解的载体。** 加速是真实的(概念询问 65% 高分模式、解释陌生模块、探索性手术、reimplementation);判据 = Andy Clark 互惠放大:**每次协作结束时,你的心智模型更尖了还是更糊了?** 更尖 = 加速,更糊 = 委托——哪怕两次会话的产出看起来一模一样。

## 八、全闭环(AI 替代人理解/记忆/排查)的边界

"让 AI 替代人理解 + 沉淀文档记忆 + 出问题 AI 排查修复"——这是 OpenAI 零人工实验走过的方向([[2026-02-11-codex-agent-first-engineering]]:1/10 时间/100 万行/1500 PR,审核全代理化),部分可行,但边界清晰:

- **前提投入是数年级的**:环境规范不足是早期唯一瓶颈;doc-gardening/黄金原则/规范架构是类基础设施,作者明言"不应在没有类似投入的情况下假定可以泛化";同公司官方指南仍建议人 **own 最终评审与合并**([[2026-08-02-building-ai-native-engineering-team]])——内部实验激进、对外建议保守,"建议给别人的 vs 自己敢做的"本身就是信息
- **三环节现状**:沉淀文档记忆部分可行([[file-as-memory]]、[[long-running-agents]] 特征清单+progress 文件),但 Naur 边界未消失(agent 仍每次从零构建理论,长期理论保留是"下一个大创新",还没来),且 AI 生成文档 = 表面替代真实;AI 排查修复分层可行(OpenAI Deploy 阶段:agent 做日志解析/triage/hotfix 提议,人 own **新发事故/敏感变更/低置信**——而真正的生产事故恰好全是这三样);AI 排查依赖现场构建的局部理论,常规问题好、怪异长尾挣扎——事故分布恰恰偏向怪异长尾
- **全闭环的真正代价 = 同时外包三样只在失败时刻才兑现的资产**:①盲点相关的确定性幻觉(无异质信号,连"知道自己错了"的能力都没有)②验证对象消失(测试只能覆盖想到的行为,事故发生在没想到的行为上)③**恢复能力的不可逆**(全闭环失败时——非确定性+长尾是数学保证——恢复需要人理解系统,而理解能力已被裁掉;重建理解远比维护贵:废弃代码库复活要端到端重建,reorg 摧毁默会知识后回答退化为调查)
- **实证已有人付过价**:Faros 22k 开发者——AI 放量后 incidents/PR **+242.7%**、零评审合并 +31.3%,"没人决定停止评审,量让人跟不上"([[2026-06-15-agentic-code-review]]);组织级死结:事故排查本是组织重建理解的时刻,全 AI 修复 = 理解永远停在交付日,战争迷雾复利累积;加 [[distillation-anxiety|培养断裂]]——不让人碰系统,梯队是空的,AI 真修不了时没人兜底
- **诚实的结论**:Goedecke 自认"没有真正的新能力 AI 需要才能取代我——只需更好更可靠"([[2026-03-06-will-my-job-still-exist]]),全闭环非永远不可能;分界在系统性质——**可牺牲的系统**(内部工具/原型/可重来/无合规)可以试,**生产关键系统**的全闭环 = 用日常效率交换尾部脆弱性。卡住全闭环的不是 AI 的能力,是**失败时刻的兑现结构**:系统一定会失败,那时能兑现理解、问责和恢复的只有人

## 核心论断

**提问方式、绿地/存量开局、设计分工,表面是三件事,底层是同一件事:专长的在场与缺席。** 专长决定提问质量(二)、决定能否判断 AI 方案(三)、决定绿地建仓与存量复活的速度(四、五)、决定设计分工中哪一环必须留在人侧(六)。再往深一层:**专长之所以必须留在人侧,是因为理解不可委托(七)——它是认知状态而非工件,且它的全部价值在失败时刻兑现;全闭环的边界不由 AI 能力决定,而由失败时刻的兑现结构决定(八)。** 而专长本身正被 AI 使用侵蚀(RCT -17%)——所以"保持专长"不是开发之外的修养,是这条流水线上最需要主动防守的资产。

## 背景问题

- 记录时的七轮问题:①什么是领域专长?不同提问方式对结果的影响?②专长是否包含业务知识与系统了解?对系统不了解是否失去把控?③绿地开发是否需要提前了解代码现状,还是直接 AI 沟通需求?④新人接手老系统能否不读代码直接 AI 开发?⑤功能开发需要研发先有设计思路,还是 AI 设计人检查?⑥为什么不能让 AI 替人理解代码?⑦能否全闭环:AI 替代人理解+沉淀文档记忆+出问题 AI 排查修复?(⑥⑦ 2026-08-10 追加)
- 当时的 wiki 状态:52 份源文档已摄入;[[expertise-leverage]]、[[theory-building]]、[[cognitive-surrender]] 等概念页齐备;answers 已有 [[ai-coding-full-lifecycle]](体系化能力建设),本页定位为"专长×提问方式"纵线的综合。
