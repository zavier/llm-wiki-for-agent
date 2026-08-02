---
type: topic
tags: [ai-agents, spec-writing, research]
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, spec-driven-development, ai-feature-implementation-loop, agentic-systems, context-engineering, agent-computer-interface, multi-agent-systems, skills, file-as-memory, self-reflection, long-running-agents, context-anxiety, harness-engineering, factory-model, pr-contract, comprehension-debt, cognitive-surrender, agent-readability, cursor, humanlayer, execution-graph, hive-mind, management-collapse, distillation-anxiety, alibaba, xu-xiaobin, claude-code, intent-debt, loop-engineering, agent-teams, ralph-loop, process-over-prose, anti-rationalization-tables, conductor-orchestrator, agent-management, agentic-engineering, orchestration-tax]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-08-02-building-effective-ai-agents, 2026-08-02-effective-context-engineering-for-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2026-08-02-equipping-agents-with-agent-skills, 2025-10-06-file-system-is-the-new-database, 2023-06-23-llm-powered-autonomous-agents, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-04-19-agent-harness-engineering, 2026-02-25-factory-model-coding-agents, 2026-01-07-ai-code-review, 2026-03-14-comprehension-debt, 2026-05-05-cognitive-surrender, 2026-02-11-codex-agent-first-engineering, 2026-04-30-cursor-agent-harness-improvement, 2026-03-12-skill-issue-harness-engineering, 2026-05-08-ai-native-organization, 2026-05-14-claude-code-large-codebases, 2026-06-05-intent-debt, 2026-06-07-loop-engineering, 2026-03-26-code-agent-orchestra, 2026-05-03-agent-skills, 2026-01-02-future-agentic-coding, 2026-01-08-coding-agents-manager, 2026-02-04-agentic-engineering, 2026-01-31-self-improving-agents, 2026-06-15-agentic-code-review, 2026-05-24-orchestration-tax]
status: active
---

# AI Agents(规范驱动开发研究)

追踪"如何让 AI 编码代理高质量、可预期地实现功能"——spec 写作、上下文工程、验收与反馈闭环。

## 核心页面

- [[ai-agent-spec]] — spec 写作框架:五原则 + 六区域清单
- [[spec-driven-development]] — 四阶段门禁流程(Specify → Plan → Tasks → Implement)
- [[ai-feature-implementation-loop]] — 综合:从 spec 到落地的五层闭环 + 失败模式修复表
- [[agent-verification]] — 验证门禁四档:同 prompt / /goal / Stop hook / 独立评审子代理
- [[claude-md]] — 持久上下文文件:取舍与剪枝规则
- [[context-engineering]] — 上下文切片、扩展 TOC、会话级管理
- [[conformance-testing]] — 验收的客观标准
- [[subagents]]、[[parallel-agents]] — 独立上下文与并行规模化
- [[plan-mode]] — 只读规划:先探索后规划再编码
- [[agentic-systems]] — workflows vs agents 架构分类;三原则;框架警告
- [[agentic-workflow-patterns]] — 五种工作流模式目录(chaining/routing/parallelization/orchestrator/evaluator-optimizer)
- [[agent-computer-interface]] — ACI:工具契约设计五原则;与 AX 同族
- [[tool-evaluation]] — 评测驱动循环:原型→评测→代理协作优化
- [[swe-bench]] — 编码代理基准(SWE-bench Verified)
- [[context-rot]] — 上下文腐烂:token 越多召回越差;注意力预算
- [[agentic-memory]] — 结构化笔记:窗口外持久化,跨会话记忆
- [[multi-agent-systems]] — 多代理:收益/代价量化、委派教法、生产工程
- [[progressive-disclosure]] — 渐进式披露:元数据预载、细节按需加载(三源印证)
- [[file-as-memory]] — 文件系统即记忆:格式-功能映射、追加式安全、情景记忆
- [[self-reflection]] — 自反思技术谱系:ReAct/Reflexion/CoH/AD
- [[long-running-agents]] — 跨会话 harness:初始器/编码双代理、特征清单门禁、会话仪式
- [[context-anxiety]] — 上下文焦虑:接近以为的上下文极限时提前收尾;reset vs compaction
- [[harness-engineering]] — harness 工程:Agent = Model + Harness;棘轮原则、行为驱动设计、HaaS
- [[loop-engineering]] — 循环工程:harness 上一层的自动化(五件套+状态文件);/goal 停止条件;"杠杆点移动了"
- [[agent-teams]] — 代理团队:共享任务列表+依赖跟踪+文件锁+对等消息;@reviewer 队友;3-5 甜点区
- [[ralph-loop]] — Ralph 循环:stateless-but-iterative 六步;四通道记忆+AGENTS.md 手册;止损监控;"shipping while you sleep"
- [[process-over-prose]] — 过程胜过散文:工作流+检查点+退出标准 vs 参考散文;SDLC 六阶段;五条不可妥协
- [[anti-rationalization-tables]] — 反合理化表格:借口→反驳预写;对代理还没说的谎言的回应;团队实践
- [[conductor-orchestrator]] — 指挥 vs 编排:人机协作角色光谱(五轴对比);前载+后载人力模型;编排六大挑战
- [[orchestration-tax]] — 编排税:启动便宜闭环贵;你是代理们的 GIL;按评审率缩放舰队
- [[agent-management]] — 代理管理:管理技能迁移(brief 七字段/委派三档/PR packet/异步查岗/六步操作系统)
- [[agentic-engineering]] — 纪律化 AI 开发正名:AI 做实现、人拥有架构/质量/正确性;测试是可靠化机制
- [[factory-model]] — 工厂心智模型:建生产软件的工厂;spec 即杠杆、验证是瓶颈
- [[pr-contract]] — PR 契约:作者对评审者的证据义务(意图/证据/风险/评审重点)
- [[comprehension-debt]] — 理解力债务:代码量 vs 人类理解量的差距;测试/spec 的边界
- [[intent-debt]] — 意图债:外部化 rationale 的缺失;债务三元组中唯一代理无法代付的一角
- [[cognitive-surrender]] — 认知投降:债务的机制;offloading vs surrender;借用信心;互惠放大
- [[agent-readability]] — 智能体可读性:仓库/应用/可观测性三级阶梯;"上下文之外不存在";AI 友好 5 维度
- [[execution-graph]] — 组织范式:org chart → execution graph;routing+governance;Platform 三柱;agent 名册
- [[hive-mind]] — 上层协作文化:双层结构(Harness 层 + Hive Mind 层);death of ego 的边界;三类工作三种治理
- [[management-collapse]] — 管理塌缩非消失:10 件事命运分化;Architect 最高杠杆点;绩效失效
- [[distillation-anxiety]] — 蒸馏焦虑:知识导出的替代恐惧;培养断裂;行业负反馈环
- [[2026-01-13-good-spec-for-ai-agents]] — 首篇源文档(Addy Osmani)
- [[2026-08-02-best-practices-claude-code]] — 第二篇源文档(Anthropic 官方 Claude Code 最佳实践)
- [[2026-08-02-building-effective-ai-agents]] — 第三篇源文档(Anthropic 工程博客:agentic systems 分类学)
- [[2026-08-02-effective-context-engineering-for-ai-agents]] — 第四篇源文档(Anthropic:context engineering 领域定义)
- [[2025-09-11-writing-effective-tools-for-ai-agents]] — 第五篇源文档(Anthropic:ACI 实战手册与工具评测)
- [[2026-08-02-how-we-built-our-multi-agent-research-system]] — 第六篇源文档(Anthropic:多代理系统实战复盘)
- [[2026-08-02-equipping-agents-with-agent-skills]] — 第七篇源文档(Anthropic:Agent Skills 官方定义与三级披露)
- [[2025-10-06-file-system-is-the-new-database]] — 第八篇源文档(独立视角:文件即数据库的个人 OS)
- [[2023-06-23-llm-powered-autonomous-agents]] — 第九篇源文档(奠基综述:三组件框架,2023)
- [[2026-08-02-effective-harnesses-for-long-running-agents]] — 第十篇源文档(Anthropic:长时运行代理 harness;跨会话记忆)
- [[2026-08-02-harness-design-for-long-running-apps]] — 第十一篇源文档(Anthropic Labs:GAN 式 generator-evaluator 三代理架构;上下文焦虑)
- [[2026-04-19-agent-harness-engineering]] — 第十二篇源文档(Osmani:harness 工程学科化;Terminal Bench 证据;棘轮原则)
- [[2026-02-25-factory-model-coding-agents]] — 第十三篇源文档(Osmani:工厂心智模型;软件第三纪元;验证是未解问题)
- [[2026-01-07-ai-code-review]] — 第十四篇源文档(Osmani:AI 时代代码评审;PR Contract;验证量化数据)
- [[2026-03-14-comprehension-debt]] — 第十五篇源文档(Osmani:理解力债务;Anthropic RCT;测试/spec 边界)
- [[2026-05-05-cognitive-surrender]] — 第十六篇源文档(Osmani:认知投降;Wharton 数据;互惠放大)
- [[2026-02-11-codex-agent-first-engineering]] — 第十七篇源文档(OpenAI:零人工代码实验;智能体可读性;智能体对智能体评审)
- [[2026-04-30-cursor-agent-harness-improvement]] — 第十八篇源文档(Cursor:Keep Rate 在线评测;按模型定制;上下文焦虑第三次报告)
- [[2026-03-12-skill-issue-harness-engineering]] — 第十九篇源文档(HumanLayer:skill issue 框架出处;ETH Zurich 反证;回压)
- [[2026-05-08-ai-native-organization]] — 第二十篇源文档(阿里技术:AI Native 组织;Execution Graph;蒸馏焦虑;首个中文原创源)
- [[2026-05-14-claude-code-large-codebases]] — 第二十一篇源文档(Anthropic 官方:Claude Code at scale 系列首篇;agentic vs RAG;配置评审 3-6 月)
- [[2026-06-05-intent-debt]] — 第二十二篇源文档(Osmani:意图债;Triple Debt Model;债务三部曲完成篇;raw clip 不完整已自 URL 补全)
- [[2026-06-07-loop-engineering]] — 第二十三篇源文档(Osmani:循环工程;五件套+记忆;Steinberger/Cherny 二手引证)
- [[2026-03-26-code-agent-orchestra]] — 第二十四篇源文档(Osmani 演讲:多代理编排;Agent Teams;Ralph Loop 形式化;ETH 精确数字)
- [[2026-05-03-agent-skills]] — 第二十五篇源文档(Osmani:agent-skills 开源 27K stars;过程胜过散文;反合理化表格;Google DNA)
- [[2026-01-02-future-agentic-coding]] — 第二十六篇源文档(Osmani:conductor/orchestrator 分类学原始定义;编排六大挑战)
- [[2026-01-08-coding-agents-manager]] — 第二十七篇源文档(Osmani:管理技能迁移;delegate/review/own;PR packet;六步操作系统)
- [[2026-02-04-agentic-engineering]] — 第二十八篇源文档(Osmani:vibe coding 行李箱词;agentic engineering 正名;技能差距)
- [[2026-01-31-self-improving-agents]] — 第二十九篇源文档(Osmani:Ralph Loop 实操大全;四通道记忆;监控止损;风险管理)
- [[2026-06-15-agentic-code-review]] — 第三十篇源文档(Osmani:Agentic Code Review;四数据集;评审器异质性 93.4%;human on the loop)
- [[2026-05-24-orchestration-tax]] — 第三十一篇源文档(Osmani:编排税定名;GIL/Amdahl;注意力架构五实践)
- [[2026-08-02-building-ai-native-engineering-team]] — 第三十二篇源文档(OpenAI 官方:SDLC 六阶段三分法;METR 2h17m;官方立场 vs 内部实验张力)
- [[2025-03-19-measuring-ai-long-tasks]] — 第三十三篇源文档(METR:时间地平线度量;7 个月翻倍;Opus 4.6 ~16h;2h17m 一手源)
- [[2026-02-09-cognitive-debt]] — 第三十四篇源文档(Storey:认知债一手源;Naur 理论;Brooks 回声)
- [[2026-01-28-skill-formation-rct]] — 第三十五篇源文档(Anthropic RCT:AI 损害技能形成;六交互模式;agentic 损失更大)
- [[2026-02-12-evaluating-agents-md]] — 第三十六篇源文档(ETH:AGENTS.md 反证一手化;-0.5%/-2% 口径;文档冗余假说)
- [[2026-04-07-cognitive-parallel-agents]] — 第三十七篇源文档(Osmani:并行上限;ambient anxiety tax;先降范围再降数量)
- [[2026-03-23-triple-debt-model]] — 第三十八篇源文档(Storey 论文:债务三元组一手化;认知债≠comprehension debt 修正;抵制理解的自动化)

## 当前状态 / 进展

- 已摄入 38 份源文档(2023 奠基综述 → 2026 实践,时间跨度完整);视角:Osmani ×18 + Anthropic ×10 + OpenAI ×2 + Cursor + HumanLayer + 阿里技术 + METR + Storey ×2 + 学术(RCT/ETH)
- 综合页已更新:自改进循环层 + 评审经济学层 + 编排税层 + 官方指南层 + 理解力层(债务框架一手化);METR 时间地平线一手化(2h17m 核实);认知债/意图债/投降机制链一手化(Storey 论文 + RCT + Shaw&Nave)
- 实证基础:GitHub 2,500+ 配置文件分析、curse of instructions、context rot、BrowseComp、SWE-bench Verified、ChemCrow 自评盲区、Vercel skills 评测(二手)、Opus 4.5 跨会话 harness 实证、Solo vs 三代理 20 倍成本对比、Terminal Bench #33 vs #5、宏观指标(二手)、评审量化数据(二手)、Anthropic RCT 理解力(一手已核;-17% 精确口径待全文)、Wharton 73% 投降率(出处确认 SSRN 6097646,全文待)、OpenAI 零人工代码(自述)、Cursor Keep Rate、ETH Zurich agentfile 研究(一手已核:-0.5%/-2%)、阿里内部访谈/调研(二手待核)

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
