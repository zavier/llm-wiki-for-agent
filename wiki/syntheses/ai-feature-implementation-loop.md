---
type: synthesis
tags: [ai-agents, workflow, implementation]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, spec-driven-development, three-tier-boundaries, conformance-testing, context-engineering, lethal-trifecta, agent-verification, claude-md, subagents, agent-computer-interface, multi-agent-systems, file-as-memory, progressive-disclosure, self-reflection, lilian-weng, long-running-agents, context-anxiety, harness-engineering, factory-model, pr-contract, comprehension-debt, cognitive-surrender, agent-readability, openai, cursor, humanlayer, execution-graph, hive-mind, management-collapse, distillation-anxiety, alibaba, claude-code, intent-debt, loop-engineering, agent-teams, ralph-loop, process-over-prose, anti-rationalization-tables, conductor-orchestrator, agent-management, agentic-engineering]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-08-02-building-effective-ai-agents, 2026-08-02-effective-context-engineering-for-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2026-08-02-equipping-agents-with-agent-skills, 2025-10-06-file-system-is-the-new-database, 2023-06-23-llm-powered-autonomous-agents, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-04-19-agent-harness-engineering, 2026-02-25-factory-model-coding-agents, 2026-01-07-ai-code-review, 2026-03-14-comprehension-debt, 2026-05-05-cognitive-surrender, 2026-02-11-codex-agent-first-engineering, 2026-04-30-cursor-agent-harness-improvement, 2026-03-12-skill-issue-harness-engineering, 2026-05-08-ai-native-organization, 2026-05-14-claude-code-large-codebases, 2026-06-05-intent-debt, 2026-06-07-loop-engineering, 2026-03-26-code-agent-orchestra, 2026-05-03-agent-skills, 2026-01-02-future-agentic-coding, 2026-01-08-coding-agents-manager, 2026-02-04-agentic-engineering, 2026-01-31-self-improving-agents, 2026-06-15-agentic-code-review, 2026-05-24-orchestration-tax, 2026-08-02-building-ai-native-engineering-team, 2025-03-19-measuring-ai-long-tasks, 2026-02-09-cognitive-debt, 2026-01-28-skill-formation-rct, 2026-02-12-evaluating-agents-md, 2026-04-07-cognitive-parallel-agents, 2026-03-23-triple-debt-model]
status: active
---

# 让 AI 更好实现功能:从 spec 到落地的闭环

综合结论:让 AI 高质量实现功能的关键不是"更聪明地提问",而是把功能拆成「规范 → 计划 → 小任务 → 自检 → 反馈」的闭环,在每个环节消除歧义、控制上下文、锁定验收标准。

## 综合论点

基于 [[2026-01-13-good-spec-for-ai-agents|Osmani 的 spec 指南]] 与 [[2026-08-02-best-practices-claude-code|Anthropic 官方 Claude Code 最佳实践]],AI 实现功能失败的四个主因:

| 失败主因 | 表现 | 对应解法 |
|---|---|---|
| 模糊输入 | 含糊的 what/why,spec 太 vague | 六区域清单 + goal-oriented 愿景(见 [[ai-agent-spec]]) |
| 过载输入 | 巨型 prompt 触发指令诅咒与 [[context-rot|上下文腐烂]] | 上下文工程:模块化 + JIT 检索 + compaction/笔记(见 [[context-engineering]]) |
| 无验收标准 | 无法判断"做对没有" | 测试 + [[conformance-testing]],spec 里写 Success 节 |
| 无反馈回路 | 一次生成、不迭代 | 门禁流 + 失败即修正 spec([[spec-driven-development]]) |

落地闭环(每层都有具体动作):

1. **规范层** — 高层愿景先行,AI 扩写;六区域齐全;[[three-tier-boundaries|三层边界]] 限定行为;注入领域知识("products-categories 是多对多,别让 AI 猜");具体化提示四策略(scope 任务/指向源码/参照既有模式/描述症状);大功能先让 AI 采访你(AskUserQuestion → SPEC.md)
2. **计划层** — [[plan-mode|Plan Mode]] 只读规划,先对齐架构/风险/测试策略,无歧义后才允许写码;能一句话描述 diff 的小任务直接跳过计划
3. **任务层** — 拆成可独立测试的小任务("建注册端点并校验邮箱"),一次只喂一个任务 + 相关 spec 切片 + 全局约束
4. **质量层** — 验证门禁四档:同 prompt 跑测试 → `/goal` 条件 → Stop hook 确定性门禁 → 独立评审子代理("干活的不给自己打分",见 [[agent-verification]]);叠加一致性测试与 [[llm-as-a-judge]] 查主观质量;要求证据而非断言;人始终是 exec in the loop
5. **反馈层** — 测试失败 → 修正 spec 或 prompt → 重新同步代理;spec 是活文档,版本化维护;把成功路径与常见错误沉淀为 [[skills|skill]](让 Claude 自省后编码成可复用上下文,来源: [[2026-08-02-equipping-agents-with-agent-skills]])

## 失败模式与闭环修复

Anthropic 官方归纳的五种常见失败(来源: [[2026-08-02-best-practices-claude-code]]),每条都对应闭环里的具体动作:

| 失败模式 | 表现 | 修复动作 |
|---|---|---|
| 厨房水槽会话 | 一个任务混入无关问题,上下文充满无关信息 | 任务间 `/clear` |
| 反复纠正 | 连续纠正仍错,上下文被失败尝试污染 | 两次纠错后 `/clear` + 写更好的初始 prompt |
| 过度规格化 [[claude-md]] | 文件太长,规则被忽略 | 无情剪枝,或转成 hook 确定性执行 |
| 信任-验证鸿沟 | 看似合理的实现不处理边界情况 | 始终给验证手段;无法验证就别上线 |
| 无限探索 | 不限定范围的"调查"读几百个文件 | 窄化范围,或用 [[subagents]] 隔离 |

跨会话长时任务另有三类失败(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]]),harness 层解法:

| 失败模式 | 表现 | 修复动作 |
|---|---|---|
| 一次性做完 | 试图一口气实现全部 → 上下文耗尽 → 下一会话靠猜恢复 | 特征清单 + 一次只做一个特征(见 [[long-running-agents]]) |
| 提前宣布完成 | 后到的会话看到进展就宣布项目完成 | 特征清单 passes 门禁:未完成特征全部可见(反事实目标) |
| 未测试就标完成 | 跑过单测/curl,但识别不出端到端不工作 | 显式提示 + 浏览器自动化(Puppeteer MCP),"像人类用户一样测试" |

另两个机制级失败模式(来源: [[2026-08-02-harness-design-for-long-running-apps]]):**上下文焦虑**(接近以为的上下文极限时提前收尾,见 [[context-anxiety]],对策 = context reset 或更强模型)与**自评偏差**(代理自信夸奖自己的平庸产出,对策 = 干活与评分分离,见 [[llm-as-a-judge]])。

**总体观**(来源: [[2026-04-19-agent-harness-engineering]]):多数失败是**配置问题而非模型问题**("skill issue")——代理做蠢事时先修 harness(AGENTS.md 加行、hook 拦截、拆规划器/执行器、接验证回压),而不是"等下一个模型";棘轮原则:每条规则追溯一次真实失败(见 [[harness-engineering]])。

**术语与立场层**(来源: [[2026-02-04-agentic-engineering]],Osmani):vibe coding(不读 diff 的 YOLO,人有合法用途:原型/个人脚本/学习/头脑风暴)→ AI-assisted engineering → **agentic engineering**(Karpathy 命名:AI 做实现、人拥有架构/质量/正确性,"测试是把不可靠的代理变成可靠系统的方式");"AI 辅助开发比传统开发**更奖励好工程实践**"——spec 越好输出越好、测试越全面委派越自信、架构越干净幻觉越少;技能差距:不成比例惠及资深、初级有 skill atrophy 风险("一代能 prompt 不能 debug");"agentic engineering 是另一种难——拿打字时间换评审时间"(见 [[agentic-engineering]]、[[vibe-coding]])。

**范式层**(来源: [[2026-02-25-factory-model-coding-agents]]):软件第三纪元——从写代码到编排写代码的系统(工厂心智模型,见 [[factory-model]]);两个与闭环直接相关的推论:①**spec 是杠杆**——舰队规模下模糊想法乘法式放大,spec = 产品思维的外显(支撑本闭环的整个前提);②**验证是瓶颈,不是生成**——生成不缺,缺置信地知道正确;人工审查是安全系统。

**多代理编排层**(来源: [[2026-03-26-code-agent-orchestra]],Osmani 演讲):指挥→编排范式转换(单代理同步/窗口天花板 vs 多代理异步/你计划+查岗,角色光谱完整定义见 [[conductor-orchestrator]]——五轴:控制范围/自主度/同步性/工件可追溯性/人力分布;ephemeral vs git 痕迹;前载+后载人力模型);单代理三堵墙(上下文过载/无专长/无协调);四乘法理由(并行 3×/专长化/隔离/复合学习,"三个专注代理胜过干三倍时间的一个通才");**Agent Teams 补齐协调原语**(共享任务列表+依赖跟踪+文件锁+对等消息+计划审批+@reviewer 队友,见 [[agent-teams]])——Anthropic"实时协调不成熟"判断正被产品化演进;2026 工具三层(Tier 1 进程内/Tier 2 本地编排器/Tier 3 云端异步);Ralph Loop 形式化(stateless-but-iterative 五步 + 四通道记忆 + 3+ 卡死杀,见 [[ralph-loop]]);**委派任务不委派判断**(架构/说不/全上下文评审留给人类——代理会货搬运烂架构);质量门三件套(计划审批/hooks/AGENTS.md 复合学习);"人类瓶颈曾是特性不是 bug"——代理军团让微小错误以超出追赶能力的速率复合;编排六大挑战(信任模型/协调冲突/上下文共享孤岛/规格上移/调试与降级模式/伦理责任,"AI 可观测性"成新工具类)。

**编排税层**(来源: [[2026-05-24-orchestration-tax]],Osmani;术语由 Richard Seroter 在 Google I/O 命名):**人是并发系统里的慢串行组件**——启动代理便宜、闭环评审贵(GIL 类比:你是代理们的锁;Amdahl:串行分数 = 判断,吞吐 = 评审步吞吐,加代理只加深队列);编排税 = 代理产出与实际可合并之间的结构性缺口;感觉忙 ≠ 生产力(失败模式不可见:20 个代理跑满 dashboard 与往 main 运好代码脱钩);五条注意力架构实践:**按评审率缩放舰队**(回压,"AI 工具乐意让你开 20 个,那只是 UI 功能")/两堆分类(隔离委托 vs 判断即工作绝不并行)/批量评审(冷 reload 成本)/锁只花在判断上(机器自证 80%)/保护串行时间("编排不是真正的工作,是工作周围的 overhead");不付税 = 同时累积技术债+认知债(Storey 框架一手化: [[2026-02-09-cognitive-debt]]——"加代理 = 加协调开销/隐形决策/认知负荷"的 Brooks 回声)或 [[cognitive-surrender]](注意力耗尽→接受代码);**前传:ambient anxiety tax**(来源: [[2026-04-07-cognitive-parallel-agents]])——上限 = 监督吞吐非理解吞吐,隐藏成本 = 背景警觉,天花板随每线程复杂度移动,**先降范围再降数量**;与 3-5 甜点、WIP 上限、批量查岗互证(见 [[orchestration-tax]])。

**管理层**(来源: [[2026-01-08-coding-agents-manager]],Osmani):"规模化 AI 编码不再是 prompt 问题,是管理问题"——最高杠杆开发者 = async-first manager;双模式(本地高触达 human-in-the-loop + 云端异步后台);四项技能(brief 七字段/委派三档 delegate-review-own/验证循环+PR packet/异步查岗);边界规则(一代理一 PR、共享接口第一个 PR 人主导);判断瓶颈("AI 抬高判断的价值"——WIP 上限+kill criteria);六步操作系统 = 工厂流水线的个人版(见 [[agent-management]]、[[factory-model]]);外部锚点:[[simon-willison]] 评审瓶颈论。

**官方指南层**(来源: [[2026-08-02-building-ai-native-engineering-team]],OpenAI):SDLC 六阶段(Plan/Design/Build/Test/Review/Document/Deploy&maintain)每阶段 Delegate/Review/Own 三分法 + checklist;能力基线:METR 2025-08 前沿模型 2h17m 连续工作 50% 正确率(已核一手:[[2025-03-19-measuring-ai-long-tasks]],2026 年 Claude Opus 4.6 已达 ~16 小时)、任务时长约 7 个月翻倍(此前 30 秒);四使能 = harness 四支柱(统一上下文/结构化工具执行/持久项目记忆/评估循环);测试 = 事实源("定义高质量测试是让 agent 建功能的第一步",独立会话+TDD 先失败背书);评审 = 专门训练 P0/P1 的模型 + gold-standard PR 评估集 + PR comment reactions 度量;落地载体三处皆 AGENTS.md(循环/文档/覆盖);PLAN.md 提交进代码库;文档/运维进发布流水线(MCP 接日志、模拟事故演练);结论"小规模定向工作流复合增长";案例:Cloudwalk(全员 Codex)、Sansan(竞态/DB 关系评审)、Virgin Atlantic(MCP 运维集成)(见 [[agent-management]])。

**评审层**(来源: [[2026-01-07-ai-code-review]]):验证瓶颈的量化——PR 增大 ~18%、每 PR 事故 +24%、变更失败率 +30%、45% AI 代码含安全缺陷、逻辑错误 1.75×/XSS 2.74×(二手待核);人类侧对策 = **PR Contract**(意图/证据/风险+AI 角色/评审重点,见 [[pr-contract]]);新失败模式:**知识转移断裂**(AI 写无人能解释 → on-call 昂贵)与**评审限速**(产出 > 验证容量,拆小 PR 应对)。

**评审经济学层**(来源: [[2026-06-15-agentic-code-review]],Osmani;四数据集厂商/平台有立场但效应量跨源一致):瓶颈确认——"写便宜了,理解没便宜",review = 当前杠杆最大的技能;Faros(22k 开发者/4k 团队,2026-03):churn +861%、incidents/PR +242.7%、人均缺陷率 9%→54%、评审时长 +441.5%、**零评审合并 +31.3%**("没人决定停止评审,量让人跟不上")、**成熟纪律团队被击穿一样狠**;CodeRabbit(470 开源 PR):AI 变更 ~1.7x 问题(逻辑 +75%/安全 1.5-2x/可读性 3x+),"可预测可定位"→ 可直瞄;GitClear:4x 原始产出 vs ~12% 真实增益;GitHub:Copilot review 60M+/年 10x、平台 >1/5 评审涉代理;含义:QA/评审工作量随产出上升,裁人前先合评审缺口;三变量(blast radius/代码寿命/理解人数)决定评审策略——solo 推迟评审 ≠ 跳过验证([[intent-debt]]);评审本质从"检查推理"变"**恢复意图**"(agent 推理被丢弃,评审者 = 第一个见到代码的人;决策日志修复,arXiv 2604.16754);**评审器异质性**(4 工具并行:93.4% 发现恰好只被一个抓到、四者从未同抓一行——对抗性评审实证;"四份同模型 = 一个评审员加更大发票");**human on the loop**(人类读每行已终结;同族模型闭环 = 盲点相关+同处自信同意([[cognitive-surrender]]);人保留:问责/方向判断/高 blast 门槛/没人写下来的需求;AI 评审 = 传感器不是裁决;Osmani:风险排序式批量初审,Kun Chen:意图 upfront + 自动化评审门);行动纪律:按风险分层不按作者/测试变更比代码读得细(变异测试)/**CI 是不动的墙**(agent 梯度下降式弱化 CI 自证)/快失败昂贵尾部(agent ghost 弃审 38%,arXiv 2601.15195;断路器 2601.00753)/证据门槛/刻意小 PR("人可读的 diff 是设计约束")(见 [[agent-verification]])。

**理解力层**(来源: [[2026-03-14-comprehension-debt]]):验证与评审的**系统性边界**——"被评审的代码 = 被理解的代码"不再成立;速度不对称(初级生成快过资深审计,质量门变吞吐问题);测试与 spec 都非完整答案(见 [[comprehension-debt]]);Anthropic RCT 一手证据:AI 使用损害概念理解/代码阅读/调试且无平均效率增益,六交互模式三种认知参与式保学习(65-86%),**agentic 场景损失可能更大**(不写查询 = 失去斟酌过程)——**这是本闭环最强的反证之一:所有工程对策(门禁/评估器/契约)都假设有人理解系统,而 AI 工作流正在侵蚀这个假设本身**;**债务框架一手化**(来源: [[2026-03-23-triple-debt-model]],Storey 论文):三层系统健康(意图/代码/共享理解);认知债 = 团队级共享理解侵蚀(**≠ comprehension debt**,后者 = 个人 AI 产出-理解差距[Alakmeh 2026]);意图债 = 工件层外部化缺失;三债因果循环(意图→认知→技术→认知);AI 可能减技术债同时加速认知+意图债;**"把理解当作交付物" + "抵制理解的自动化"**(AI 生成文档替代真理解 = 表面替代真实,使认知债更难检测);监控方向:onboarding 时间/知识集中度/意图-行为差距审计(见 [[intent-debt]])。

**债务三元组完成**(来源: [[2026-06-05-intent-debt]],Osmani 引 Storey Triple Debt Model,待核):技术债(代码,AI 可重构)/ 认知债(人,可让代理解释恢复)/ **意图债(工件,唯一代理无法代付)**——*why* 是模型唯一只能捏造的东西;冷启动经济学:代理=无长期记忆的陌生人,未外部化意图从"偶尔付一次"变成"每个会话付一次 × 每个代理"(orchestration tax 大部分是意图税);"**代码是答案,意图是它本该解决的问题。AI 极其擅长产出你忘了写下来的问题的答案**";偿付 = 外部化四件套(spec 写意图 / AGENTS.md 当意图账本 / ADR 当场记 / 学习循环写回);价值迁移:代码便宜、理解可恢复,意图成为唯一必须源于人的输入(见 [[intent-debt]])——与组织层的 Architect/蒸馏焦虑、工厂层的 spec 杠杆构成同一判断的三个侧面(从工程师/组织/债务角度都指向"意图外部化是人类在循环中的不可替代职责")

**人侧机制层**(来源: [[2026-05-05-cognitive-surrender]]):投降是债务的累积机制——offloading 退化为 surrender(不再形成独立观点);Wharton 数据:AI 错时 73% 接受、信心反升(借用信心,二手待核);四个暴露特征(表面信号正确、吞吐指标不分建/批、信心干净转移、路径依赖);正反对策:个人启发式(先构建期望/当 AI 没写过/让模型反驳自己/疲劳识别/盯信心来源)+ 工程反制(验证硬退出、[[anti-rationalization-tables|反合理化表格]]、小 PR=评审单位=理解单位、概念询问优先、刻意摩擦、每周无 AI 键盘时间);正向框架 = 互惠放大(合作而非委派,见 [[cognitive-surrender]])。

**纪律工程层**(来源: [[2026-05-03-agent-skills]],Osmani 开源 agent-skills 27K stars):"代理是极其能干的初级工程师,对 diff 之外的工作没有直觉"——资深脚手架(显性化假设/spec/可评审切片/证据/缩小改动)必须被**强制**而非建议;核心区分:**过程胜过散文**(工作流+检查点+退出标准,见 [[process-over-prose]]);**反合理化表格** = 对代理还没说出口的谎言的预写反驳(LLM 是合理化机器);验证不可妥协(每个工作流以具体证据终止,"看起来对"永远不够);范围纪律(只碰叫你碰的东西,PR 可合并性的最大单一决定因素);五条不可妥协进 AGENTS.md;"工作日益变成把纪律编码成代理无法说服自己绕开的东西"。

**阵营实验层**(来源: [[2026-02-11-codex-agent-first-engineering]],OpenAI):零人工代码实验给了"环境设计决定产出"的最强证据——1/10 时间、100 万行、1500 PR、3.5 PR/人/天(自述);环境规范不足是早期唯一瓶颈;智能体可读性三级阶梯(仓库/应用/可观测性)使"服务 800ms 内启动"类约束提示化;合并哲学反转("纠错成本低、等待成本高")。

**框架厂层**(来源: [[2026-04-30-cursor-agent-harness-improvement]],Cursor):harness 改进的产品工程化——双层评测(离线 CursorBench + 在线 A/B)+ **Keep Rate**(变更保留率,测量"用户是否需要手动调整"——部分回答"验证是瓶颈"的测量缺口)+ 语义满意度(LLM 读用户回应);按模型定制工具格式(patch vs str_replace 的 reasoning token 代价 = 模型-harness 耦合实证);上下文焦虑第三次独立报告(提示调优缓解);工具错误分类与异常检测(未知错误=缺陷);护栏时代→动态上下文时代(harness 组件过时的直接例证)。

**配置工程层**(来源: [[2026-03-12-skill-issue-harness-engineering]],HumanLayer):"不是模型问题,是配置问题"的完整论证——六个配置面(AGENTS.md/MCP/skills/子代理/hooks/回压);**最高杠杆 = 回压**(成功率与"代理能否自验"强相关,验证必须上下文高效:吞输出只浮错误);**ETH Zurich 反证**(138 个 agentfile:LLM 生成的损害性能且贵 20%+,人工写的仅 +4%,多花 14-22% reasoning token 无收益);**长上下文怀疑论**("更大的窗口只是把干草堆变大"——窗口隔离优于窗口扩大);实战清单:从简单开始、失败后按需加、迭代并扔掉。

**循环工程层**(来源: [[2026-06-07-loop-engineering]],Osmani,引 Steinberger/Cherny 二手):harness 上一层的自动化——"取代'人来提示代理',设计替你做提示的系统";五件套(automations 定时发现+triage / worktrees 并行隔离 / skills 知识外化 / plugins+connectors 接真实工具 / subagents maker/checker 分裂)+ 状态文件("代理会忘,仓库不会");`/goal` = 独立模型每轮检查停止条件(maker/checker 应用到停止条件本身,见 [[agent-verification]]);循环**不替人做三件事**(验证仍在你肩上——"done 是主张不是证明";理解仍会腐烂——循环加速 [[comprehension-debt]];舒适姿势最危险——[[cognitive-surrender]] 的加速剂或解药,"同一个动作,相反的结果");**同构循环异果**(两个人建同一循环一个加速深懂的工作、一个逃避理解);"杠杆点移动了,不是工作变容易了"——循环设计比 prompt 工程更难;token 成本需警惕(富/贫模式差异极大,二手)。

**自改进循环层**(来源: [[2026-01-31-self-improving-agents]],Osmani 扩展 Ryan Carson):Ralph Loop 实操大全——六步循环(Pick/Implement/Validate/Commit/Update+log/Reset)+ SPEC→tasks JSON(/prd、/tasks skills)+ **四通道记忆**(git 提交历史/progress.txt/tasks 状态/AGENTS.md 运行笔记本,"每次改进让未来改进更容易")+ **验证记忆真的被注入**(progress.txt 需显式加入 prompt 模板);监控与止损(实时日志/checkpoint 提交/gone-rogue 检测/自动停止条件);**代理结束开 PR 绝不自动合并**(human QA 无价,与 [[pr-contract]] 阵营一致);风险护栏(只读自动批准+写人工批准/沙箱/定期重新聚焦对抗漂移);规模化 = **迭代更深而非更宽**;Cursor 规模化实验(数百代理/百万行/周;锁失败→**风险厌恶代理**;Planner-Worker-Judge 更成功,见 [[agent-teams]]);轶事:$50k 项目几百美元 API 交付(待核);"每次迭代,你与代理都变得更好"(见 [[ralph-loop]])。

**组织层**(来源: [[2026-05-08-ai-native-organization]],阿里技术,数据均二手待核):把闭环装进组织的视角——**编码 10× 但端到端仅 2-3×**(内部访谈):瓶颈在编码之外(验证/上下文/信息供给),直接支持"验证是瓶颈,不是生成";且进一步精确定位——**新瓶颈是系统信息形态("人形偏置")**:传统系统为人设计,靠人当"人肉中间件"补缺,AI 无"猜/问老王"能力,隐性成本第一次以瓶颈形式暴露(见 [[agent-readability]]);**AI 友好 5 维度**(测试/环境/架构/端到端可测/文档)是把可读性落地的组织级清单;**双层组织**(Harness 层 AI 主导 + Hive Mind 层人主导,见 [[hive-mind]])与 Execution Graph 范式(组织单元=任务+上下文+权限+工具,reorg 从季度级压到 week 级,见 [[execution-graph]]);**管理塌缩**:Architect 是最高杠杆点(隐性 know-how → AI 可消化形态,见 [[management-collapse]]);**蒸馏焦虑**是人侧死结(知识藏匿直接破坏 Harness 转型,见 [[distillation-anxiety]]);同日迭代案例(6 周 → 1 天)给出闭环提速的组织上限参照。

**企业规模部署层**(来源: [[2026-05-14-claude-code-large-codebases]],Anthropic 官方):harness 论获得**厂商官方背书**("harness 决定表现的程度超过模型本身")——五扩展点按序构建(CLAUDE.md→hooks→skills→plugins→MCP)+ LSP/子代理;**导航架构**:agentic search(本地文件系统、无索引)对比 RAG(embedding pipeline 追不上活跃团队 → **索引陈旧失败模式**:返回已改名函数/已删模块且无过期提示);LSP 符号级搜索("过滤发生在模型读任何东西之前",多语言代码库最高价值投资);**配置评审 3-6 个月**——harness 过时的第一个节奏答案(补偿旧模型的规则/工具变约束:拆单文件改动规则、p4 hook);**组织模式**:先基础设施后开放、agent manager/DRI 所有权、插件分发防部落化、治理三件套(批准清单+强制评审+限量访问)——与组织层的 Architect/蒸馏焦虑互证;组件误区表(见 source 页)。

## 支持与反证

- **支持**:GitHub 2,500+ 配置文件实证("太模糊"是头号失败原因);"curse of instructions"实验(指令越多遵循越差);[[simon-willison]] 的长期实践(一致性测试、测试套件=代理超能力、管理隐喻);Anthropic 官方实践(内部团队跨代码库经验,与 Osmani 独立指南相互印证);Anthropic 编码代理实证([[swe-bench|SWE-bench Verified]]:仅凭 PR 描述解决真实 issue,测试可验证是编码成为代理最佳领域的原因;同时"优化工具 > 优化 prompt",人类审查仍必要);工具评测自举循环实证——Sonnet 3.5 靠工具描述微调达 SWE-bench SOTA,"用 AI agents 写 AI agents 的工具"(见 [[tool-evaluation]]);奠基文献对照——[[2023-06-23-llm-powered-autonomous-agents|Weng 2023]] 的三组件框架至今成立,ReAct 循环即"tools in a loop"定义的原型(见 [[lilian-weng]]);长时任务 harness 实证——Anthropic 以 feature list 门禁 + progress 文件 + 会话仪式 + 浏览器自动化测试,让 Opus 4.5 跨多个上下文窗口持续构建生产级 web app(零提示时连"提前宣布完成"都拦不住,见 [[long-running-agents]]);**generator-evaluator 实证**——三代理(planner/generator/evaluator)从一句话 prompt 产出完整应用(solo 20 分钟/$9 vs harness 6 小时/$200,质量差距立现;评估器抓到具体到行号的真实 bug;DAW 案例 3h50m/$124.70 且 QA 每轮仅 $3-4,见 [[agent-verification]])
- **反证 / 未解决**:
  - 并行多代理的协调成本与写冲突风险:收益已有内部数据支撑(研究类 +90.2%,代价 4-15× token),但**跨领域适用性**仍是开放问题——Anthropic 自评多数编码任务并行度不足、实时协调委派不成熟(见 [[multi-agent-systems]])
  - **渐进披露的触发率风险**:Vercel 对 Next.js 16 的评测(经 [[muratcan-koylan]] 二手引述)显示 56% 案例 skill 从未被调用——披露结构再好,模型不触发就白搭;触发机制是现实瓶颈(见 [[progressive-disclosure]])
  - NeurIPS 论文提示:"LLM 生成的人格是带陷阱的承诺"——用统计数据发明人设不可靠(待原文核实)
  - 过度规范对简单任务有负面影响——"spec 详细度要匹配任务复杂度"这条经验规则尚无量化依据
  - LLM-as-a-Judge 与自验证均非万无一失,可能共同盲区;文章承认"not foolproof"
  - 文件系统记忆(2025-26 实践)vs 向量库记忆(2023 规范):两侧文献现已齐备(见 [[file-as-memory]] 与 [[agentic-memory]] 的历史对照),仍缺直接对比数据;**Anthropic 官方加入索引陈旧论证**(来源: [[2026-05-14-claude-code-large-codebases]]):RAG embedding pipeline 追不上活跃团队,索引反映数小时/天/周前的代码且无过期提示——agentic 文件系统检索的规模优势论证
  - context rot 已获机制证据(注意力预算、n² 注意力)但量化曲线仍缺;compaction 调优是"先召回后精度"的经验规则
  - **compaction 跨会话局限**:Anthropic 明确"compaction 不总能向下一会话传递清晰指令",长时任务需要 harness 层(文件记忆 + 特征门禁)而非依赖压缩(见 [[long-running-agents]])
  - 单通用编码代理 vs 多专用代理(测试/QA/清理)对长时任务哪个更好——Anthropic 明言未定
  - **评估器成本与边界**:20 倍成本换来质量提升,但评估器价值随模型能力移动——任务在模型可靠 solo 能力内时是纯开销(Opus 4.6 后每 sprint 必评降为终评);"组件即假设"的简化原则:harness 组件会随模型换代过时,需逐组件重评
  - **自评与独立评审的差距**:两条独立证据(ChemCrow 2023、Anthropic Labs 2026)都显示代理自评系统性偏乐观——独立评审是必要环节但需专门调优(开箱即用的 QA 会"说服自己不严重"而放行)
  - 主观领域(设计/音乐品味)的评审盲区:"Claude 听不见"——评估器感知受模型输入模态限制
  - **harness 差距论**:同模型不同 harness 表现差异巨大(Terminal Bench 2.0:Opus 4.6 在 Claude Code 里得分低于定制 harness;只改 harness 把代理从 Top 30 提到 Top 5)——模型能力 vs 可见表现的差距大部分是 harness 差距;且模型与训练时 harness 共训练耦合,换 harness/改工具逻辑可能莫名回归
  - **MCP 供应链安全**:工具描述每请求进 prompt,安装的 MCP 服务器是模型会读的可信文本——马虎/恶意 MCP 可 prompt-inject 代理(尚无实例数据)
  - **harness 会过时**:上下文焦虑脚手架在 Opus 4.6 后成死代码——组件假设随模型换代失效,需定期重评(Anthropic 逐组件移除方法论)
  - **验证滞后于生成**:代理能写"技术上有效但漏关键用例"的测试;UI 验证脆弱;环境抖动在并行规模下系统化(40 代理撞同一 flaky 测试,工厂停摆);测试后写则测的是"实现恰好做的事"——测试先行的必要性在舰队规模下从好实践变为强制(红/绿 TDD)
  - **AI 评审工具的噪音面**:未配置的 AI 评审产生"文本噪音",需调灵敏度/关类型/定策略;审 AI 代码比审人代码更费力(OCaml 13k 行 PR 案例)
  - **人-代理接口扩大攻击面**:代理工具/IDE 的新攻击路径(prompt injection、数据外泄、RCE,二手);加 MCP 供应链风险,安全评审不可自动化
  - **认知投降 → 认知债机制链**(一手: [[2026-03-23-triple-debt-model]],引 Shaw & Nave 2026 SSRN 6097646——Wharton 数据出处确认):投降 = 最小审查采纳 AI 输出,不同于 offloading;投降即使故意也隐形累积、膨胀信心(即使 AI 错)——认知债隐形到太晚的机制解释
  - **"抵制理解的自动化" vs 文档委托**:Storey 警告用 AI 生成文档替代真理解 = 表面替代真实(使认知债更难检测)vs OpenAI 官方指南 Document 阶段(委托 AI 草稿文档+人评审)与 Osmani 实践(文档生成)——折中:委托草稿 + **人评审关键文档**仍是主流,但"自动生成即理解"的诱惑正是认知债的生成面(见 [[intent-debt]])
  - **理解力债务**:速度不对称使"被评审≠被理解"——几百次"代码看着没问题"的审查累积成隐形负债,任何测量(velocity/DORA/覆盖率)都捕获不到;Anthropic RCT(一手已核: [[2026-01-28-skill-formation-rct]])显示 AI 使用损害概念理解/代码阅读/调试且无平均效率增益,六种交互模式三种认知参与式保学习(65-86%),**agentic 场景损失可能更大**;测试的硬上限(无法为没想到的行为写测试;AI 更新几百条测试匹配行为时只有理解能回答"改动必要吗")
  - **Spec 的边界**:"详细到能完全描述程序的 spec ≈ 程序本身",两个工程师实现同一 spec 行为差异巨大——spec 是杠杆但不是替代理解
  - **认知投降**:人侧的机制级失败——"追认而非评审"(600 行 PR 扫一眼就批)、借用的信心(73% 接受错答案);所有验证对策最终依赖人执行,而投降正是"该执行验证时缺席决策"(见 [[cognitive-surrender]])
  - **人工评审必要性的阵营分裂**(需注意):OpenAI 实验"几乎所有审核转为智能体对智能体、人类可审但不必须、减少阻塞门、偶发失败重跑" vs Osmani/Anthropic 系"人类签字不可替代、评审是知识转移机制、人工审查是安全系统"——同一能力水平下的真实分歧,不是能力差距;决定因素疑似:团队规模/业务风险/代码库性质(内部 beta 工具 vs 生产系统)与知识转移需求(见 [[pr-contract]]);**第三方中间观察**(来源: [[2026-05-08-ai-native-organization]],二手):阿里内部"CR 和缺陷分析等高风险环节 AI 产出仍需打问号,人工审核又跟不上——不敢全信、人工又扛不住"——两边都真实存在,分歧在"哪个风险先爆";**厂商内部镜像**(来源: [[2026-08-02-building-ai-native-engineering-team]]):OpenAI 官方指南明确"工程师委派首轮评审给 agent 但 **own 最终评审与合并**"——官方对外建议站在人类签字侧,与自家内部实验(评审代理化)同公司两种声音;解读:对外建议保守(客户生产系统)、内部实验激进(零人工探索)——"建议给别人的 vs 自己敢做的"是阵营分歧的又一维度
  - **蒸馏焦虑的结构性反制**:知识藏匿会直接破坏 Harness 转型(激励与需求冲突);培养断裂(不招 day 1 → senior 池枯竭)是产业级负反馈——个人理性 vs 集体灾难,无现成解法(见 [[distillation-anxiety]])
  - **零人工代码的可复制性未知**:OpenAI 明言"不应在没有类似投入的情况下假定可以泛化";doc-gardening/黄金原则/规范架构是数年类基础设施,前期投入门槛高
  - **在线质量代理指标的局限**:Keep Rate/语义满意度测量"用户是否返工",不测量"理解"(comprehension-debt 的测量缺口仍存在);语义满意度用 LLM 评用户回应——与 [[llm-as-a-judge]] 同源的自评偏差风险
  - **agentfile 的有用性存疑**(一手已核: [[2026-02-12-evaluating-agents-md]]):ETH Zurich 研究(Gloaguen et al.,arXiv 2602.11988,发布 2026-02-12;SWE-bench Lite + AgentBench,四代理三条件)——LLM 生成的上下文文件损害性能(一手口径 **-0.5%/-2%**;转述"-3%"同量级差异待核)且推理成本 **+20% 以上**(一致 ✓);**机制:指令被遵循但充当不了仓库概览**;文档冗余假说(移除文档后 LLM 文件反而 +2.7%——价值 = 文档缺失替代品);结论:只应包含代码库之外的具体附加指令——与"AGENTS.md 是最高杠杆配置点"(Osmani/OpenAI 实践)形成张力;折中解释:文件内容质量与"短而精"才是关键,存在本身不是(论文结论与 Osmani 的 prompt-additive 原则意外一致);铁律:**绝不让代理直接写 AGENTS.md,lead 批准每一行**(论文支持:LLM 文件 < HUMAN 文件);张力待核:循环追加的"运行笔记本"(代理自己写的学习条目)vs ETH 反证——自动生成的内容质量是否同样受损(部分回答:LLM 文件与既有文档冗余——自动追加条目可能同样冗余,见 [[agents-md]])
  - **多代理协调的深层失败模式**:Cursor 规模化实验(外部引用待核)——共享文件锁使代理卡死/等待;换掉锁后代理**风险厌恶**(只做微小安全改动、无人负责难任务)——自由混战(无层级无责任制)是根因,锁只是表面;Planner-Worker-Judge 层级化是解(见 [[agent-teams]])
  - **反合理化表格的公开样例集已落地**:addyosmani/agent-skills(MIT)每个 skill 内置借口→反驳表——部分回答"公开样例集与采用数据"开放问题;采用/效果数据仍缺(见 [[anti-rationalization-tables]])
  - **skill/MCP 供应链**:恶意 skill 注册表(ClawHub 数百个)+ MCP prompt injection——配置面越大,供应链攻击面越大
  - **意图债测量与"承重标准"**:哪些 why 贵到必须记(选择标准无量化);ADR 采用率;意图债随代理规模增长的实证(每会话付费 × 代理数)——论文给出监控方向(onboarding 时间跟踪/知识集中度/需求覆盖分析/意图-行为差距定期审计,见 [[2026-03-23-triple-debt-model]])但无成熟工具(见 [[intent-debt]])

## 开放问题

- **编排税量化**:并行代理上限的标定(Osmani"个位低位数" vs 3-5 甜点区 vs Agent Teams 上限的具体数字);批量评审的批大小/节奏;编排税与意图税的重叠程度测量(来源: [[2026-05-24-orchestration-tax]],见 [[orchestration-tax]])
- **时间地平线外推验证**:7 个月翻倍趋势是否持续(1-4 doublings/年区间);Time Horizon 1.1(2026-01-29)方法论更新细节;>16 小时任务套件的扩展(来源: [[2025-03-19-measuring-ai-long-tasks]])
- "curse of instructions" 原始论文的适用范围:任务规模/指令数量到多少开始显著衰减?是否存在拐点数据
- GitHub 2,500+ agents.md 分析的六区域统计口径待核
- LLM-as-a-Judge 与自验证的共同盲区问题未解
- 过度规范的量化边界("spec 详细度 vs 任务复杂度")未定
- 五种工作流模式的选择依据:任务结构与模式匹配的量化标准(目前是经验规则)
- context rot 的量化曲线(Chroma 研究原文待核对);compaction 调优的实践数据
- memory tool(公开 beta)的进展与跨会话记忆的长期效果
- 工具命名空间前缀/后缀的模型差异、响应结构(JSON/XML/Markdown)选择——目前都靠自家评测,缺跨模型经验数据
- agentskills.io 开放标准的生态进展;代理自治创建/编辑/评测 skill 的落地情况
- Vercel skills 评测原文核实(56% 未调用);触发率问题的缓解实践(自动注入 vs 手动触发)
- NeurIPS"LLM 生成人格是带陷阱的承诺"论文原文
- 长程规划(LLM+P/PDDL 外包路线)的后续进展;NL 接口可靠性与格式解析的现状
- 好 spec 的合理长度与 token 预算:有没有经验值(如 5k vs 20k 的收益对比)?
- 单代理 + 摘要 TOC vs 多代理并行:对典型项目规模的实测成本/质量对比
- spec-driven 四阶段对大型存量代码库(非绿地)的适配:门禁流的变体实践
- 上下文填充的性能退化曲线:拐点与任务复杂度/长度的关系(官方文档仅定性表述)
- "单代理长会话 vs /clear 重开"的经验边界:什么时候该放弃已有上下文(官方只给了"两次纠错"经验值)
- [[agent-computer-interface|ACI]](Anthropic)与 AX(Osmani)两个"为代理设计"概念如何统一:工具接口设计与 spec 可消费性是同一件事的两面还是两层?
- 单代理 + 文件记忆(长时 harness)vs 多代理架构(测试/QA/清理专用代理):Anthropic 自认未定,缺对比实验
- 跨会话记忆载体对比数据:progress 文件 + git vs 向量库 vs 笔记,谁在什么任务上更稳(见 [[long-running-agents]])
- 评估器"能力边界"的操作化:怎么判断任务在模型可靠 solo 能力内/外(决定评估器值不值得上);sprint contract 谈判的自动化程度上限
- harness 组件的逐组件 A/B 数据:哪些组件承重、何时过时(Anthropic 只给了方法论,未公开逐组件数据)
- **harness 动态装配**("从静态配置到编译器"):按任务 JIT 组装工具与上下文的落地进展;代理自分析 trace 修 harness 级失败;共享代码库并行多代理编排(均为 Osmani 引 Viv 的开放问题)
- Terminal Bench 2.0 数据与 Top 30→Top 5 案例的原始出处核实;MCP 供应链攻击的实测案例
- **验证基础设施**(自动回归检测、工件级验证、快速环境供应、并行护栏)的行业进展——Osmani 指为未解投资
- 宏观指标核实(新网站 +40%、iOS 应用 +50%、代码推送 +35%,二手引述);"更多数量≠更好质量"的评估方法
- **评审量化数据核实**(PR +18%/事故 +24%/失败率 +30%/45% 安全缺陷/1.75×/2.74×,均为二手);PR Contract 在团队中的实际采用数据;"AI code auditor"角色落地形态
- **理解力测量**:现无任何工件捕获理解力债务(velocity/DORA/覆盖率全盲)——测量方法本身是开放问题;Anthropic RCT 一手已核(核心发现 ✓,52 人/-17% 精确口径待全文);<40%/>65% 与一手"65-86% 高分界"同量级吻合
- **人类技能形成**:被动委派 vs 主动提问式使用的边界;如何在工作流中设计"理解强制点"(评审/讲解/文档义务)
- **投降校准**:如何测量/训练"知道自己在 offloading 还是 surrender"的能力(个人启发式无量化);反合理化表格的公开样例集与采用数据;Wharton/MIT/arXiv 三篇原文核实
- **智能体对智能体评审 vs 人工签字**:阵营分歧的实证比较(内部 beta 工具 vs 生产系统的适用边界;OpenAI 自述数据核实)
  - **"有意减少阻塞门" vs "默认零评审"的界限**(来源: [[2026-06-15-agentic-code-review]]):OpenAI 有意设计的"减少阻塞门"与 Faros 的"零评审合并 +31.3%"(没人决定停止评审,量让人跟不上)表面同向、成因相反——一个是有意的契约重设计,一个是流程被动失守;证据缺口:如何区分"设计好的薄评审"与"悄悄崩溃的评审"(见 [[pr-contract]])
  - **agent ghost vs 偶发失败重跑**:arXiv 2601.15195(被拒 agent PR 38% 归因评审者弃审)与 OpenAI"偶发失败重跑即可"——同一行为(收到反馈即放弃/重跑)两种解读:研究视为质量信号,OpenAI 视为可吸收成本;折中:agent 弃审集中在"主观反馈"(擅长小而清,~28% 即时合并),把反馈做成确定性/结构化可重跑可避免大量弃审
- **零人工代码的可复制性**:环境/规范架构/清理回路的前期投入曲线;OpenAI 后续文章(自我改进税务智能体等)的印证
- **Keep Rate 的标定与采用**:固定间隔多长、与人工评审的相关性、跨团队可比性(开放问题);语义满意度评分的偏差研究
- **多智能体编排在框架层的落地**(Cursor 指为未来方向:规划/快速编辑/调试专用智能体委派);Auto-review 管控自主性的进展
- **ETH Zurich agentfile 研究核实**(arXiv 2602.11988)与"短而精"的量化边界;指令预算/愚蠢区的拐点数据
- **回压的上下文效率**:全量 vs 子集测试的收益曲线;"吞输出只浮错误"的普遍性(不同语言/框架)
- **协调原语演进**:Agent Teams(实验特性)的正式化与跨工具普及;共享任务列表/文件锁在多仓库规模的边界;层级子代理(teams of teams)的最优深度
- **Ralph Loop**:"3+ 卡死迭代"阈值的合理性;四通道记忆的失效模式(状态文件 vs git vs AGENTS.md 谁先腐);Beads(SQL 可寻址制度记忆)vs 向量 RAG 的对比数据;REFLECTION.md 采用率
- **2026 工具三层时效性**:Tier 2/3 工具的季度演进;"控制平面成为主界面"(Glass)对开发工作流的影响
- **编排开放问题**(来源: [[2026-01-02-future-agentic-coding]]):代理间协商/元数据交接标准(共享状态孤岛问题);AI 可观测性工具(成本/性能/准确度)落地;checkpoint/rollback 的可靠性;"信任模型"(何时介入 vs 信任代理计划)的操作化;90% 采用率与 10+ PR/天数据核实
- **管理侧开放问题**(来源: [[2026-01-08-coding-agents-manager]]):Agent HQ 正式发布与能力;delegate/review/own 在实践中的分布;PR packet 采用率;Cherny 头衔核实(创造者 vs 负责人)
- **术语与技能侧**(来源: [[2026-02-04-agentic-engineering]]):"可靠软件 vs 更快软件"的评估框架;skill atrophy 危机的量化研究(与 Anthropic RCT 的关系);Karpathy/Willison 原文核实
- **循环工程**:无监督循环的失败模式数据(token 失控/状态文件腐烂/triage 误过滤);`/goal` 停止条件被独立模型误判的边界;token 富/贫组织的循环成本模型;Steinberger/Cherny 推文核实(见 [[loop-engineering]])
- **意图债**:Triple Debt Model 原文核实(arXiv 2603.22106);"承重决策"选择标准的操作化;决策日志(ADR)采用数据;orchestration tax = 意图税 的实证拆分
- **组织层开放问题**(来源: [[2026-05-08-ai-native-organization]]):AI 信任度两难(高风险环节"不敢全信、人工又扛不住"的量化边界);绩效失效后新依据(artifact 可见 + recognition 主动)的建立;3-5 人小团队是临时最优还是终态(探索者效应/过渡期人形需求/审稿层价值三临时条件);**AI 知识资产继承**(员工调教好的 agent 人走时怎么办——无公司有方案,与 [[file-as-memory]] 相关);agent 名册与治理 6 项基本功的落地案例;蒸馏焦虑对 Harness 转型破坏的实证数据
- **企业规模层开放问题**(来源: [[2026-05-14-claude-code-large-codebases]]):配置评审 3-6 月节奏的量化验证(评审频率 × 模型换代率的收益曲线);LSP 部署收益数据;RAG vs agentic search 的适用边界(索引类工具在什么规模/场景仍占优);plugin 市场治理(谁批准/如何防重复建设)的行业案例;agent manager/DRI 角色在非 Anthropic 生态的普遍性
- **Terminal Bench #33 vs #5 的复现与解释**(过拟合 vs 陌生 harness 调优收益的机制)
