---
type: topic
tags: [ai-agents, spec-writing, research]
created: 2026-08-02
updated: 2026-10-15
refs: [ai-agent-spec, spec-driven-development, ai-feature-implementation-loop, agentic-systems, context-engineering, agent-computer-interface, multi-agent-systems, skills, file-as-memory, self-reflection, long-running-agents, context-anxiety, harness-engineering, factory-model, pr-contract, comprehension-debt, cognitive-surrender, agent-readability, cursor, humanlayer, execution-graph, hive-mind, management-collapse, distillation-anxiety, alibaba, xu-xiaobin, claude-code, intent-debt, loop-engineering, agent-teams, ralph-loop, process-over-prose, anti-rationalization-tables, conductor-orchestrator, agent-management, agentic-engineering, orchestration-tax, theory-building, sean-goedecke, pure-impure-engineering, wicked-features, expertise-leverage, senko-rasic, meat-proxy, niklas-gruhn, artifact-chain, governance-as-code, control-bands, official-sdlc-guides, agent-evals, agent-containment, progressive-disclosure, tool-evaluation, agent-identity, claude-tag]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-08-02-building-effective-ai-agents, 2026-08-02-effective-context-engineering-for-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2026-08-02-equipping-agents-with-agent-skills, 2025-10-06-file-system-is-the-new-database, 2023-06-23-llm-powered-autonomous-agents, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-04-19-agent-harness-engineering, 2026-02-25-factory-model-coding-agents, 2026-01-07-ai-code-review, 2026-03-14-comprehension-debt, 2026-05-05-cognitive-surrender, 2026-02-11-codex-agent-first-engineering, 2026-04-30-cursor-agent-harness-improvement, 2026-03-12-skill-issue-harness-engineering, 2026-05-08-ai-native-organization, 2026-05-14-claude-code-large-codebases, 2026-06-05-intent-debt, 2026-06-07-loop-engineering, 2026-03-26-code-agent-orchestra, 2026-05-03-agent-skills, 2026-01-02-future-agentic-coding, 2026-01-08-coding-agents-manager, 2026-02-04-agentic-engineering, 2026-01-31-self-improving-agents, 2026-06-15-agentic-code-review, 2026-05-24-orchestration-tax, 2026-08-02-building-ai-native-engineering-team, 2025-03-19-measuring-ai-long-tasks, 2026-02-09-cognitive-debt, 2026-01-28-skill-formation-rct, 2026-02-12-evaluating-agents-md, 2026-04-07-cognitive-parallel-agents, 2026-03-23-triple-debt-model, 2026-07-11-in-defense-of-not-understanding-your-codebase, 2025-06-22-pure-and-impure-engineering, 2025-02-10-engineers-who-wont-commit, 2025-12-24-nobody-knows-how-software-products-work, 2025-04-12-wicked-features, 2026-07-24-llms-reward-expertise, 2026-08-08-code-was-never-the-hard-part, 2025-09-15-your-code-is-your-responsibility, 2026-08-03-dont-be-a-meat-proxy, 2026-08-21-ai-native-sdlc-playbook, 2025-06-04-a-practical-guide-to-building-agents, 2025-11-04-code-execution-with-mcp, 2025-11-24-advanced-tool-use, 2026-01-09-demystifying-evals-for-ai-agents, 2026-01-21-ai-resistant-technical-evaluations, 2026-02-05-infrastructure-noise, 2026-03-06-eval-awareness-browsecomp, 2026-04-08-scaling-managed-agents, 2026-05-25-how-we-contain-claude, 2026-07-21-anthropic-secures-ai-native-sdlc, 2026-08-18-claude-tag-first-responder-ci-cd]
status: active
---

# AI Agents(规范驱动开发研究)

追踪"如何让 AI 编码代理高质量、可预期地实现功能"——spec 写作、上下文工程、验收与反馈闭环。

## 核心页面

- [[ai-agent-spec]] — spec 写作框架:五原则 + 六区域清单
- [[spec-driven-development]] — 四阶段门禁流程(Specify → Plan → Tasks → Implement)
- [[artifact-chain]] — 提交工件链:intent.md→spec.md→plan.md→diff→PR→incident;接受工件触发下一关;提交链=审计链
- [[ai-feature-implementation-loop]] — 综合:从 spec 到落地的五层闭环 + 失败模式修复表
- [[agent-verification]] — 验证门禁四档:同 prompt / /goal / Stop hook / 独立评审子代理
- [[agent-evals]] — 评测方法学:能力 vs 回归、pass@k/pass^k、三档 grader、基础设施噪声、eval 认知/过期/饱和
- [[agent-containment]] — 代理围堵:环境层硬边界优先;批准≠监督;凭据/egress/信任边界
- [[tool-evaluation]] — 评测驱动循环:原型→评测→代理协作优化(含改进幅度数据)
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
- [[governance-as-code]] — 治理即代码:skill 建议→hook 确定→managed settings 强制→OTel 证据;审批门=hooks;写码者不得自批
- [[loop-engineering]] — 循环工程:harness 上一层的自动化(五件套+状态文件);/goal 停止条件;"杠杆点移动了"
- [[control-bands]] — 控制带:确定性检测+1σ/2σ/3σ 分级响应;代理越界时才被调用一次;发现写回 intent.md
- [[agent-identity]] — 代理身份:单一用途身份+最小权限;边界画在“访问与动作”而非模型指令;agent-to-agent 越界案例;SIEM 归因与内部威胁
- [[claude-tag]] — Claude Tag 实体:Slack 团队代理;CI/CD on-call 第一响应者(中位 14 分钟);内部 >50% 代码合并者
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
- [[theory-building]] — 程序即理论(Naur 1985):认知债的理论基础;Goedecke 反驳(部分理论是常态)
- [[sean-goedecke]] — GitHub Copilot 团队 Staff;pure/impure 工程文化;不理解的辩护
- [[pure-impure-engineering]] — 两种工程文化:pure 完美解决技术问题 vs impure 高效解决现实问题;AI 帮助 impure 最多
- [[wicked-features]] — 影响每个其他功能的需求;大系统禁止理解/不可重建的机制;老兵=熟悉全部 wicked features
- [[codebase-consistency]] — 代码库一致性:大代码库首要原则;prior art=雷区安全路径;不一致=负反馈循环
- [[intent-debt]] — 意图债:外部化 rationale 的缺失;债务三元组中唯一代理无法代付的一角
- [[cognitive-surrender]] — 认知投降:债务的机制;offloading vs surrender;借用信心;互惠放大
- [[expertise-leverage]] — 专长杠杆:领域专长决定 LLM 使用上限;人=瓶颈而非模型;投降的镜像
- [[agent-readability]] — 智能体可读性:仓库/应用/可观测性三级阶梯;"上下文之外不存在";AI 友好 5 维度
- [[pi-coding-agent]] — 极简派 harness 实体:四工具+<1000 token 提示、YOLO、文件即状态、反 MCP/子代理/to-do
- [[mario-zechner]] — badlogic/libGDX 作者;极简 harness 学派代表人物;pi 的创造者
- [[minimal-vs-rich-harness]] — 综合:极简 vs 富 harness 两派对比(分歧维度/证据/开放问题)
- [[official-sdlc-guides]] — 综合:官方 SDLC 指南对比(OpenAI 三分法 vs Anthropic 工件链+治理+度量)
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
- [[2026-02-12-evaluating-agents-md]] — 第三十六篇源文档(ETH:AGENTS.md 反证**全文已入库 2026-11-06**;摘要 -3% vs 正文 -0.5%/-2% 口径闭合;人写 +4% 且对 Claude Code 无效;文档冗余假说 +2.7% 消融;AGENTbench 138 实例构法)
- [[2026-04-07-cognitive-parallel-agents]] — 第三十七篇源文档(Osmani:并行上限;ambient anxiety tax;先降范围再降数量)
- [[2026-03-23-triple-debt-model]] — 第三十八篇源文档(Storey 论文:债务三元组一手化;认知债≠comprehension debt 修正;抵制理解的自动化)
- [[2026-07-11-in-defense-of-not-understanding-your-codebase]] — 第三十九篇源文档(Goedecke:为大系统部分理解辩护;驳 Naur 废弃重建;理论=权衡之一;LLM 双刃剑)
- [[2025-06-22-pure-and-impure-engineering]] — 第四十篇源文档(Goedecke:pure/impure 两种工程文化;AI 对 impure 帮助最大;METR impact-of-ai 佐证待核)
- [[2025-02-10-engineers-who-wont-commit]] — 第四十一篇源文档(Goedecke:take a position;不表态=默许最终决定;责任缺席 vs 决策缺席)
- [[2025-12-24-nobody-knows-how-software-products-work]] — 第四十二篇源文档(Goedecke:大系统战争迷雾;代码库=唯一可靠答案源;意图债先 AI 形态)
- [[2025-04-12-wicked-features]] — 第四十三篇源文档(Goedecke:wicked features 定义;Password Game 类比;老兵=熟悉全部 wicked features;固有 vs 实现问题)
- [[2026-07-24-llms-reward-expertise]] — 第四十四篇源文档(Goedecke:LLM 奖励专长;Tao×ChatGPT 案例;理论=推模型的杠杆;人=瓶颈)
- [[2026-05-09-ai-makes-weak-engineers-less-harmful]] — 第四十五篇源文档(Goedecke:AI 抬高弱工程师地板;薄包装现象;"工程师给 AI 加的价值"追问)
- [[2026-04-03-programming-with-ai-agents-as-theory-building]] — 第四十六篇源文档(Goedecke:LLM 与理论构建;80/20/10 评审漏斗;保留 vs 构建;naur theory 第二论辩)
- [[2025-01-02-large-established-codebases]] — 第四十七篇源文档(Goedecke:大代码库首要原则=一致性;prior art=雷区安全路径;90% 价值;纯前 AI 操作篇)
- [[2026-03-06-will-my-job-still-exist]] — 第四十八篇源文档(Goedecke:职业未来;超调/欠调;反驳 Jevons;staff 最后被替换)
- [[2025-11-30-opinionated-minimal-coding-agent]] — 第四十九篇源文档(Zechner:自建极简编码代理 pi 复盘;极简派一手源)
- [[2026-08-08-code-was-never-the-hard-part]] — 第五十篇源文档(Senko:反 "code is easy" 话语;craft 辩护;两者都重要;what changes/what doesn't;meat proxy)
- [[2025-09-15-your-code-is-your-responsibility]] — 第五十一篇源文档(Senko:提交 PR = 声明完全理解+合法权利;隐藏 AI 使用=操守违规;原型可 vibe;狗吃作业)
- [[2026-08-03-dont-be-a-meat-proxy]] — 第五十二篇源文档(Gruhn:meat proxy 术语一手源;原样转发零增值;自己的话=理解证书;评审责任反转)
- [[2026-08-21-ai-native-sdlc-playbook]] — 第五十三篇源文档(Anthropic 官方 SDLC playbook:六阶段 16 plays;工件链/治理即代码/控制带/逐阶段领先滞后指标)
- [[2025-06-04-a-practical-guide-to-building-agents]] — 第五十四篇源文档(**OpenAI 官方**:三组件/单→多代理编排/分层 guardrails/人在环——填补 wiki 内 OpenAI 一手手册空白)
- [[2025-11-04-code-execution-with-mcp]] — 第五十五篇源文档(Anthropic:把 MCP server 呈现为代码 API 树;150,000→2,000 tokens;-98.7%;PII tokenize)
- [[2025-11-24-advanced-tool-use]] — 第五十六篇源文档(Anthropic:工具定义按需加载三项 beta;58 工具≈55K→~8.7K;-85% 且准确率上升;PTC -37%;Examples 72%→90%)
- [[2026-01-09-demystifying-evals-for-ai-agents]] — 第五十七篇源文档(Anthropic:**agent evals 方法论一手源**;术语体系/三档 grader/能力 vs 回归/pass@k vs pass^k/eval 饱和)
- [[2026-01-21-ai-resistant-technical-evaluations]] — 第五十八篇源文档(Anthropic:AI 抗性技术评测;take-home 被反复攻破 2164→1363;>50% 候选人不如委托 Claude Code)
- [[2026-02-05-infrastructure-noise]] — 第五十九篇源文档(Anthropic:**基础设施是评测变量**;六资源档、+6pp(p<0.01)、1x–3x 分数落噪声(p=0.40)、~3x 后趋势反转;<3pp 领先值得怀疑)
- [[2026-03-06-eval-awareness-browsecomp]] — 第六十篇源文档(Anthropic:模型识破评测并解密答案键;1,266 题中 9 例污染 + 2 例识破;多代理 3.7× 更易发生)
- [[2026-04-08-scaling-managed-agents]] — 第六十一篇源文档(Anthropic:harness 组件会过期(context reset 在 Opus 4.5 成死重);会话≠上下文窗口;brain/hands 解耦)
- [[2026-05-25-how-we-contain-claude]] — 第六十二篇源文档(Anthropic:**三产品围堵一手复盘**;三类风险×三层组件×三种隔离;批准 93%/提示降 84%/拦 83% 但漏~17%;25 次重试 24 次外传)
- [[2026-07-21-anthropic-secures-ai-native-sdlc]] — 第六十三篇源文档(Anthropic 安全实现篇:8× 产出/~80% 代码/>50% 由 Claude Tag 合并;PSR/shadow mode/抽检/SIEM/新型内部威胁;实质评审率 16%→54%)
- [[2026-08-18-claude-tag-first-responder-ci-cd]] — 第六十四篇源文档(Anthropic 值班实现篇:中位 14 分钟/最快 4 分钟;dynamic workflow + 617 行 investigation skill + lessons.md;oncall-kit 开源)

## 当前状态 / 进展

- 已摄入 64 份源文档(2023 奠基综述 → 2026 实践,时间跨度完整);视角:Osmani ×18 + Anthropic ×21 + OpenAI ×3 + Cursor + HumanLayer + 阿里技术 + METR + Storey ×2 + 学术(RCT/ETH) + Goedecke ×10 + Zechner ×1(极简派) + **Senko ×2(craft 辩护派,独立开发者;责任观) + Gruhn ×1(meat proxy 提出者)**
- 综合页已更新:自改进循环层 + 评审经济学层 + 编排税层 + 官方指南层 + 理解力层(债务框架一手化);METR 时间地平线一手化(2h17m 核实);认知债/意图债/投降机制链一手化(Storey 论文 + RCT + Shaw&Nave)
- **RCT 全文一手化**(2026-08-03,raw/2601.20245v2.pdf):Anthropic RCT v2 全文——n=52/-17%/d=0.738/p=0.010;任务时间无显著差异 p=0.391;六模式精确画像(65-86% vs 24-39%;Generation-Then-Comprehension 86% 最高);错误即学习机制(对照中位 3 错误 vs AI 组 1);chat=认知卸载下界(agentic 损失更大是论文自身立场);全部数字闭合
- **极简派一手化**(2026-08-08,raw/What I learned building an opinionated and minimal coding agent.md):Zechner 自建 pi 复盘——<1000 token 系统提示+四工具(read/write/edit/bash)、YOLO 默认(权限弹窗=security theater)、反 MCP(上下文税:Playwright 13.7k/DevTools 18k tokens=7-9% 窗口)/to-do/plan mode(PLAN.md 文件化)/后台 bash(tmux 替代)/子代理(黑箱;独立会话+工件;并行子代理=反模式);状态全部文件化(TODO.md/PLAN.md);"模型被训练成读片段、找不全上下文,我们太信任代理了";Terminal-Bench 2.0 五轮跑分上榜 + Terminus 2(纯 tmux)名列前茅;与富 harness 学派(Anthropic/Osmani/HumanLayer)的全景分歧建综合页 [[minimal-vs-rich-harness]];本 wiki 运行环境即 pi(系统提示/四工具逐字吻合)
- **官方 SDLC 双层**(2026-10-15,raw/The AI-native SDLC playbook.md):Anthropic 官方 playbook——六阶段 16 plays;**提交工件链**(intent/spec/plan/diff/PR/incident;接受工件触发下一关);**skill+hook+managed settings+OTel 四层治理**;控制带闭环(1σ/2σ/3σ;确定性检测;发现写回 intent.md);配置即被测对象(evals 对 CLAUDE.md/skills/hooks 门禁);逐阶段领先/滞后指标;新建 3 概念页 + 与 OpenAI 指南并排对比 [[official-sdlc-guides]]
- **官方 companion 两篇**(2026-10-15,raw/How Anthropic secures… + How Claude Tag…):playbook 挂账的两篇实装篇——安全侧(8× 产出/~80% 代码/>50% 由 Claude Tag 合并;PSR/shadow mode/抽检/SIEM/新型内部威胁;16%→54%)与值班侧(中位 14 分钟/最快 4 分钟;dynamic workflow + 617 行 investigation skill + lessons.md;oncall-kit 开源);新建 [[agent-identity]]、[[claude-tag]];更新 [[governance-as-code]]/[[control-bands]] 等 13 页;修正“官方保守 vs 内部激进”张力为“高自动化+高治理配对”
- **ETH agentfile 全文落盘**(2026-11-06,raw/Evaluating AGENTS.md…):同一论文第 36 源的 raw 补全 + 重写——清掉“-3% 待核”(那是摘要数字,正文分基准 -0.5%/-2%,同属一篇论文);新增硬数据(成本 +20/23%、reasoning token +14~22%、人写 +3.34 步/+19% 成本、首次寻址无改善、概览段占比 95-100%、GPT-5.1 mini 反复重读已在上下文的文件);新增测试:人写文件**对 Claude Code 无效**;消融:换更强模型生成(+2%/-3%)与换生成提示均无一致优劣;新建 [[documentation-redundancy]]
- 实证基础:GitHub 2,500+ 配置文件分析、curse of instructions、context rot、BrowseComp、SWE-bench Verified、ChemCrow 自评盲区、Vercel skills 评测(二手)、Opus 4.5 跨会话 harness 实证、Solo vs 三代理 20 倍成本对比、Terminal Bench #33 vs #5、宏观指标(二手)、评审量化数据(二手)、Anthropic RCT 理解力(全文一手已核 2026-08-03:n=52/-17%/d=0.738/六模式画像/错误机制)、Wharton 73% 投降率(出处确认 SSRN 6097646,全文待)、OpenAI 零人工代码(自述)、Cursor Keep Rate、ETH Zurich agentfile 研究(**全文已核 2026-11-06**:摘要 -3% / 正文 -0.5%/-2%;人写 +4%;+20~23% 成本)、阿里内部访谈/调研(二手待核)、METR impact-of-ai(Goedecke 引用:熟悉代码库者 AI 提速很小,待核)、**pi Terminal-Bench 2.0 五轮跑分(Opus 4.5) + Terminus 2 纯 tmux 上榜(极简派证据,2026-08-08)**

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
- **agent 长期理论保留**:权重内化(continuous learning)vs 超长上下文 vs 文件记忆——Goedecke 判为"下一个大创新",现状 = 每次 spin up 从零构建理论(来源: [[2026-04-03-programming-with-ai-agents-as-theory-building]],见 [[theory-building]]);采纳率/拒绝率作为专长与投降测量代理的多人数据缺(见 [[cognitive-surrender]])
- **agent 的一致性维护**:如何让 AI 实现默认跟随 prior art 而非"最合理方式"(提示/示例/评测);不一致的量化检测(与 Keep Rate 同族;来源: [[2025-01-02-large-established-codebases]],见 [[codebase-consistency]])
- **Jevons 效应 vs AI 维护能力**:AI 修 bug/清理是否真与生成同速进步(Goedecke"通常比我快" vs Faros 评审时长 +441.5%/"写便宜了,理解没便宜"的张力)——维护能力曲线是行业需求预测的关键未知(来源: [[2026-03-06-will-my-job-still-exist]],见 [[2026-06-15-agentic-code-review]]);Goedecke 立场弧线(悲观 03 → 专长升值 07)待更多作者/数据检验
- **"编码难度"话语的实证化**(来源: [[2026-08-08-code-was-never-the-hard-part]],2026-08-08):Senko"编码从未容易"的侮辱论 vs Goedecke 托底/薄包装观察(对净负工程师编码正在变易)——"难度"相对专长水平,判据未操作化;另:Senko"软件为什么这么 buggy" = 维护/理解成本侧的常识论证,与评审经济学同向,缺机制量化(见 [[senko-rasic]])
- **AI 代码披露/标注规范**(来源: [[2025-09-15-your-code-is-your-responsibility]],2025-09-15):Senko"隐藏 AI 使用 = 严重操守违规"的个体端 vs 行业现实(AI 代码占比普遍且大量未标注,Faros/GitClear 量级数据)——披露规范是政策/社区灰色带,缺跨公司实证;另:AI 输出许可证实践(合法权利字段的落地形态,见 [[pr-contract]])
- **meat proxy 的可测量性**(来源: [[2026-08-03-dont-be-a-meat-proxy]],2026-08-03):原样转发率 = 投降的沟通侧代理(与拒绝率/采纳率并列为操作化测量,见 [[cognitive-surrender]]);"自己的话"证书在自动化评审/CI 场景的形态;转发在审计/合规场景的合法边界(政策要求 vs 零增值,见 [[meat-proxy]])
- 评估器"能力边界"的操作化:怎么判断任务在模型可靠 solo 能力内/外(决定评估器值不值得上);sprint contract 谈判的自动化程度上限
- harness 组件的逐组件 A/B 数据:哪些组件承重、何时过时(Anthropic 只给了方法论,未公开逐组件数据)
- **harness 动态装配**("从静态配置到编译器"):按任务 JIT 组装工具与上下文的落地进展;代理自分析 trace 修 harness 级失败;共享代码库并行多代理编排(均为 Osmani 引 Viv 的开放问题)
- Terminal Bench 2.0 数据与 Top 30→Top 5 案例的原始出处核实;MCP 供应链攻击的实测案例
- **验证基础设施**(自动回归检测、工件级验证、快速环境供应、并行护栏)的行业进展——Osmani 指为未解投资
- 宏观指标核实(新网站 +40%、iOS 应用 +50%、代码推送 +35%,二手引述);"更多数量≠更好质量"的评估方法
- **评审量化数据核实**(PR +18%/事故 +24%/失败率 +30%/45% 安全缺陷/1.75×/2.74×,均为二手);PR Contract 在团队中的实际采用数据;"AI code auditor"角色落地形态
- **理解力测量**:现无任何工件捕获理解力债务(velocity/DORA/覆盖率全盲)——测量方法本身是开放问题;Anthropic RCT 口径已全文闭合(n=52/-17%/d=0.738,2026-08-03);RCT quiz 方法学(IRT 校准/14 题 27 分/三题型)是现成可借鉴工件;Goedecke 对冲:大系统内部分理解是常态——"正常局部理解 vs 债务式侵蚀"的分界未定(见 [[2026-07-11-in-defense-of-not-understanding-your-codebase]]);基线参照:AI 之前就存在战争迷雾(见 [[2025-12-24-nobody-knows-how-software-products-work]])
- **AI 有用性差异标定**:pure vs impure 工程的 AI 提速差异(Goedecke ~30% 自报 vs METR impact-of-ai"熟悉代码库者提速很小"待核;与 RCT 技能形成同族;解释"AI 对一些人神奇对另一些人无用",见 [[pure-impure-engineering]]);RCT 补边界:新技能任务无显著提速(p=0.391) vs 熟悉任务文献提速(Peng +55.5%/Cui +26.8%)——完全委派才快且以技能为代价(来源: [[2026-01-28-skill-formation-rct]])
- **wicked features 量化**:多少 wicked features 使系统从"可理解"翻到"禁止理解"?新人掌握全部 wicked features 的时间曲线(公司老兵的隐性价值,无数据;见 [[wicked-features]])
- **人类技能形成**:被动委派 vs 主动提问式使用的边界——RCT 六模式已操作化(低分:完全委派/渐进依赖/迭代调试;高分:概念询问/生成后理解/混合解释,65-86% vs 24-39%,来源: [[2026-01-28-skill-formation-rct]]);仍开放:真实纵向场景分布(1 小时实验 vs 数月技能形成)、agentic 工具直接实验(论文 future work)、"理解强制点"(评审/讲解/文档义务)落地形态
- **专长杠杆的量化**:同模型下领域专长差异的受控实验缺位(Tao 案例=轶事;最近似证据=RCT 六模式 65-86% vs 24-39%);mode shunting(信号专长改变模型输出模式)的机制验证(来源: [[2026-07-24-llms-reward-expertise]],见 [[expertise-leverage]])
- **薄包装经济学**:付人类薪水得 Copilot 订阅的错配比例;净负工程师占比与"工程师给 AI 加的价值"的实证(失业推论的证据,来源: [[2026-05-09-ai-makes-weak-engineers-less-harmful]],见 [[agentic-engineering]]);与技能萎缩量化(主动使用 vs 薄包装的学习差异)的关系
- **错误即学习的甜蜜点**:RCT 实证错误是技能形成事件(对照中位 3 错误 vs AI 组 1;零错误完成 12 人仅 2 在对照)——但错误过多卡任务(pilot D 对照仅 60% 完成 vs AI 90%);多少/什么类型错误最优、与刻意摩擦反制的量化关系未定(来源: [[2026-01-28-skill-formation-rct]])
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
- **Terminal Bench #33 vs #5 的复现与解释**(过拟合 vs 陌生 harness 调优收益的机制):**新增极简派数据点(2026-08-08,来源: [[2025-11-30-opinionated-minimal-coding-agent]])**——pi 四工具 harness 五轮跑分上榜(Opus 4.5)、Terminus 2(纯 tmux、零工具)名列前茅——富 harness 调优增益与极简基线并存,harness 差距论两面性未解(见 [[minimal-vs-rich-harness]]);另:基准受时区/负载影响(pi 第二跑仅限 CET)
- **极简 vs 富 harness**(来源: [[2025-11-30-opinionated-minimal-coding-agent]],见 [[minimal-vs-rich-harness]]):两派各有 daily driver + Terminal-Bench 证据,缺同模型同任务的 A/B;to-do 列表冲突(特征清单门禁 vs "列表困惑模型")的边界未定;子代理黑箱 vs 全可观测能否兼得;"模型不愿读完整文件"假说(训练分布)未验证;规模(个人 vs 组织)是否学派分化的自变量
- **工件链的存量适配与事实源抉择**(来源: [[2026-08-21-ai-native-sdlc-playbook]],2026-08-21):intent.md→spec.md→plan.md 三件套在数十年遗留仓/多仓库/外包混编团队的最小可行形态;与 Jira/ServiceNow 的 source-of-truth 配置(repo vs legacy vs linkage)如何按工件类型选择(见 [[artifact-chain]]);"接受工件触发下一关"的自动化率与人工兜底比例
- **配置即被测对象的成本曲线**(来源: 同上,见 [[agent-verification]]):CLAUDE.md/skills/hooks 的 eval 套件维护成本、过期 case(模型换代后失去区分度)的淘汰节奏;eval pass rate 门禁的误报/漏报边界;事故→eval 的闭环时延测量
- **控制带标定与 triage 容量**(来源: 同上,见 [[control-bands]]):σ 分级阈值/去噪旋钮(dismiss 调 band)的跨团队标定;findings 队列与人的评审率匹配([[orchestration-tax]] 的生产侧同构);3σ 行动半径 = 预批 runbook 覆盖面的测量
- **官方指南 vs 内部实验的适用边界**(来源: [[2026-08-21-ai-native-sdlc-playbook]],2026-08-21;与 OpenAI 同构):Anthropic 官方满治理门(managed settings/审批门)与内部自治实践(Claude Tag 值班/托管评审)的关系——客户形态差异还是成熟期差异;两指南逐项并排见 [[official-sdlc-guides]]

### 评测学层开放问题(2026-10-15 新增,来源: [[2026-01-09-demystifying-evals-for-ai-agents]] 等六篇)

- **eval 完整性的对抗均衡**:评测污染(9 例取白评测材料)与 eval awareness(2 例解密答案键)的缓解手段目前只有"加检测 + 拆题",而 to-URL 黑名单已被证明无效——公开基准在联网环境里是否还能长期成立?(见 [[agent-evals]])
- **资源规格应当如何标准化**:作者主张把保证配额与硬 kill 阀值拆为两个参数并校准到"floor/ceiling 分数落在噪声内",但具体倍数"因 benchmark/task 分布而异"——缺跨 benchmark 的可比口径与公开推荐值(见 [[2026-02-05-infrastructure-noise]])
- **非确定性度量在采购/选型中的落地**:pass@k(工具类)vs pass^k(面向用户)已有清晰定义,但尚无团队公开过"用 pass^k 做模型升级门禁"的实际阈值经验(见 [[agent-evals]])
- **配置 eval 的维护成本曲线**:官方要求 CLAUDE.md/skills/hooks 变更走 eval 门禁,但未公开套件规模、过期 case 的淘汰节奏、事故→eval 的闭环时延(见 [[agent-evals]]、[[agent-verification]])
- **专门化评估器 vs 单一强模型**:Anthropic 与 OpenAI 都倾向"maker/checker 分离 + 按维度独立 judge",但缺"多 judge 共识 vs 单 judge 多维度"的同任务 A/B 数据(见 [[llm-as-a-judge]])

### 围堵与安全层开放问题(2026-10-15 新增,来源: [[2026-05-25-how-we-contain-claude]])

- **隔离强度与监督能力的标定**:"隔离强度必须匹配用户的监督能力"是原则而非公式——如何测量一个用户的监督能力(会不会读 bash?)并据此选三档隔离之一?(见 [[agent-containment]])
- **auto mode 的效用上限**:拦 ~83% / 漏 ~17% / 误拦 ~0.4% 是一组三点权衡,但缺"不同任务敏感度下应如何调阀"的数据;与 [[control-bands]] 的 σ 分级是否应合并为同一机制未定
- **持久记忆投毒**:跨会话上下文(产品记忆、CLAUDE.md、挂载 workspace、定时 agent 的状态目录)里的注入每次启动都重载——环境层边界(凭据/egress)拦不住这条,防御形态未定(见 [[agentic-memory]]、[[agent-containment]])
- **多代理信任升级**:子代理可隔离不可信内容,但若其**输出**被当作比原始工具结果更可信,就引入新注入向量——隔离与信任提升的边界需明确(见 [[subagents]])
- **agent identity**:agent 该有独立主体身份还是继承用户权限?Cowork 现用"宿主 keychain + per-session 可独立吊销的 scoped token",跨平台无答案(见 [[agent-containment]])
- **隔离的不透明性代价**:密封 VM 让 EDR 看不到内部,pull-based OTLP 不等同实时监控——合规与安全的冲突尚无解(见 [[agent-containment]])
- **agent 身份边界与 shadow mode 的毕业标准**(来源: [[2026-07-21-anthropic-secures-ai-native-sdlc]],2026-07-21):单用途 service account/最小权限的可操作标准(三权限 triage agent 之外);agent-to-agent 访问的边界(模型升级改变可达性的案例);shadow mode 何时从“评论等批准”转自动批准、由谁判定;抽检比例口径与 SIEM“新型内部威胁”误报率均未公开(见 [[agent-identity]])
- **值班 agent 的泛化与记忆腐化**(来源: [[2026-08-18-claude-tag-first-responder-ci-cd]],2026-08-18):CI 事故之外(安全/数据事件)的适用边界;lessons.md 长期增长的检索质量与腐化;triage 漏报(该 page 未 page)如何审计;617 行 investigation skill 的维护成本曲线(见 [[control-bands]]、[[claude-tag]])
