# Wiki Index

全 wiki 目录。LLM 每次操作后更新;查询时先读这里再深入。
每行格式:`wikilink + 一句话摘要`(如 `espresso-extraction — 意式浓缩萃取过程`)。`_examples/` 与 `_templates/` 不列入。

## Entities

- [[addy-osmani]] — Chrome 团队工程经理;AI-assisted engineering 作者;AI 代理 spec 框架提出者
- [[openai]] — GPT/Codex/Aardvark;零人工代码实验;智能体对智能体评审阵营
- [[anthropic]] — Claude/Claude Code 背后公司;agentic systems 分类学、CLAUDE.md/hooks/skills/子代理扩展体系
- [[cursor]] — Anysphere 的 AI 编码 IDE/智能体;CursorBench、Keep Rate、按模型定制框架
- [[claude-code]] — Anthropic 的代理式编码环境;上下文约束、扩展体系、并行会话、企业规模模式
- [[github]] — agents.md 2,500+ 配置研究 + Spec Kit + Copilot agents.md
- [[simon-willison]] — AI 工程评论家;一致性测试、致命三要素、AI 代理管理思想
- [[sean-goedecke]] — GitHub Copilot 团队 Staff 工程师;pure/impure 工程文化;不理解的辩护;LLM 奖励专长;弱工程师无害化;LLM 与理论构建;大代码库一致性;职业未来(超调/欠调)
- [[swe-bench]] — 编码代理基准:基于真实 GitHub issue;SWE-bench Verified
- [[muratcan-koylan]] — Sully.ai Context Engineer;文件即数据库个人 OS;独立实践者视角
- [[mario-zechner]] — badlogic/libGDX 作者;自建极简编码代理 pi;极简 harness 学派代表人物
- [[senko-rasic]] — 克罗地亚资深开发者;blog.senko.net;反 "code is easy" 话语;craft 辩护;判断/品味不外包
- [[niklas-gruhn]] — gruhn.me 博客作者;meat proxy 术语提出者(2026-08-03)
- [[pi-coding-agent]] — Zechner 的极简编码代理:四工具+<1000 token 提示;YOLO;反 MCP/子代理/to-do;Terminal-Bench 上榜;本 wiki 运行环境

## Concepts

- [[agent-computer-interface]] — ACI:工具契约设计五原则;评测驱动;与 AX 同族;输出双通道/流式 UX
- [[agent-verification]] — 给代理可运行的检查;验证门禁四档(同 prompt//goal/hook/评审子代理)
- [[agentic-memory]] — 结构化笔记:窗口外持久化,跨会话记忆(Pokémon 例证)
- [[agentic-systems]] — workflows vs agents 架构分类;三原则(简单/透明/ACI)
- [[agentic-workflow-patterns]] — 五种工作流模式:chaining/routing/parallelization/orchestrator/evaluator-optimizer
- [[agents-md]] — 仓库内代理配置文件,定义行为与专职人格
- [[ai-agent-spec]] — AI 代理 spec 总框架:五原则 + 六大核心区域清单
- [[claude-md]] — Claude Code 持久上下文文件;取舍与剪枝规则
- [[cognitive-surrender]] — 认知投降:offloading vs surrender;借用信心(73%);互惠放大
- [[meat-proxy]] — 肉代理:原样转发 AI 输出;投降的沟通侧形态;自己的话=理解证书
- [[expertise-leverage]] — 专长杠杆:领域专长决定 LLM 使用上限;人=瓶颈而非模型;投降的镜像
- [[agent-readability]] — 智能体可读性:仓库/应用/可观测性三级阶梯;"上下文之外不存在"
- [[distillation-anxiety]] — 蒸馏焦虑:知识导出的替代恐惧;培养断裂;行业负反馈环
- [[execution-graph]] — 组织范式:org chart → execution graph;routing+governance;Platform 三柱
- [[hive-mind]] — 上层协作文化:双层结构(Harness 层 + Hive Mind 层);death of ego 边界
- [[management-collapse]] — 管理塌缩非消失:10 件事分化;Architect 最高杠杆;绩效失效
- [[intent-debt]] — 意图债:外部化 rationale 的缺失;唯一代理无法代付的债务
- [[loop-engineering]] — 循环工程:harness 上一层自动化(五件套+记忆);/goal 停止条件;maker/checker 分裂
- [[agent-teams]] — 代理团队:共享任务列表+依赖跟踪+文件锁+对等消息;计划审批;@reviewer 队友
- [[ralph-loop]] — Ralph 循环:Pick→Implement→Validate→Commit→Reset;stateless-but-iterative
- [[process-over-prose]] — 过程胜过散文:工作流+检查点+退出标准;SDLC 六阶段;五条不可妥协
- [[anti-rationalization-tables]] — 反合理化表格:借口→反驳预写;对代理还没说的谎言的回应
- [[conductor-orchestrator]] — 指挥 vs 编排:角色光谱五轴对比;ephemeral vs git 痕迹;前载+后载人力
- [[orchestration-tax]] — 编排税:启动便宜闭环贵;你是代理们的 GIL;按评审率缩放舰队
- [[agent-management]] — 代理管理:管理技能迁移(brief 七字段/delegate-review-own/PR packet/异步查岗)
- [[agentic-engineering]] — 纪律化 AI 开发:AI 实现+人拥有架构/质量/正确性;测试=可靠化;技能差距
- [[comprehension-debt]] — 理解力债务:代码量 vs 人类理解量的差距;测试/spec 的边界
- [[theory-building]] — 程序即理论(Naur 1985);认知债理论基础;Goedecke 反驳
- [[pure-impure-engineering]] — 两种工程文化:pure 完美解决技术问题 vs impure 高效解决现实问题;AI 帮助 impure 最多
- [[wicked-features]] — 影响每个其他功能的需求;大系统禁止理解/不可重建的机制
- [[codebase-consistency]] — 代码库一致性:prior art=雷区安全路径;不一致=首要错误;90% 价值
- [[conformance-testing]] — 语言无关的一致性契约测试,源自 spec 的验收标准
- [[context-anxiety]] — 上下文焦虑:接近以为的上下文极限时提前收尾;reset vs compaction
- [[context-engineering]] — 上下文管理:注意力预算、JIT 检索、compaction/笔记/子代理;完全控制论(pi)
- [[context-rot]] — 上下文腐烂:token 越多召回越差;注意力预算是有限资源
- [[curse-of-instructions]] — 指令诅咒:指令越多模型遵循越差
- [[lethal-trifecta]] — 致命三要素:速度 / 非确定性 / 成本
- [[humanlayer]] — 人类审批基础设施公司;"skill issue"框架;12-factor agents;回压
- [[lilian-weng]] — OpenAI 研究员、Lil'Log;LLM 代理三组件框架奠基综述作者
- [[alibaba]] — 阿里技术公众号;AI Native 组织实践(内部访谈/调研数据,二手待核)
- [[xu-xiaobin]] — 阿里技术作者;AI Native 组织设计视角;Execution Graph/蒸馏焦虑传播者
- [[harness-engineering]] — harness 工程:Agent = Model + Harness;棘轮原则、行为驱动设计、HaaS;极简派(pi/Terminus 2)
- [[llm-as-a-judge]] — 用第二个 LLM 评审主观质量;evaluator-optimizer 循环形态;ChemCrow 自评盲区反证
- [[long-running-agents]] — 跨会话 harness:初始器/编码双代理、特征清单 passes 门禁、会话仪式;to-do 张力(pi 文件化)
- [[model-context-protocol]] — MCP:模型↔外部工具/数据的标准连接协议;上下文税反论(pi)
- [[multi-agent-systems]] — 多代理协作:收益/代价量化(90.2%、4-15× token)、生产工程
- [[parallel-agents]] — 并行代理会话:sectioning/voting、Writer/Reviewer、fan-out;并行子代理=反模式(pi)
- [[plan-mode]] — 只读规划模式:先探索后规划再编码;小任务跳过;PLAN.md 文件化反论(pi)
- [[pr-contract]] — PR 契约:作者对评审者的证据义务(意图/证据/风险/评审重点)
- [[progressive-disclosure]] — 渐进式披露:元数据预载、细节按需加载(skills/JIT/扩展 TOC 三源印证 + 56% 未触发反证 + CLI-README 形态)
- [[skills]] — SKILL.md 按需加载的领域知识与工作流;自动/手动双模式;2025-12 开放标准
- [[self-reflection]] — 自反思技术谱系:ReAct/Reflexion/CoH/AD
- [[spec-driven-development]] — 四阶段门禁流:Specify → Plan → Tasks → Implement
- [[subagents]] — 独立上下文的专职子代理:调查/验证/对抗性评审/多代理委派;黑箱批判与独立会话替代(pi)
- [[three-tier-boundaries]] — 三层边界:Always / Ask first / Never
- [[tool-evaluation]] — 评测驱动的工具开发循环:原型→评测→代理协作优化
- [[vibe-coding]] — 直觉快速编码;与 AI-assisted engineering 的纪律对照
- [[factory-model]] — 工厂心智模型:建生产软件的工厂;spec 即杠杆、验证是瓶颈
- [[file-as-memory]] — 文件系统即记忆:格式-功能映射、追加式安全、情景记忆

## Sources

- [[2026-01-13-good-spec-for-ai-agents]] — Addy Osmani 的 AI 代理 spec 写作指南(五原则 + 反模式)
- [[2026-08-02-best-practices-claude-code]] — Anthropic 官方 Claude Code 最佳实践(验证闭环、上下文管理、并行规模化)
- [[2026-08-02-building-effective-ai-agents]] — Anthropic 工程博客:agentic systems 分类与五种工作流模式
- [[2026-08-02-effective-context-engineering-for-ai-agents]] — Anthropic:context engineering 领域定义(context rot、JIT 检索、长时任务三技术)
- [[2025-09-11-writing-effective-tools-for-ai-agents]] — Anthropic:ACI 实战手册(工具设计五原则 + 评测循环)
- [[2026-08-02-how-we-built-our-multi-agent-research-system]] — Anthropic:Claude Research 多代理系统实战复盘(+90.2%、token 经济学、评测实践)
- [[2026-08-02-equipping-agents-with-agent-skills]] — Anthropic:Agent Skills 定义(三级渐进披露、代码执行、开放标准)
- [[2025-10-06-file-system-is-the-new-database]] — 独立视角:文件即数据库的个人 OS(格式映射、情景记忆、56% 未触发反证)
- [[2023-06-23-llm-powered-autonomous-agents]] — Lilian Weng 奠基综述:三组件框架、反思谱系、向量记忆、ChemCrow 自评盲区
- [[2026-08-02-effective-harnesses-for-long-running-agents]] — Anthropic:长时运行代理 harness(跨会话记忆、特征清单、浏览器自动化测试)
- [[2026-08-02-harness-design-for-long-running-apps]] — Anthropic Labs:GAN 式 generator-evaluator 三代理;上下文焦虑;harness 简化原则
- [[2026-04-19-agent-harness-engineering]] — Osmani:harness 工程学科化(等式/棘轮/HaaS);Terminal Bench 证据;MCP 供应链风险
- [[2026-02-25-factory-model-coding-agents]] — Osmani:工厂心智模型;三代工具;spec 即杠杆;验证是未解问题
- [[2026-01-07-ai-code-review]] — Osmani:AI 时代代码评审;PR Contract;验证量化(45% 安全缺陷等,二手)
- [[2026-03-14-comprehension-debt]] — Osmani:理解力债务;Anthropic RCT(-17%,待核);测试/spec 非完整答案
- [[2026-05-05-cognitive-surrender]] — Osmani:认知投降;Wharton 数据(73%,待核);反合理化表格;互惠放大
- [[2026-02-11-codex-agent-first-engineering]] — OpenAI:零人工代码实验(100 万行/1500 PR);AGENTS.md 四败因;智能体对智能体评审
- [[2026-04-30-cursor-agent-harness-improvement]] — Cursor:Keep Rate 在线评测;按模型定制工具格式;上下文焦虑第三报
- [[2026-03-12-skill-issue-harness-engineering]] — HumanLayer:skill issue 出处;ETH Zurich agentfile 反证;回压体系
- [[2026-05-08-ai-native-organization]] — 阿里技术:AI Native 组织(Execution Graph/管理塌缩/蒸馏焦虑);首个中文原创源
- [[2026-05-14-claude-code-large-codebases]] — Anthropic 官方:Claude Code at scale 首篇(agentic vs RAG 检索;LSP;配置评审 3-6 月)
- [[2026-06-05-intent-debt]] — Osmani:意图债(债务三部曲完成篇;Triple Debt Model;raw clip 不完整已补全)
- [[2026-06-07-loop-engineering]] — Osmani:循环工程(五件套+记忆;/goal;/loop;Steinberger/Cherny 引证)
- [[2026-03-26-code-agent-orchestra]] — Osmani 演讲:多代理编排全景(Agent Teams/Ralph Loop/工具三层/ETH 精确数字)
- [[2026-05-03-agent-skills]] — Osmani:agent-skills 开源(过程胜过散文/反合理化表格/Google DNA/五条不可妥协)
- [[2026-01-02-future-agentic-coding]] — Osmani:conductor/orchestrator 分类学原始定义(五轴对比/六大挑战)
- [[2026-01-08-coding-agents-manager]] — Osmani:管理技能迁移(delegate/review/own/PR packet/六步操作系统)
- [[2026-02-04-agentic-engineering]] — Osmani:vibe coding 行李箱词;agentic engineering 正名(术语谱系/技能差距)
- [[2026-01-31-self-improving-agents]] — Osmani:Ralph Loop 实操大全(六步/四通道记忆/监控止损/风险护栏)
- [[2026-06-15-agentic-code-review]] — Osmani:Agentic Code Review 全面版(四数据集/评审器异质性/human on the loop/分层评审)
- [[2026-05-24-orchestration-tax]] — Osmani:编排税定名(GIL/Amdahl/回压/注意力架构五实践)
- [[2026-08-02-building-ai-native-engineering-team]] — OpenAI 官方指南:SDLC 六阶段三分法/METR 2h17m/官方立场 vs 内部实验张力(发布日待核)
- [[2025-03-19-measuring-ai-long-tasks]] — METR:时间地平线(任务长度=能力);7 个月翻倍;GPT-2 4 秒 → Opus 4.6 ~16h
- [[2026-02-09-cognitive-debt]] — Storey:认知债一手源(Naur 程序理论;Brooks 回声;缓解实践)
- [[2026-01-28-skill-formation-rct]] — Anthropic RCT:AI 损害技能形成(六交互模式 65-86%;agentic 损失更大)
- [[2026-02-12-evaluating-agents-md]] — ETH Zurich:AGENTS.md 反证一手化(-0.5%/-2%;+20% 成本;文档冗余假说)
- [[2026-04-07-cognitive-parallel-agents]] — Osmani:并行代理上限(监督吞吐≠理解吞吐;ambient anxiety tax)
- [[2026-03-23-triple-debt-model]] — Storey 论文:债务三元组一手化(三层系统健康/三债循环/抵制理解自动化)
- [[2026-07-11-in-defense-of-not-understanding-your-codebase]] — Goedecke:为大系统部分理解辩护;驳 Naur 废弃重建;LLM 双刃剑
- [[2026-07-24-llms-reward-expertise]] — Goedecke:LLM 奖励专长;Tao×ChatGPT 案例;理论=推模型的杠杆;人=瓶颈
- [[2026-05-09-ai-makes-weak-engineers-less-harmful]] — Goedecke:AI 抬高弱工程师地板;薄包装现象;价值追问
- [[2026-04-03-programming-with-ai-agents-as-theory-building]] — Goedecke:LLM 与理论构建;80/20/10 评审漏斗;保留>构建
- [[2026-03-06-will-my-job-still-exist]] — Goedecke:职业未来;超调/欠调;反驳 Jevons;staff 最后被替换
- [[2025-01-02-large-established-codebases]] — Goedecke:大代码库首要原则=一致性;90% 价值;纯前 AI 操作篇
- [[2025-06-22-pure-and-impure-engineering]] — Goedecke:pure/impure 两种工程文化;AI 对 impure 帮助最大;METR 佐证待核
- [[2025-02-10-engineers-who-wont-commit]] — Goedecke:take a position;不表态=默许最终决定
- [[2025-12-24-nobody-knows-how-software-products-work]] — Goedecke:大系统战争迷雾;代码库=唯一可靠答案源;意图债先 AI 形态
- [[2025-04-12-wicked-features]] — Goedecke:wicked features 定义;Password Game 类比;老兵=熟悉全部 wicked features
- [[2025-11-30-opinionated-minimal-coding-agent]] — Zechner:自建极简编码代理 pi 复盘(极简派一手源;Terminal-Bench/反 MCP/文件即状态)
- [[2026-08-08-code-was-never-the-hard-part]] — Senko:编码从未容易是侮辱;两者都重要;what changes/what doesn't;meat proxy
- [[2026-08-03-dont-be-a-meat-proxy]] — Gruhn:meat proxy 术语一手源;原样转发零增值;自己的话=理解证书;评审责任反转
- [[2025-09-15-your-code-is-your-responsibility]] — Senko:提交 PR = 声明完全理解+合法权利;隐藏 AI 使用=操守违规;原型可 vibe;狗吃作业

## Syntheses

- [[ai-feature-implementation-loop]] — 让 AI 更好实现功能:从 spec 到落地的闭环 + 失败模式修复表
- [[minimal-vs-rich-harness]] — 极简 vs 富 harness 两派对比:共同底线、分维度分歧、证据对照、开放问题

## Topics

- [[ai-agents]] — 规范驱动开发研究:追踪如何让 AI 编码代理高质量、可预期地实现功能

## Answers

- [[ai-coding-vs-traditional-development]] — AI coding 相比传统开发:解决执行/获取类问题,新增理解/判断/验证类问题

---
_Last updated: 2026-08-09 (ingest Gruhn:meat proxy 术语一手化;Senko ×2 + Gruhn ×1;第 50-52 源)_
