# Wiki Log

只追加的流水账,记录摄入 / 查询 / lint。
条目格式:`## [YYYY-MM-DD] <action> | <title>` —— 保持前缀一致,可用 unix 工具解析,例如:
`grep "^## \[" log.md | tail -5`

## [2026-08-02] init | wiki scaffold created

## [2026-08-02] ingest | How to write a good spec for AI agents

- 源文档: raw/How to write a good spec for AI agents.md (Addy Osmani, 2026-01-13)
- 新建 16 页: 1 source (2026-01-13-good-spec-for-ai-agents), 4 entities (addy-osmani, simon-willison, github, anthropic), 10 concepts (ai-agent-spec, spec-driven-development, curse-of-instructions, three-tier-boundaries, agents-md, llm-as-a-judge, conformance-testing, vibe-coding, lethal-trifecta, context-engineering), 1 synthesis (ai-feature-implementation-loop)
- 重点: 如何让 AI 更好实现功能 → 综合页 ai-feature-implementation-loop

## [2026-08-02] lint | index & topics synced (multi-topic upgrade, 16 pages -> topic: ai-agents)

## [2026-08-02] ingest | Best practices for Claude Code

- 源文档: raw/Best practices for Claude Code.md (Anthropic 官方文档, 剪藏 2026-08-02)
- 新建 9 页: 1 source (2026-08-02-best-practices-claude-code), 1 entity (claude-code), 7 concepts (claude-md, agent-verification, plan-mode, skills, subagents, parallel-agents, model-context-protocol)
- 更新 5 页: anthropic, context-engineering, ai-agent-spec, curse-of-instructions, ai-feature-implementation-loop (验证门禁四档 + 失败模式修复表)
- 与 2026-01-13-good-spec-for-ai-agents 相互印证,无矛盾;补充"何时跳过计划"粒度判断

## [2026-08-02] structure | topics 目录建立 + ai-agents 主题页

- 人类新增 wiki/topics/ 分类与 ai-agents.md(type: topic);lint 已纳入 topics(CATS + orphan 检查)
- _templates/topic.md 更新为新主题页约定(核心页面/当前状态/开放问题)
- ai-agents 主题页内容刷新:2 份源文档、核心页面扩充、开放问题同步

## [2026-08-02] structure | topic 约定落定:全库 25 页 topic 字段 + lint 自动检查

- 约定确认:wiki/topics/ 主题页为长期追踪入口;ingest 时自动同步其 当前状态/开放问题(已写入 AGENTS.md §1/§2/§3)
- 补齐第二次 ingest 的 9 页 topic: ai-agents 字段(其余 16 页由人类先行添加)
- lint.sh 已有 topic-missing 检查(人类添加 §6),全库 25 页 topic 字段均指向 topics/ai-agents.md

## [2026-08-02] ingest | Building Effective AI Agents

- 源文档: raw/Building Effective AI Agents.md (Anthropic 工程博客, Erik Schluntz/Barry Zhang;原始发布日期待核实,剪藏 2026-08-02)
- 新建 5 页: 1 source (2026-08-02-building-effective-ai-agents), 1 entity (swe-bench), 3 concepts (agentic-systems, agentic-workflow-patterns, agent-computer-interface)
- 更新 7 页: anthropic, model-context-protocol, parallel-agents, llm-as-a-judge, agent-verification, lethal-trifecta, ai-feature-implementation-loop
- 跨源术语对应: ACI↔AX(Osmani)、ground truth↔验证检查、routing 分级↔致命三要素成本缓解

## [2026-08-02] ingest | Effective context engineering for AI agents

- 源文档: raw/Effective context engineering for AI agents.md (Anthropic 工程博客, Applied AI 团队;发布于 2025-09,具体日期待核实;剪藏 2026-08-02)
- 新建 3 页: 1 source (2026-08-02-effective-context-engineering-for-ai-agents), 2 concepts (context-rot, agentic-memory)
- 重构 1 页: context-engineering(升级为领域定义级:注意力预算、正确高度、最小工具集、JIT 检索、长时任务三技术)
- 更新 6 页: subagents, simon-willison(定义被官方采纳), agentic-systems(定义演进), claude-md(混合策略), curse-of-instructions(正确高度), ai-feature-implementation-loop
- 跨源呼应: Willison 的代理定义("LLMs autonomously using tools in a loop")被 Anthropic 官方采纳

## [2026-08-02] ingest | Writing effective tools for AI agents—using AI agents

- 源文档: raw/Writing effective tools for AI agents—using AI agents.md (Anthropic 工程博客, Ken Aizawa;发布于 2025-09-11,据外部转载确认,待原文核实)
- 新建 2 页: 1 source (2025-09-11-writing-effective-tools-for-ai-agents, 首个按真实发布日命名的源), 1 concept (tool-evaluation)
- 重构 1 页: agent-computer-interface(五条设计原则 + 评测指向,成为 ACI 完整落地手册)
- 更新 6 页: model-context-protocol, swe-bench(SOTA 实证), claude-code(25k 上限/协作优化), context-engineering, llm-as-a-judge(verifier 角色), ai-feature-implementation-loop(自举实证)
- 关键实证: Sonnet 3.5 经工具描述微调达 SWE-bench Verified SOTA;"用 AI agents 写 AI agents 的工具"

## [2026-08-02] ingest | How we built our multi-agent research system

- 源文档: raw/How we built our multi-agent research system.md (Anthropic 工程博客, Jeremy Hadfield/Barry Zhang 等;发布日未标注,待核实;剪藏 2026-08-02)
- 新建 2 页: 1 source (2026-08-02-how-we-built-our-multi-agent-research-system), 1 concept (multi-agent-systems)
- 更新 7 页: subagents(委派教法), parallel-agents(90.2%/4-15× token), llm-as-a-judge(rubric 判分/小样本启动), agentic-workflow-patterns(orchestrator 生产案例), agentic-memory(计划入内存), context-engineering(长时对话管理), ai-feature-implementation-loop(多代理开放问题获数据)
- 关键数据: 多代理 vs 单代理 +90.2%;token 4×/15×;BrowseComp 80% 方差由 token 用量解释;编码暂不适合多代理

## [2026-08-02] ingest | Equipping agents for the real world with Agent Skills

- 源文档: raw/Equipping agents for the real world with Agent Skills.md (Anthropic 工程博客, Barry Zhang/Keith Lazuka/Mahesh Murag;发布日未标注,文内标注 2025-12-18 开放标准更新;剪藏 2026-08-02)
- 新建 2 页: 1 source (2026-08-02-equipping-agents-with-agent-skills), 1 concept (progressive-disclosure, 三源印证)
- 重构 1 页: skills(升级为领域定义级:三级披露、代码执行、开发四准则、安全、开放标准)
- 更新 4 页: context-engineering, model-context-protocol(与 MCP 互补), anthropic(开放标准), ai-feature-implementation-loop(反馈层 skill 沉淀)
- 跨源模式: 渐进式披露 = Osmani 扩展 TOC + context engineering JIT + Skills 三级结构

## [2026-08-02] ingest | The File System Is the New Database (Personal OS for AI Agents)

- 源文档: raw/The File System Is the New Database_ How I Built a Personal OS for AI Agents.md (X 长推文, Muratcan Koylan @ Sully.ai;frontmatter 标注 2025-10-06,内嵌引文至 2026-02,成文时间存疑)
- 首篇独立开发者视角源文档
- 新建 3 页: 1 source (2025-10-06-file-system-is-the-new-database), 1 entity (muratcan-koylan), 1 concept (file-as-memory)
- 更新 6 页: context-engineering(实践印证), agentic-memory(情景记忆), progressive-disclosure(Vercel 56% 反证), skills(自动/手动双模式 + 触发率反证), claude-md(指令层级), ai-feature-implementation-loop(独立视角支持与反证)
- 关键反证: Vercel Next.js 16 评测 56% skill 从未被调用(二手引述,待核);NeurIPS 人格论文提示

## [2026-08-02] ingest | LLM Powered Autonomous Agents

- 源文档: raw/LLM Powered Autonomous Agents.md (Lilian Weng, Lil'Log;发布于 2023-06-23)
- 首篇学术综述式源文档;wiki 时间跨度延伸至 2023(奠基文献)
- 新建 3 页: 1 source (2023-06-23-llm-powered-autonomous-agents), 1 entity (lilian-weng), 1 concept (self-reflection)
- 更新 6 页: agentic-memory(生成式代理记忆流), llm-as-a-judge(ChemCrow 自评盲区反证), tool-evaluation(API-Bank 谱系), agentic-systems(历史框架), agentic-workflow-patterns(MRKL/HuggingGPT 谱系), ai-feature-implementation-loop(奠基对照 + 文件/向量记忆双线)
- 关键反证: ChemCrow 人类专家评审 vs LLM 自评分歧;三大挑战(有限上下文/长程规划/NL 接口)的时间线对照

## [2026-08-02] ingest | Effective harnesses for long-running agents

- 源文档: raw/Effective harnesses for long-running agents.md (Anthropic 工程博客, Justin Young;发布日待核实,推定 2025 底-2026)
- 新建 2 页: 1 source (2026-08-02-effective-harnesses-for-long-running-agents), 1 concept (long-running-agents)
- 更新 6 页: agentic-memory(跨会话 harness 记忆), file-as-memory(harness 实例), conformance-testing(可执行特征清单), agent-verification(浏览器自动化验证), context-engineering(多上下文窗口工作流), ai-feature-implementation-loop(长时任务失败模式表 + 开放问题)
- 关键数据: 跨会话零记忆是长时任务核心难题;compaction 不足以跨会话;feature list passes 门禁防"提前宣布完成";浏览器自动化测试大幅提升

## [2026-08-02] ingest | Harness design for long-running application development

- 源文档: raw/Harness design for long-running application development.md (Anthropic Labs, Prithvi Rajasekaran;发布日待核实,推定 2026)
- 上篇 harness 文献的直接续作;GAN 式 generator-evaluator + planner 三代理架构
- 新建 2 页: 1 source (2026-08-02-harness-design-for-long-running-apps), 1 concept (context-anxiety)
- 更新 7 页: llm-as-a-judge(自评偏差+评估器校准), long-running-agents(三代理架构+sprint contract), context-engineering(上下文焦虑+reset), agent-verification(硬阈值评估器), agentic-workflow-patterns(evaluator-optimizer 深度案例), spec-driven-development(planner 自动化 Specify), ai-feature-implementation-loop(新失败模式+成本数据)
- 关键数据: Solo 20min/$9 vs 三代理 6h/$200(20倍);DAW 3h50m/$124.70,QA 每轮 $3-4;Sonnet 4.5 上下文焦虑→Opus 4.5 消除

## [2026-08-02] ingest | Agent Harness Engineering

- 源文档: raw/Agent Harness Engineering.md (Addy Osmani;发布于 2026-04-19)
- Osmani 第三篇源文档;harness 工程学科化的综合论述(Viv Trivedy 等式、HumanLayer skill issue、Terminal Bench 证据、HaaS)
- 新建 2 页: 1 source (2026-04-19-agent-harness-engineering), 1 concept (harness-engineering)
- 更新 5 页: addy-osmani(第三篇源), agents-md(棘轮原则), context-engineering(tool-call 输出卸载), long-running-agents(Ralph Loop), ai-feature-implementation-loop(harness 差距论 + MCP 供应链安全)
- 关键数据: Terminal Bench 2.0 同模型跨 harness 差距大;只改 harness Top 30→Top 5;AGENTS.md <60 行(HumanLayer)

## [2026-08-02] ingest | The Factory Model: How Coding Agents Changed Software Engineering

- 源文档: raw/The Factory Model_ How Coding Agents Changed Software Engineering.md (Addy Osmani;发布于 2026-02-25)
- Osmani 第四篇源文档;行业范式级论述(软件第三纪元、工厂心智模型、spec 即杠杆、验证是瓶颈)
- 新建 2 页: 1 source (2026-02-25-factory-model-coding-agents), 1 concept (factory-model)
- 更新 7 页: addy-osmani(第四篇源), ai-agent-spec(spec 即杠杆), agentic-systems(三代工具谱系), conformance-testing(红/绿 TDD 强制), agent-verification(验证瓶颈论), agents-md(文档即训练材料), ai-feature-implementation-loop(范式层)
- 关键主张: 验证是未解问题(不是生成);测试后写则测的是"实现恰好做的事";人工审查是安全系统;宏观指标(二手)

## [2026-08-02] ingest | AI writes code faster. Your job is still to prove it works.

- 源文档: raw/AI writes code faster. Your job is still to prove it works..md (Addy Osmani;发布于 2026-01-07)
- Osmani 第五篇源文档;AI 时代代码评审:负担转移显式化 + PR Contract
- 新建 2 页: 1 source (2026-01-07-ai-code-review), 1 concept (pr-contract)
- 更新 4 页: addy-osmani(第五篇源), agent-verification(人类侧闭环+量化), llm-as-a-judge(AI 评审工具现实), ai-feature-implementation-loop(评审层)
- 关键数据(均二手待核): PR +18%、事故 +24%、失败率 +30%、45% 安全缺陷、逻辑 1.75×/XSS 2.74×

## [2026-08-02] ingest | Comprehension Debt - the hidden cost of AI generated code

- 源文档: raw/Comprehension Debt - the hidden cost of AI generated code..md (Addy Osmani;发布于 2026-03-14)
- Osmani 第六篇源文档;理解力债务:AI 代码对人类理解力的隐性成本(对验证/评审路线的重要对冲)
- 新建 2 页: 1 source (2026-03-14-comprehension-debt), 1 concept (comprehension-debt)
- 更新 5 页: addy-osmani(第六篇源), pr-contract(被评审≠被理解), agent-verification(测试硬上限), factory-model(spec 杠杆边界), ai-feature-implementation-loop(理解力层)
- 关键数据(待核): Anthropic RCT 理解力 -17%(50% vs 67%);委派式 <40% vs 询问式 >65%;速度不对称

## [2026-08-02] ingest | Cognitive Surrender

- 源文档: raw/Cognitive Surrender.md (Addy Osmani;发布于 2026-05-05)
- Osmani 第七篇源文档;认知投降:理解力债务的机制层(offloading vs surrender)
- 新建 2 页: 1 source (2026-05-05-cognitive-surrender), 1 concept (cognitive-surrender)
- 更新 5 页: addy-osmani(第七篇源), comprehension-debt(机制层), pr-contract(校准功能), vibe-coding(投降风险), ai-feature-implementation-loop(人侧机制层)
- 关键数据(待核): Wharton 3 实验 1372 人,AI 错时 73% 接受错答案、信心反升;MIT 脑神经研究

## [2026-08-02] ingest | 工程技术:在智能体优先的世界中利用 Codex

- 源文档: raw/工程技术：在智能体优先的世界中利用 Codex.md (OpenAI 官方博客, Ryan Lopopolo;发布于 2026-02-11)
- 首个 OpenAI 视角;零人工代码实验(5 个月 100 万行、1500 PR、3.5 PR/人/天,自述)
- 新建 3 页: 1 source (2026-02-11-codex-agent-first-engineering), 1 entity (openai), 1 concept (agent-readability)
- 更新 7 页: agents-md(四败因+地图论), agent-computer-interface(应用/可观测性可读性), progressive-disclosure(仓库知识库实例), file-as-memory(仓库即记录系统), agent-verification(智能体对智能体评审), harness-engineering(熵与垃圾回收), ai-feature-implementation-loop(阵营实验层+矛盾标注)
- 记录阵营矛盾: OpenAI 智能体对智能体评审+减少阻塞门 vs Osmani 人类签字不可替代(双向标注)

## [2026-08-02] ingest | 持续改进我们的智能体框架

- 源文档: raw/持续改进我们的智能体框架.md (Cursor 官方博客, Stefan Heule;发布于 2026-04-30)
- 首个 Cursor 阵营;harness 持续改进方法论(Keep Rate/语义满意度/按模型定制/回归追踪)
- 新建 2 页: 1 source (2026-04-30-cursor-agent-harness-improvement), 1 entity (cursor)
- 更新 6 页: harness-engineering(按模型定制), context-anxiety(第三次报告+提示调优), context-engineering(护栏→动态上下文), tool-evaluation(在线评测指标), context-rot(工具错误致腐), ai-feature-implementation-loop(框架厂层)
- 关键数据: Keep Rate 变更保留率;工具可靠性冲刺后 ≥99%(多 99.9%);patch vs str_replace 格式错配消耗 reasoning token

## [2026-08-02] ingest | Skill Issue: Harness Engineering for Coding Agents

- 源文档: raw/Skill Issue_ Harness Engineering for Coding Agents.md (HumanLayer, Kyle;发布于 2026-03-12)
- "skill issue"框架出处(Osmani harness 文引用源头);配置工程六面 + 回压 + 上下文防火墙
- 新建 2 页: 1 source (2026-03-12-skill-issue-harness-engineering), 1 entity (humanlayer)
- 更新 7 页: agents-md(ETH Zurich 反证), subagents(上下文防火墙), agent-verification(回压体系), context-engineering(指令预算/愚蠢区/长上下文怀疑), harness-engineering(过拟合双刃#33/#5+经验清单), skills(恶意注册表+工具分发), ai-feature-implementation-loop(配置工程层)
- 关键数据(待核): ETH Zurich 138 agentfile(LLM 生成损害性能贵 20%+,人工 +4%);Terminal Bench Opus 4.6 #33→#5

## [2026-08-02] ingest | AI Native 时代——研发组织何去何从

- 源文档: raw/AI Native 时代 —— 研发组织何去何从.md (阿里技术, 许晓斌;发布于 2026-05-08)
- 首个中文原创源 + 首个组织设计视角;全数据为内部转述(待核)
- 新建 6 页: 1 source (2026-05-08-ai-native-organization), 2 entities (alibaba, xu-xiaobin), 4 concepts (execution-graph, hive-mind, management-collapse, distillation-anxiety)
- 更新 5 页: agent-readability(AI 友好 5 维度+人形偏置), harness-engineering(组织尺度+复利), comprehension-debt(组织侧镜像,修复一次误删), anthropic(Hive Mind 文化,二手), ai-feature-implementation-loop(组织层)
- 关键数据(二手待核): 编码 10× vs 端到端 2-3×;同日迭代(6 周→1 天);系统打通调研断层第一;Peter Pang 管人 60%→<10%;Agent 四不对称
- 新增阵营佐证: 阿里"不敢全信、人工又扛不住" = 评审分歧的第三方中间观察

## [2026-08-02] ingest | How Claude Code works in large codebases

- 源文档: raw/How Claude Code works in large codebases_ Best practices and where to start.md (Anthropic 官方, Applied AI 团队;发布 2026-05-14,推断待核)
- "Claude Code at scale" 系列首篇;harness 官方背书 + agentic vs RAG 检索 + 配置评审节奏 + 企业所有权
- 新建 1 页: source (2026-05-14-claude-code-large-codebases)
- 更新 8 页: claude-code, harness-engineering(官方背书+3-6 月维护节奏), context-engineering(RAG 陈旧失败模式+LSP 符号检索), subagents(探索编辑分离), claude-md(分层加载+随模型进化维护), skills(路径限定), management-collapse(agent manager/DRI↔Architect), ai-feature-implementation-loop(企业规模部署层)
- 发布日推断: frontmatter 笔误 2001-05-14 → 2026-05-14(Ken Huang 5-20 checklist、HN 5-29 热帖佐证)
- 关键发现: 组件误区表;配置评审 3-6 月 = harness 过时问题首个节奏答案;agent manager/DRI = 阿里 Architect 的企业落地名;Ken Huang 与阿里文章同话语圈

## [2026-08-02] ingest | The Intent Debt

- 源文档: raw/The Intent Debt.md (Addy Osmani;发布于 2026-06-05)
- ⚠️ raw clip 正文缺失(仅 "ai" 二字),内容自 addyosmani.com/blog/intent-debt/ 抓取补全
- 债务三部曲完成篇:技术债(代码)/认知债(人)/意图债(工件);引 Storey Triple Debt Model (arXiv 2603.22106,待核)
- 新建 2 页: source (2026-06-05-intent-debt), concept (intent-debt)
- 更新 5 页: comprehension-debt(三元组定位+互补论证), cognitive-surrender(意图债=被写下来的投降), agents-md(意图账本 framing+反 /init), ai-agent-spec(spec 写意图), ai-feature-implementation-loop(债务三元组层)
- 关键论点: 意图是唯一必须源于人的输入;冷启动经济学(每会话付一次×每个代理);orchestration tax 大部分是意图税;"AI 擅长产出你忘了写下来的问题的答案"
- 待核: Triple Debt Model 原文;orchestration-tax / automated-decision-logs / self-improving-agents 三篇 Osmani 关联文未入库

## [2026-08-02] fix | raw/The Intent Debt.md 已补全

- 人工重新裁剪补全 raw 文件(原 clip 正文仅 "ai");核对与 2026-08-02 抓取版内容一致,已入库页面无需修订
- 更新 source 页备注为已解决状态

## [2026-08-02] ingest | Loop Engineering

- 源文档: raw/Loop Engineering.md (Addy Osmani;发布于 2026-06-07)
- 循环工程:harness 上一层("跑在定时器上的 harness");五件套+记忆;Steinberger/Cherny 推文引证(二手)
- 新建 2 页: source (2026-06-07-loop-engineering), concept (loop-engineering)
- 更新 8 页: harness-engineering(层级定位), agent-verification(/goal 停止条件验证), long-running-agents(循环原语), subagents(Codex TOML+maker/checker), skills(触发描述+创作格式vs分发), cognitive-surrender(循环=加速剂或解药), comprehension-debt(循环加速债务), ai-feature-implementation-loop(循环工程层)
- 关键论点: "done 是主张不是证明";同构循环异果;"杠杆点移动了";循环不替人做三件事(验证/理解/姿态)
- 无新矛盾(验证立场与 pr-contract 阵营一致);token 成本模型/无监督循环失败模式待核

## [2026-08-02] ingest | The Code Agent Orchestra

- 源文档: raw/The Code Agent Orchestra - what makes multi-agent coding work.md (Osmani, O'Reilly AI CodeCon 演讲文字稿;发布于 2026-03-26)
- 指挥→编排范式;单代理三堵墙;四乘法理由;Agent Teams 协调原语;2026 工具三层;Ralph Loop 形式化;质量门三件套
- 新建 3 页: source (2026-03-26-code-agent-orchestra), concepts (agent-teams, ralph-loop)
- 更新 8 页: multi-agent-systems(编排层), parallel-agents(编排纪律), subagents(报告文件交接+层级子代理), agents-md(ETH 精确数字-3%/>20%/Gloaguen), self-reflection(循环护栏强制反思), long-running-agents(ralph-loop 链接), factory-model(六步流水线), ai-feature-implementation-loop(多代理编排层)
- 关键数据: ETH Zurich 精确化(成功率 -3%、推理成本 +20%+,归因 Gloaguen et al.,待核);3-5 队友甜点区;MAX_ITERATIONS=8 强制反思;四通道记忆;Beads(SQL 可寻址制度记忆)
- Agent Teams = 对"实时协调不成熟"开放问题的产品化回应;无新矛盾

## [2026-08-02] ingest | Agent Skills (Osmani)

- 源文档: raw/Agent Skills.md (Addy Osmani;发布于 2026-05-03)
- agent-skills 开源项目设计思想文(27K stars,MIT);过程胜过散文;反合理化表格;Google DNA;五条不可妥协
- 新建 3 页: source (2026-05-03-agent-skills), concepts (process-over-prose, anti-rationalization-tables[从 cognitive-surrender 反制升格])
- 更新 6 页: skills(Osmani 版+六阶段 SDLC+路由器+可移植性), cognitive-surrender(表格链接), agents-md(五条不可妥协), harness-engineering(层级分工), long-running-agents(运行越长越强制), ai-feature-implementation-loop(纪律工程层)
- 关键论点: "工作日益变成把纪律编码成代理无法说服自己绕开的东西";验证不可妥协(证据退出标准);范围纪律=PR 可合并性最大单一决定因素;反合理化表格公开样例集落地(部分回答开放问题)
- 无新矛盾;五条不可妥协与 ETH 反证兼容(短而强制 vs 长而忽略)

## [2026-08-02] ingest | The Future of Agentic Coding: Conductors to Orchestrators

- 源文档: raw/The future of agentic coding_ conductors to orchestrators.md (Addy Osmani;发布于 2026-01-02)
- conductor/orchestrator 分类学原始定义(Code Agent Orchestra 演讲前身);五轴对比;编排六大挑战
- 新建 2 页: source (2026-01-02-future-agentic-coding), concept (conductor-orchestrator)
- 更新 2 页: multi-agent-systems(角色光谱链接), ai-feature-implementation-loop(六大挑战+AI 可观测性)
- 关键互证: ephemeral vs git 痕迹 ↔ file-as-memory/pr-contract;"代理评审代理、人最后在环" ↔ 阵营分歧中间观察;spec 上移 ↔ intent-debt/ai-agent-spec;Osmani 2026 写作弧线起点
- 无新矛盾;90% 采用率与 10+ PR/天无出处待核

## [2026-08-02] ingest | Your AI coding agents need a manager

- 源文档: raw/Your AI coding agents need a manager.md (Addy Osmani;发布于 2026-01-08)
- 管理技能迁移论;四项技能;delegate/review/own 三分法;PR packet;六步操作系统(工厂流水线谱系源头)
- 新建 2 页: source (2026-01-08-coding-agents-manager), concept (agent-management)
- 更新 5 页: pr-contract(PR packet 操作化), conductor-orchestrator(操作手册链接), simon-willison(评审瓶颈论), factory-model(六步谱系;补上 orchestra ingest 遗漏的流水线 bullet), ai-feature-implementation-loop(管理层)
- 关键互证: PR packet ↔ pr-contract 四字段;delegate/review/own = 阵营分歧的折中表述;Agent HQ 控制平面趋势;Cherny 头衔表述不一(创造者 vs 负责人,待核)
- 无新矛盾

## [2026-08-02] ingest | Agentic Engineering

- 源文档: raw/Agentic Engineering.md (Addy Osmani;发布于 2026-02-04)
- 术语定名:vibe coding 行李箱词问题;agentic engineering 正名(Karpathy 命名);技能差距
- 新建 2 页: source (2026-02-04-agentic-engineering), concept (agentic-engineering)
- 更新 4 页: vibe-coding(谱系+合法用途+失败模式), simon-willison(vibe engineering 提案), addy-osmani(两本书), ai-feature-implementation-loop(术语与立场层)
- 关键互证: "测试是把不可靠的代理变成可靠系统的方式" ↔ 验证是瓶颈;解释不了就不该进 ↔ pr-contract;"AI 更奖励好工程实践" ↔ spec 杠杆;skill atrophy ↔ Anthropic RCT
- 无新矛盾;Karpathy 推文/Willison 原文待核

## [2026-08-02] ingest | Self-Improving Coding Agents

- 源文档: raw/Self-Improving Coding Agents.md (Addy Osmani;发布于 2026-01-31)
- Ralph Loop 实操大全(Ryan Carson 技术扩展);六步循环;四通道记忆;AGENTS.md 手册;监控止损;风险管理
- 新建 1 页: source (2026-01-31-self-improving-agents);ralph-loop 概念页大幅重写(六步+手册+止损+风险)
- 更新 4 页: agents-md(手册结构+Eric Ma 实时反馈+记忆注入验证), long-running-agents(复合循环+定期重新聚焦), agent-teams(Cursor 规模化实验:锁失败→风险厌恶代理;Planner-Worker-Judge), ai-feature-implementation-loop(自改进循环层)
- 关键互证: 四通道记忆 ↔ file-as-memory/long-running-agents;PR 不自动合并 ↔ pr-contract 阵营;"迭代更深而非更宽" ↔ 3-5 甜点;新张力:运行笔记本(代理自写学习条目)vs ETH 反证(待核)
- 无新矛盾;$50k/几百美元轶事与外部引用待核

## [2026-08-02] ingest | Agentic Code Review

- 源文档: raw/Agentic Code Review.md (Addy Osmani;发布于 2026-06-15)
- 2026-01-07 短评文 ai-code-review 的全面深化版:四数据集(Faros/CodeRabbit/GitClear/GitHub)、评审器异质性实证(93.4% 恰好一工具抓到)、human on the loop、分层评审行动清单
- 新建 1 页: source (2026-06-15-agentic-code-review)
- 更新 8 页: agent-verification(评审经济学/分层/异质性/human on the loop/纪律四则), pr-contract(证据门槛/决策日志/agent ghost), llm-as-a-judge(异质性节), comprehension-debt(意图恢复), cognitive-surrender(闭环 borrowed confidence), intent-debt(决策日志), ai-feature-implementation-loop(评审经济学层+反证区 2 条新张力)
- 新张力: "有意减少阻塞门"(OpenAI) vs "默认零评审"(Faros +31.3%)——同向成因相反;agent ghost(38% 弃审) vs 偶发失败重跑——同一行为两种解读
- 关键数字: churn +861%、缺陷率 9%→54%、评审时长 +441.5%、1.7x issues、4x 产出 vs 12% 真实增益、60M+ 评审/10x
- 无直接新矛盾;全部厂商数据有立场但跨源效应量一致(已在 source 页标注);arXiv 与访谈原文待核

## [2026-08-02] ingest | The Orchestration Tax

- 源文档: raw/The Orchestration Tax.md (Addy Osmani;发布于 2026-05-24)
- "编排税"术语正式定名(Google I/O panel 上 Richard Seroter 命名);GIL 类比 + Amdahl 定律精确化;注意力架构五实践
- 新建 2 页: source (2026-05-24-orchestration-tax), 概念 orchestration-tax(升格独立概念页——多代理时代的核心经济概念)
- 更新 6 页: parallel-agents(人类是瓶颈:并行上限 = 评审率), multi-agent-systems(编排经济学), conductor-orchestrator(编排税成本经济学;顺带修复历史遗留 \" 转义 typo), intent-debt(编排税 = 意图税出处 + Storey 博客旁证), cognitive-surrender(注意力耗尽 = 投降的结构路径), ai-feature-implementation-loop(编排税层)
- 关键互证: 回压 ↔ harness-engineering 验证回压;批量评审 ↔ Ralph Loop 监控节奏;"锁只花在判断上" ↔ pr-contract 证据义务;两堆分类 ↔ conductor-orchestrator 人力前载/后载;Storey 认知债博客 ↔ Triple Debt Model 跟踪(arXiv 2603.22106)
- 无新矛盾;Osmani 未入库关联文已清零(自改进/对抗评审/编排税全部入库)
- 待核: Google I/O panel 视频;Your parallel Agent limit 博客;Storey 认知债博客(2026-02-09,未来 raw 候选)

## [2026-08-02] ingest | Building an AI-native engineering team

- 源文档: raw/building-an-ai-native-engineering-team.pdf (OpenAI 官方指南,20 页英文 PDF;发布日待核实,估计 2025 末-2026,暂用裁剪日 2026-08-02)
- SDLC 六阶段(Plan/Design/Build/Test/Review/Document/Deploy&maintain)每阶段 Delegate/Review/Own 三分法 + checklist;METR 数据(2h17m/7 个月翻倍)
- 新建 1 页: source (2026-08-02-building-ai-native-engineering-team)
- 更新 6 页: pr-contract(官方立场 note:own 最终评审合并——与内部实验同公司两种声音), agent-verification(官方评审方法论:专门训练 P0/P1 + gold-standard 评估集 + PR comment reactions), agents-md(解锁 agentic loops/自动文档指令——AGENTS.md 三处落地载体), conformance-testing(测试=事实源+独立会话+TDD 先失败官方背书), agent-management(SDLC 全流程三分法), ai-feature-implementation-loop(官方指南层 + 阵营分裂"厂商内部镜像"维度)
- 关键互证: 四使能 = harness 四支柱;测试先行 ↔ spec-driven/TDD;PLAN.md ↔ plan-mode;delegate/review/own 从二手变一手
- 无新矛盾;新张力: 官方指南(对外保守,人 own 合并) vs 内部实验(激进,评审代理化)——"建议给别人的 vs 自己敢做的"
- 待核: 发布日;METR 一手报告;Cloudwalk/Sansan/Virgin Atlantic 案例(营销性)

## [2026-08-02] ingest | Measuring AI Ability to Complete Long Software Tasks

- 源文档: raw/Measuring AI Ability to Complete Long Software Tasks.md (METR;发布于 2025-03-19,页面带 2026-01-29 Time Horizon 1.1 更新注记,交互图更新至 2026)
- 时间地平线度量一手报告:任务长度(人类时长)= AI 能力;约每 7 个月翻倍(6 年);GPT-2 ~4 秒 → Claude 3.7 ~1h → GPT-5 ~2h → Opus 4.6 ~16h
- 新建 1 页: source (2025-03-19-measuring-ai-long-tasks)
- 更新 2 页: long-running-agents(能力基线节), ai-feature-implementation-loop(官方指南层引用一手化)
- **待核闭环**: OpenAI PDF 引用的 "METR 2h17m" 与一手交互图 GPT-5(2025-08)数据点一致——二手引用已核实 ✓(source 2026-08-02-building-ai-native-engineering-team 待核状态更新)
- 无新矛盾;交互图数据点由 SVG 近似读取(约数,精确值待核 time-horizons 页)
- 未来候选: Time Horizon 1.1(2026-01-29)方法论更新、arXiv 2503.14499 全文

## [2026-08-02] lint | 全库健康检查

- 结构: lint clean(97 pages);raw/ 32 文件全部已入库,无遗漏
- 修复: 主题页开放问题区滞后(旧版 25 条)→ 与综合页合并同步(45+ 条,去重后补入主题页独有 11 条:GitHub 2,500+ agents.md 口径/LLM-judge 盲区/过度规范边界/五模式选择/context rot 曲线/memory tool/工具命名空间/agentskills.io/Vercel 56%/NeurIPS 人格论文/LLM+P 长程规划);综合页补编排税量化与时间地平线外推两条开放问题
- 核对: index 为 ingest 顺序追加(惯例正确);conformance-testing refs 无残留垃圾;ralph-loop 无"五步"旧表述残留;2h17m 已核实闭环
- 待核状态 20 个 source 页标记均为真实未解(外部引用/发布日/二手数据),无需变更

## [2026-08-02] ingest ×4 | AI 抓取补充(AI 直接抓取,无 raw 文件)

- 抓取 4 篇高优先候选(用户确认),provenance 标注:非人工裁剪,AI 直抓 URL;发布日经 arXiv API/页面 meta 核实
- ① [[2026-02-09-cognitive-debt]] Storey 认知债博客(2026-02-09)——认知债一手源;Naur 程序理论/Brooks 回声;缓解实践
- ② [[2026-01-28-skill-formation-rct]] Anthropic RCT(arXiv 2601.20245)——理解力债实验一手化:核心发现核实(六交互模式/65-86% 高分界/agentic 损失更大);-17%/52 人口径待全文
- ③ [[2026-02-12-evaluating-agents-md]] ETH AGENTS.md 研究(arXiv 2602.11988)——反证一手化:**数字协调 -3%(转述)vs -0.5%/-2%(一手)**;文档冗余假说(+2.7%);指令被遵循但概览失败
- ④ [[2026-04-07-cognitive-parallel-agents]] Osmani 并行限制(2026-04-07)——编排税前传;ambient anxiety tax 出处;先降范围再降数量
- 更新 7 页: comprehension-debt(RCT/Storey 一手化), intent-debt(Storey 核实✓), orchestration-tax(前传+Storey 一手), agents-md(ETH 一手化), ai-feature-implementation-loop(反证区+编排税层+开放问题)
- 待核闭环: ETH -3% 转述差异(同量级,聚合口径待全文);Storey 债务框架旁证 ✓;RCT 二手转述核心一致 ✓
- 无新矛盾;已解决: 综合页"Anthropic RCT 与 <40%/>65% 数据核实"开放问题(与一手 65-86% 吻合)

## [2026-08-02] ingest | From Technical Debt to Cognitive and Intent Debt (Triple Debt Model)

- 源文档: raw/2603.22106v4.pdf (Storey;arXiv 2603.22106,发布 2026-03-23,v4 更新 2026-04-06,arXiv API 核实)
- 债务三元组一手论文:三层系统健康(意图/代码/共享理解);三债因果循环;AI 减技术债同时加速认知+意图债
- 新建 1 页: source (2026-03-23-triple-debt-model)
- 更新 4 页: intent-debt(债务三元组一手化 + **修正:认知债(团队级)≠ comprehension debt(个人)**——此前 wiki 合并了两者), comprehension-debt(论文级定义与区分/诊断信号/缓解), cognitive-surrender(Shaw & Nave SSRN 6097646 出处确认——Wharton 数据一手引用), ai-feature-implementation-loop(理解力层一手化 + 新张力"抵制理解的自动化 vs 文档委托" + 意图债测量监控方向)
- 关键互证: 投降→认知债机制链;reimplementation 修复 ↔ ralph-loop;"把理解当交付物" ↔ pr-contract;Willison 认知债博客(2026-02-15)新候选源
- 无新矛盾;新张力: Storey"抵制理解自动化" vs OpenAI 文档委托(折中:委托草稿+人评审)
- 待核: Willison 认知债博客、Shaw & Nave SSRN 全文、Starr & Storey 2602.10540、AIRELI 分类(未来候选)

## [2026-08-02] lint | 全面自检(38 源/102 页)

- 修复: index.md 重复 [[anthropic]] 条目(第 10/13 行,103→102 与页数一致);comprehension-debt 债务三元组段残留"待核"→ 更新为一手论文引用(认知债缓解靠实践,非简单"让代理解释")
- 同步: 主题页当前状态区待核标记更新(RCT/Wharton/ETH 已一手化,精确口径标注);开放问题区与综合页一致 ✓
- 核对通过: source 编号 17-38 连续无重复;关键数字跨页一致(ETH -0.5%/-2% 口径、2h17m、93.4%、441.5%);综合页 18 层清单完整;lint clean(102 pages)
- 剩余待核 9 项均为真实未解(宏观二手数据/Terminal Bench #33#5/Vercel 56%/$50k 轶事/Karpathy 原文/Cherny 头衔/阿里二手/loop-engineering 作者自评/management-collapse),无需变更

## [2026-08-03] fix | Storey 认知债博客 raw 人工裁剪版核对

- raw/How Generative and Agentic AI Shift Concern from Technical Debt to Cognitive Debt.md 人工裁剪版提供(AI 直抓版 2026-08-02 在先)
- 核对: 两版核心主张一致 ✓;raw 版更完整,补入 3 段:①创业课实证(7-8 周撞墙,共享理解碎片化)②Fowler/Thoughtworks 退思会 breakout session(2026-02-09 同日;慢下来+结对/重构/TDD 治双债)③认知债警告信号(犹豫变更/部落知识/黑箱感)
- source 页 provenance 更新(直抓 → 直抓+人工裁剪核对一致);待办区更新(Triple Debt 论文已一手化)

## [2026-08-03] ingest | In defense of not understanding your codebase (Goedecke)

- 源文档: raw/In defense of not understanding your codebase.md(Goedecke 博客;发布 2026-07-11 站点页面头核实,raw frontmatter published/author 为空已补全,raw 未改动)
- 核心: 驳 Naur《Programming as Theory Building》废弃重建论(①大系统无法从零重建——成功重写=切块逐块 ②废弃代码库复活是常态);大系统人人持部分错误理论——能力=带部分正确理论工作("那个人就是你");理论构建只是众多权衡之一(他人写码/法定功能/离职/安全补丁/依赖都在损害它);LLM 双刃剑(难建详细理论 vs 快速建部分理论+更有效利用,作者自认未定论);时间性理论(为什么此时建 X/Y 何时加入)
- 新建 3 页: source (2026-07-11-in-defense-of-not-understanding-your-codebase,第 39 篇)、entity (sean-goedecke)、concept (theory-building——Storey 与 Goedecke 对 Naur 的交锋点)
- 更新 6 页: comprehension-debt(对冲:部分理解是常态/债务要标定;LLM 双刃剑;时间性理论)、cognitive-surrender(第三路径:部分理论+承诺猜测)、distillation-anxiety(反证:程序理论可从代码重建,但组织隐性知识≠程序理论)、intent-debt(时间性意图:why-then)、cognitive-debt/triple-debt-model 源页(Naur 指向 theory-building)
- 修复漂移: 主题页 frontmatter sources 缺最后 7 篇(32-38)→ 补齐并加新源
- 关键互证: Goedecke"分布式理解的稳态" vs Storey"分布式理解的失效(速率/检测难度)"——兼容不矛盾;重写=切块 ↔ 架构尺度策略;投降第三路径 ↔ 反制启发式
- 无新矛盾;新张力(暂不建页): "部分理解无妨" vs "理解差距是债"——差异在测量单位与时间尺度,synthesis 候选
- 待核: Goedecke 播客简介数据(2025 年 141 篇/月百万读者,二手);pure/impure 与 good engineers 系列原文(候选源)

## [2026-08-03] ingest | Goedecke 三篇:pure/impure、Take a position、Nobody knows(第 40-42 篇)

- 源文档: raw/Pure and impure software engineering.md、raw/Engineers who won't commit.md、raw/Nobody knows how large software products work.md(AI 直抓版 2026-08-03,curl+pandoc 全文;发布日站点 post-meta 核实:2025-06-22 / 2025-02-10 / 2025-12-24;未经人工裁剪核对,raw frontmatter 由抓取脚本补全)
- 核心: ①pure/impure 两种工程文化(纯技术完美 vs 高效解决现实问题;不是能力等级是不同领域;2010s pure 被过度资助);**AI 对 impure 帮助最大**(~30% 自报,pure 工程师专精领域内几乎总胜过 LLM)——解释"AI 对一些人神奇对另一些人无用" ②take a position(最有上下文者必须表态哪怕 55-60% 信心;不表态=默许最终决定;surrender=决策缺席 vs non-committal=责任缺席) ③战争迷雾(大系统基本问题有时零人能答;代码库=唯一可靠答案源;reorg 摧毁默会知识;行为涌现无自觉意图)
- 新建 4 页: source ×3(第 40/41/42 篇)、concept (pure-impure-engineering)
- 更新 5 页: cognitive-surrender(第三路径一手化+双失败模式区分)、theory-building(经验证据:战争迷雾;文化层)、comprehension-debt(先 AI 基线:债务测恶化非从零到一)、intent-debt(意图债先 AI 形态:涌现行为)、sean-goedecke(4 源)
- 主题页: 视角统计 Goedecke ×4;实证基础 + METR impact-of-ai(待核);开放问题 + AI 有用性差异标定;理解力测量加基线参照
- 关键互证: 战争迷雾 ↔ Storey transactive memory 丢失;"探索性手术" ↔ in-defense"端到端一条流";代码库=答案源 → 代码可读性=组织知识资产(与理解力债闭合);METR impact-of-ai 方向性与 Anthropic RCT 同族(待核)
- 无新矛盾;待核: METR impact-of-ai 报告、Goedecke ~30% 自报;候选源: wicked-features(三篇反复引用)

## [2026-08-03] ingest | Wicked features(第 43 篇)

- 源文档: raw/Wicked features.md(AI 直抓版 2026-08-03;发布 2025-04-12 站点 post-meta 核实;未经人工裁剪核对)
- 核心: wicked features = 必须每次建其他功能都考虑的需求(新用户类型/on-prem/分片/本地性/跨区域迁移/i18n);Password Game 类比(规则成组求解,大项目从工单/事故才知道坏了——低估任务的常见原因);大部分固有于领域模型层而非实现;最有钱的客户爱它们;工程师职责=阻止不必要的+限制爆炸半径
- 新建 2 页: source (2025-04-12-wicked-features)、concept (wicked-features——机制层,4 篇 Goedecke 文的共同底层)
- 更新 7 页: theory-building(战争迷雾结构性原因)、comprehension-debt(禁止理解的供给侧机制)、pure-impure-engineering(混战复杂度来源)、nobody-knows/pure-impure/in-defense 源页(机制链接+待办更新)、sean-goedecke(5 源)
- 主题页: 43 份;Goedecke ×5;开放问题 + wicked features 量化(翻车曲线/onboarding 时间曲线无数据)
- 关键互证: "老兵=熟悉全部 wicked features" ↔ intent-debt"四年老工程师=意图文档"(具体内容物);Password Game 延迟反馈 ↔ 认知债警告信号;不可重建论的机制闭合
- 无新矛盾;待核不变(METR impact-of-ai、~30% 自报);Goedecke 主要概念体系已收齐(理论构建/两文化/take a position/战争迷雾/wicked features)

## [2026-08-03] answer | AI coding 相比传统开发:解决什么、新增什么

- 查询: "使用AI coding过程中,相比传统开发,可以优化解决哪些问题,同时新增了哪些新的问题?" 人类确认归档
- 新建 1 页: wiki/answers/ai-coding-vs-traditional-development.md
- 核心结论: 解决的都是执行/获取类问题(实现速度/知识门槛/意图传递/验证成本),新增的几乎全是理解/判断/验证类问题(理解债/认知投降/意图债高频化/编排税/致命三要素/技能萎缩);共同根 = 人仍是唯一串行判断点,瓶颈从生成转移到评审;核心反讽: AI 开发比传统开发更奖励好工程实践
- 引用 14 页 refs + 14 份 sources;index.md 已更新(Answers 首条目)

## [2026-08-03] ingest | Anthropic RCT 全文(v2,raw/2601.20245v2.pdf)

- 源文档: raw/2601.20245v2.pdf(pdftotext 全文 12 页;v2 发布 2026-02-01;作者 Shen*(Anthropic Fellows)/Tamkin;预注册 OSF w49e7;注释数据开源 github.com/safety-research/how-ai-impacts-skill-formation)
- 核心: ①全部数字闭合:n=52(26/26)、quiz -17%=4.15/27 分、d=0.738、p=0.010;任务时间**无显著差异 p=0.391**(Osmani 二手"52 人/-17%"完全吻合) ②为什么没提速:写 query 时间=思考时间(总交互 11 分钟/单条 6 分钟/15 queries);完全委派子组 n=4(~20%)19.5min vs 对照 23min;chat=认知卸载下界,agentic 损失更大(论文自身 future work 立场) ③六模式精确画像:低分 <40%(AI Delegation 39%/Progressive Reliance 35%/Iterative Debugging 24% 最慢 31min)、高分 ≥65%(Generation-Then-Comprehension 86%/Hybrid 68%/Conceptual Inquiry 65% 高分中最快);Generation-Then-Comprehension vs AI Delegation 表面行为几乎一样=offloading/surrender 实验级映射 ④**错误即学习机制**:对照中位 3 错误 vs AI 组 1;零错误完成 12 人仅 2 在对照;Trio 相关错误(RuntimeWarning/TypeError)强制核心概念;AI 绕过学习事件本身 ⑤debugging 题差距最大=监督 AI 代码所需能力恰被 AI 使用侵蚀(闭环反讽) ⑥直接粘贴 vs 手动复制 quiz 无差异(认知努力>原始时间) ⑦pilot 方法论透明:35% 对照违规用 AI、"无 AI 对照组"现实中会漏
- 更新 6 页: source 2026-01-28-skill-formation-rct(全文一手化+raw 路径)、comprehension-debt(数字闭合+错误机制+quiz 测量工件)、cognitive-surrender(六模式映射+事后自知)、agentic-engineering(数字核实)、pure-impure-engineering(新技能任务无提速边界标定)、ai-feature-implementation-loop(理解力层+反证+开放问题 2 条)
- 主题页: 进展 +1 条;实证基础闭合 1 条;开放问题更新 3 条(理解力测量口径、技能形成操作化、AI 有用性边界)+ 新增 1 条(错误甜蜜点)
- 关键互证: 六模式 ↔ surrender/offloading 同行为异结果(与 loop-engineering"同构循环异果"同族);错误机制 ↔ 刻意摩擦反制实验支持;chat=下界 ↔ "agentic 损失更大"从推论升格为论文自身立场;RCT 无显著提速 vs 文献提速(Peng 55.5%/Cui 26.8%)↔ 任务新旧边界
- 无新矛盾;待核不变(METR impact-of-ai、Wharton 全文);新增待核: 六模式在真实纵向场景的分布、agentic 工具直接实验(均论文 future work)

## [2026-08-04] ingest | LLMs reward expertise(Goedecke 第 6 源)

- 源文档: raw/LLMs reward expertise.md;发布 **2026-07-24**(站点页头核实),抓取/摄入 08-04;源页按发布日命名 2026-07-24-llms-reward-expertise
- 核心: ①核心论点 = 领域专长是最重要的提示技能("LLM 奖励专长")——同模型,懂行的人榨出的价值更高;对许多任务**人=瓶颈而非模型**(信息"已在模型里",要懂行的人拉出来);专长随模型变强继续有用 ②Tao×ChatGPT(Jacobian 猜想反例对话)五观察:短准消息只回主旨/**mode shunting**(信号专长把模型推入"与数学家对话"模式,输出更简洁)/推回式纠错("这看起来比我期望的更复杂")/自导下一步几乎不采纳模型建议/但技巧不可复制——关键是懂数学本身 ③理论=推模型的杠杆("不,可以更简单""我们不是已经做了 X 吗""能用熟悉的术语表达吗");具体细节主导设计("X 在这里有效吗"只有懂系统的人能问) ④无专长时抱 LLM 至少得 something"并不坏",多数人混合两种模式
- 新建 2 页: sources/2026-07-24-llms-reward-expertise(第 44 源)、concepts/expertise-leverage(专长杠杆)
- 更新 4 页: sean-goedecke(第 6 源+新论点)、theory-building(应用延伸:理论=LLM 使用杠杆)、cognitive-surrender(镜像:steering 而非 surrender)、ai-feature-implementation-loop(理解力层+专长杠杆层)
- 主题页: 44 份;Goedecke ×6;开放问题 +1(专长杠杆量化/mode shunting 机制验证)
- 关键互证: 专长杠杆 ↔ RCT 六模式(高分 Generation-Then-Comprehension 86% = 专长驱动使用 vs 低分 AI Delegation 39% = 零专长委托)——理论陈述遇实验证据;与 cognitive-surrender 互为镜像(同模型同输出,区别在用户是否带理论进场);**自噬张力**:专长让 AI 使用更有效,但 AI 使用侵蚀专长(RCT -17%)——"LLM 双刃剑"在使用侧收敛;传达"想要什么"=瓶颈 ↔ intent-debt(意图外部化是唯一必须源于人的输入)
- 无新矛盾;待核不变;新增待核: 文内两篇未摄入(ai-makes-weak-engineers-less-harmful、you-cant-design-software-you-dont-work-on)+ 同标签相关文(开权重逃逸)可作潜在新源

## [2026-08-04] ingest | AI makes weak engineers less harmful(Goedecke 第 7 源)

- 源文档: raw/AI makes weak engineers less harmful.md;发布 **2026-05-09**(站点页头核实),抓取/摄入 08-04;源页按发布日命名 2026-05-09-ai-makes-weak-engineers-less-harmful;上一源(llms-reward-expertise)文内引用的"无专长不坏"出处,现在一手化
- 核心: ①工程能力**重尾分布**,弱工程师传统净负(Jane Street 式小而贵团队;tech lead 保证关键部分交到不会搞砸的人手里) ②Claude Code **抬高弱工程师地板**:最差 PR 从"绝不可能工作"变"标准 LLM PR"(逐行功能正常);故意犯明显错误 agent 硬推回,但漏"需要理解代码库其他部分"的微妙错误 ③Claude-over-Slack 协作:恼人但边际正("更多算力投入你的问题比更少好") ④**三输+价值追问**:本人学更少/公司付人类薪水得 Copilot 订阅/"AI 给工程师加的价值"之后必有"工程师给 AI 加的价值"追问→失业风险 ⑤**自我选择边界**:没有强工程师薄包装化(基线品味抓 AI 错误),现象限于"对其产出是改进"的净负工程师;脚注自疑:LLM 输出持续优于自己+留神它哪里更好=可能是好的学习方式(skill atrophy 判断的限定)
- 新建 1 页: sources/2026-05-09-ai-makes-weak-engineers-less-harmful(第 45 源;不新建概念页——折入既有三页)
- 更新 4 页: sean-goedecke(第 7 源)、expertise-leverage("无专长不坏"机制:地板抬高+边界,弱端托底/强端放大)、cognitive-surrender(组织级形态:薄包装=决策缺席界面化;对从未有独立观点者=托底非投降)、agentic-engineering(技能差距组织级印证+雇佣风险)
- 主题页: 45 份;Goedecke ×7;开放问题 +1(薄包装经济学:薪水 vs 订阅错配比例、失业推论证据)
- 关键互证: 薄包装 = RCT 六模式低分组(AI Delegation 39%)的组织形态;"学得更少" ↔ RCT quiz -17%;agent 漏微妙错误 ↔ 战争迷雾;与 llms-reward-expertise 互补(专长杠杆两端:弱端被托底、强端被放大);surrender 概念边界修正——投降预设"有立场可失去",对净负工程师薄包装是地板抬高
- 无新矛盾;待核不变;新增待核: Theo 视频内容、simple-work-gets-rewarded 潜在新源、非工程师薄包装(nooneshappy.com)引证

## [2026-08-04] ingest | Programming (with AI agents) as theory building(Goedecke 第 8 源)

- 源文档: raw/Programming (with AI agents) as theory building.md;发布 **2026-04-03**(站点页头核实,tags: ai, naur theory),抓取/摄入 08-04;源页按发布日命名 2026-04-03-programming-with-ai-agents-as-theory-building
- 核心: ①认同 Naur 程序理论观;第二论辩回应两类批评——\"LLM 让工程师跳过理论构建\":承认心智模型更不详细但非灾难(所有理论本就略过细节,如 breadth of your stack),**80/20/10 评审漏斗**实证(2-3 并行 agent;~80% 被 kill/打回;20% 仔细评审;仅 ~10% 进入产出;拒绝几乎全部 = 理论仍是\"我的\");\"LLM 没有理论\":pattern-match 或**局部理论**(不层层堆叠即可)、日志可见显式理论构建(假设→验证→调整)、调试赛跑\"有时 agent 赢\" ②**关键区分:保留 > 构建**——agent 无法保留理论、每次从零构建(文档\"严格不可能\"完整捕获),\"下一个大创新 = 长期理论保留\":权重内化(continuous learning)或超长上下文 ③脚注 2:全委托 = 薄包装(\"是改进但职业前景不好\")
- 新建 1 页: sources/2026-04-03-programming-with-ai-agents-as-theory-building(第 46 源)
- 更新 4 页: sean-goedecke(第 8 源+第二论辩)、theory-building(主:第二论辩新章节 80/20/10+局部理论+保留 vs 构建)、expertise-leverage(杠杆机制量化:拒绝能力=操作面)、cognitive-surrender(拒绝率=投降测量代理,部分回答投降校准开放问题)
- 主题页: 46 份;Goedecke ×8;开放问题 +1(agent 长期理论保留:权重/超长上下文/文件记忆对比)
- 关键互证: 80/20/10 ↔ 评审经济学(Faros churn/Keep Rate 个人版数字)与 Keep Rate 测量缺口;保留理论 ↔ long-running-agents/file-as-memory/intent-debt(agent 每次从零构建 = 无长期记忆的认知侧表述);局部理论 ↔ in-defense 部分错误理论;引 RCT 总结帖(作者视为权衡非灾难);脚注 2 ↔ 薄包装(05-09 源)
- 无新矛盾;待核不变;新增待核: 80/20/10 为单一样本自报、continuous-learning 与 will-my-job-still-exist 潜在新源、Victor Taelin 推文(怪异代码库理论构建,轶事)

## [2026-08-04] ingest | Mistakes engineers make in large established codebases(Goedecke 第 9 源)

- 源文档: raw/Mistakes engineers make in large established codebases.md;发布 **2025-01-02**(站点页头核实),抓取/摄入 08-04;源页按发布日命名 2025-01-02-large-established-codebases;**目前摄入最早的 Goedecke 源**(纯前 AI,正文零 AI 提及)
- 核心: ①大代码库定义(~5M 行/100-1000 人/≥10 年);**首要错误 = 不一致**(用\"最合理方式\"实现、远离遗留代码)——必须沉入遗留代码库以维持一致性:防地雷(既有功能=穿过雷区的安全路径;bots/代表认证等\"你不知道的事\")/减缓混乱/通用改进前提;不一致 = 负反馈循环(最难 5% 端点被留出范围 → 更不一致) ②操作:prior art 先行/生产足迹(热路径)/测试限制(靠监控)/依赖谨慎/删除代码(先 instrument 驱动调用者到零)/小 PR+前置跨团队改动(领域专家预判) ③**90% 价值辩护**:大公司收入主要来自大代码库(\"这就是你的工作\");**不先理解就无法拆解**(成功拆解者 = 已能流畅内部交付的团队)
- 新建 2 页: sources/2025-01-02-large-established-codebases(第 47 源)、concepts/codebase-consistency(一致性:与 wicked-features 需求侧互补的实现侧原则)
- 更新 4 页: sean-goedecke(第 9 源)、theory-building(一致性=理论的供给侧条件)、pure-impure-engineering(90% 价值=impure 是公司实际工作的论证+\"理解能力是入场券\")、ai-feature-implementation-loop(规范层\"参照既有模式\"获得一手理论依据)
- 主题页: 47 份;Goedecke ×9;开放问题 +1(agent 的一致性维护:让 AI 跟随 prior art;不一致量化检测)
- 关键互证: prior art 安全路径 ↔ 战争迷雾(代码库=唯一可靠答案源);\"不能拆解除非先理解\" ↔ in-defense 切块重写**机制闭合**;不一致负反馈 ↔ wicked 连锁/认知债累积;删除代码(证据化) ↔ agent-verification 验证纪律;小 PR/领域专家 ↔ pr-contract
- 无新矛盾;待核不变;新增待核: \"90% 价值\"为作者经验判断(非数据)、HN 讨论(42627227)可作社区样本、staff-engineer-promotions 潜在新源(弱相关)

## [2026-08-04] ingest | I don't know if my job will still exist in ten years(Goedecke 第 10 源)

- 源文档: raw/I don't know if my job will still exist in ten years.md;发布 **2026-03-06**(站点页头核实,tags: tech companies, ai, zirp),抓取/摄入 08-04;源页按发布日命名 2026-03-06-will-my-job-still-exist;04-03 源的同标签相关文
- 核心: ①自尝苦果:编程的杠杆意义=自动化其他行业,自动化自己=宇宙正义;staff 大概**最后被替换**("为什么雇一群工程师当手,而不花零头租 Claude Opus 4.6 实例?")→ 初级/中级先受苦 ②**超调/欠调框架**:欠调=工作更久但=监督代理群;超调=停止雇人太早→资深需求中期上升 ③**反驳 Jevons**:AI 修 bug/清理=生成能力(一年并行提问体验:无望→有时比我快→通常比我快更有洞察);"没有真正的新能力 AI 代理需要才能取代我——只需更好更可靠" → 需求更可能降
- 新建 1 页: sources/2026-03-06-will-my-job-still-exist(第 48 源;不新建概念页——职业预测折入既有页)
- 更新 3 页: sean-goedecke(第 10 源+立场张力标注)、agentic-engineering(行业级雇佣风险:skill atrophy → 行业收缩风险)、expertise-leverage(乐观/悲观张力:专长决定相对位置,行业收缩是绝对量;Goedecke 2026 立场弧线 03 悲观→07 专长升值)
- 主题页: 48 份;Goedecke ×10;开放问题 +1(Jevons 效应 vs AI 维护能力:Goedecke"通常比我快" vs Faros 评审 +441.5% 的张力)
- 关键互证: staff 最后被替换 ↔ 专长梯度(弱端托底→中级压缩→资深监督);监督代理群 ↔ agent-management/orchestration-tax;初级池枯竭 ↔ distillation-anxiety 培养断裂;"更好更可靠即可" ↔ METR 时间地平线;**分歧记录**:AI 维护=生成能力 vs 评审经济学"写便宜了,理解没便宜"(两侧真实,交汇点未定);**立场张力**:03-06 悲观 vs 07-24 乐观(同一作者)
- 无新矛盾;待核不变;新增待核: why-do-ai-enterprise-projects-fail(95% 失败,MIT NANDA 报告)潜在新源、HN/Reddit/Tildes/lobste.rs 评论样本

## [2026-08-08] ingest | What I learned building an opinionated and minimal coding agent

- 源文档: raw/What I learned building an opinionated and minimal coding agent.md(Mario Zechner 2025-11-30,badlogic/libGDX 作者;自建极简编码代理 pi 的完整复盘)
- 新建 4 页: sources/2025-11-30-opinionated-minimal-coding-agent(第 49 源)、entities/mario-zechner、entities/pi-coding-agent、syntheses/minimal-vs-rich-harness(极简 vs 富 harness 两派全景对比)
- 核心: ①<1000 token 系统提示+四工具(read/write/edit/bash)够用——Terminal-Bench 2.0 五轮跑分上榜(Opus 4.5)+ Terminus 2(纯 tmux、零工具)名列前茅 = 极简可行双重证据 ②上下文工程=一切但"没有任何 harness 真的让你做它"(背后注入+不透明);pi=完全控制+完全可观测 ③反 MCP:Playwright 13.7k/DevTools 18k tokens=7-9% 窗口税,CLI+README 按需读替代(mcporter 兜底) ④反 to-do/plan mode:状态文件化(TODO.md/PLAN.md,跨会话可版本化) ⑤反后台 bash(tmux:可观测+人机协同调试) ⑥反子代理:黑箱中的黑箱;独立会话+工件交接代替;并行子代理=反模式("代码库变垃圾堆") ⑦YOLO 默认:权限弹窗=security theater,能力三元组无解(引 Willison dual-LLM 自评) ⑧实证:"模型被训练成只读片段、不愿读全文→找不全上下文,我们太信任代理了"(pi-mono PR 大量返工) ⑨基准时区效应(CET vs PST 错误率);无 compaction 单会话数百轮
- 更新 9 页: plan-mode(PLAN.md 文件化反论)、model-context-protocol(上下文税反论)、subagents(黑箱批判+独立会话替代)、long-running-agents(to-do 张力)、progressive-disclosure(CLI-README 形态)、agent-computer-interface(输出双通道+流式解析)、context-engineering(完全控制论)、harness-engineering(极简证据+Terminal Bench 数据点)、parallel-agents(并行子代理=反模式);全部标注学派分歧 callout
- 主题页: 49 份源文档;视角 +Zechner(极简派);实证基础 +pi/Terminus 2;Terminal Bench #33 vs #5 开放问题补充极简派数据点;新增开放问题 1 组(极简 vs 富 A/B、to-do 冲突边界、子代理可观测性、读全文假说、规模-学派相关性)
- 关键互证: 极简派 ↔ curse-of-instructions/ETH agentfile/56% 未触发/指令预算/HumanLayer"从简单开始";文件即状态 ↔ file-as-memory;并行反模式 ↔ orchestration-tax;YOLO ↔ Willison dual-LLM 自评;Terminus 2 ↔ 四工具
- 无事实矛盾(学派分歧已标注,未改写旧页);待核: pi 榜单最终名次、Terminus 2 详情、Armin Ronacher《Agents are hard》原文、mcporter 落地
- 元观察: 本 wiki 运行环境即 pi(系统提示/四工具与文章逐字吻合)——本 wiki 的 AGENTS.md 契约/lint.sh/文件即状态实践 = 极简派活证据

## [2026-08-09] ingest | "Code was never the hard part" is an insult to all programmers

- 源文档: raw/Code was never the hard part_ is an insult to all programmers.md;发布 **2026-08-08**(raw frontmatter;blog.senko.net),摄入 08-09;作者 Senko Rašić(克罗地亚 Zagreb,~25 年软件开发者,About 页核实)
- 核心: ①反驳"code was never the hard part/编码容易"话语:经济学论证(高薪/ZIRP 前/leetcode/10x ninja/bootcamp+学位/经典书/Carmack/Bellard/代码被抄会愤怒/软件如此 buggy)——编码=需技能/耐心/细节/经验/智慧的技艺 ②反驳"只有搞清楚做什么才难"单边论(PM 为什么没 10 步面试、没比开发者贵?sales 许诺新功能程序员为何生气?)③"没有中位数程序员":多数程序员不想聊 stakeholder(自由职业者/创始人例外);"我解决客户问题"转身 opine monads/DRY+"affordance=周末零花钱"漫画 = pure/impure 文化碰撞的讽刺画 ④正面立场:**两者都重要(¿Por qué no los dos?)**;任意一端("code is easy"或"code is art 不可自动化")都是 cope ⑤不变:复杂度↑/bit-rot/熵/抽象之塔/用户想要更多付更少且说不清/客户-用户脱节/蛇油贩子永在(VR 文艺复兴还在等)⑥变:行业自我颠覆史(打孔卡→汇编/COBOL→C/C++ 内存战斗(Valgrind/mysql_real_escape_string)→Rust/Go/Python/JS;dBase/Clipper/HyperCard/Access 角落系统仍在跑)⑦thrive:好奇+批判;资深→UX/客户访谈/商业,初级→指针/递归/内存层级/HTTP/leetcode ⑧底线:理解/判断/共情/品味不外包;不 abdicate responsibility;不当 meat proxy
- 新建 2 页: sources/2026-08-08-code-was-never-the-hard-part(第 50 源)、entities/senko-rasic(独立开发者 craft 辩护派;第三种作者背景——大厂 staff Goedecke / 极简 harness Zechner / 话语批判 Senko)
- 更新 5 页: theory-building(外部话语:craft 辩护打极端派稻草人——Goedecke 本已反对激进 Naur 论;两者在"理解系统+理解为什么"一致)、pure-impure-engineering(非 Goedecke 的第三立场"两者都要";分裂人格漫画=文化碰撞;buggy 反问=impure 混战难度另一表述)、cognitive-surrender(判断/共情/品味不外包;meat proxy=投降的职业化命名+签字责任,呼应 pr-contract;offloading 健康面独立表述)、expertise-leverage(独立声音:craft 辩护;thrive 建议=专长养成侧;"难度相对专长水平"细化托底/杠杆不对称)、2026-03-06-will-my-job-still-exist(同构互证:what changes/what doesn't/how to thrive 结构相同,需求收缩 vs 技艺仍相关=不同问题维度)
- 主题页: 50 份源文档;视角 +Senko(craft 辩护派,独立开发者);开放问题 +1(编码难度话语的实证化:托底 vs 侮辱的判据;"软件总 buggy"常识论证 vs 评审经济学的机制缺口)
- 关键互证: "code is easy"论者 ↔ 薄包装/托底(同一现象两种评价:侮辱 vs 地板抬高,调和=难度相对专长水平);不外包 ↔ cognitive-surrender/offloading("AI 给选项我挑选"=健康面);meat proxy ↔ 薄包装同族+签字责任;thrive 建议 ↔ 专长杠杆养成侧;软件总 buggy ↔ 评审经济学"写便宜了,理解没便宜"与 comprehension-debt 维护侧;snake oil 永在 ↔ 代理/基准 hype 批判
- 无事实矛盾(话语层张力已标注:稻草人/侮辱 vs 托底);待核: 无;潜在新源: Senko《your code is your responsibility even if AI wrote it》(责任观姊妹篇)、gruhn.me《meat proxy》(2026-08-03,术语一手化)

## [2026-08-09] ingest | Your code is your responsibility, even if AI wrote it

- 源文档: raw/Your code is your responsibility, even if AI wrote it.md;发布 **2025-09-15**(raw frontmatter;blog.senko.net),摄入 08-09;Senko 第二源
- 定位: [[2026-08-08-code-was-never-the-hard-part|craft 辩护文]] 的**前身**(早近一年)——责任观原发,2026-08 文引用其为底线("don't abdicate your responsibility");上篇源页"未收录待核"标注清除
- 核心: ①**提交即声明**:按 Create PR = attest 完全理解代码在做什么 + 有合法权利提交(不是偷);与工具无关(vibe-coding/AI 自动补全/抄 SO/外包/阿姨帮忙)②操守面:评审/生产代码时作者不知 how/why = red flag;**隐藏 AI/SO/Upwork 使用 = 严重且不可接受的职业操守违规**(未披露比使用更糟)③**例外区间**:spike/原型/throwaway/低影响内部工具可 spaghetti("vibe-code 功能性 mockup?请便");质量与理解要求由场景不由工具决定 ④不可弃责:"The AI wrote it" = "狗吃了我的作业"
- 新建 1 页: sources/2025-09-15-your-code-is-your-responsibility(第 51 源)
- 更新 6 页: pr-contract(**独立提出者:提交即声明**——四字段契约的最小声明版;补合法权利字段/披露义务/例外区间;"狗吃作业"↔人类问责底线同构)、vibe-coding(例外清单独立确认:spike/原型/内部工具;进生产责任照旧)、cognitive-surrender("AI 写的"=投降的现成借口;Create PR 即声明=把理解义务变提交门槛,仪式上截断投降路径)、agentic-engineering(实践四步②的独立表述来源)、senko-rasic(第二源+时间线:责任观 2025-09 → craft 辩护 2026-08)、2026-08-08-code-was-never-the-hard-part(相关文/待办更新)
- 主题页: 51 份源文档;Senko ×2;开放问题 +1(AI 代码披露/标注规范:个体操守端 vs 行业现实灰色带,缺跨公司实证;AI 输出许可证实践)
- 关键互证: 提交即声明 ↔ PR contract 四字段(证据义务的仪式化最小版);例外区间 ↔ Osmani"原型 vibe 没问题,上线切回工程模式";隐藏使用=违规 ↔ 行业普遍未标注(Faros/GitClear 量级)的话语张力;狗吃作业 ↔ "A computer can never be held accountable";解释不了就不该进 ↔ "提交即声明完全理解"
- 无事实矛盾(披露规范张力已标注);待核: gruhn.me《meat proxy》(2026-08-03)仍为潜在新源

## [2026-08-09] ingest | Don't be a meat proxy

- 源文档: raw/Don't be a meat proxy.md;发布 **2026-08-03**(raw frontmatter;gruhn.me),摄入 08-09;作者 Niklas Gruhn(德国,DEV 社区资料;LinkedIn 转述 Tech Manager & SE @ Appliscale,未直接核实)
- 定位: "meat proxy" 术语**一手源**(第 52 源);被 [[2026-08-08-code-was-never-the-hard-part|Senko craft 文]] 引用为底线——提出到被引用仅 5 天;三源互引链闭合(Senko ×2 + Gruhn ×1)
- 核心: ①定义:meat proxy = 人作为 AI 输出与接收者之间的**原样转发层**("Claude said:[整段]"回应 Slack/PR/WhatsApp)——零增值:接收者自己能用 Claude,更快且能控制上下文 ②读 AI 输出是额外努力(冗长/plausible nonsense/术语密集:NATS control-plane events 例,几乎每个词要查)③**证书机制**:prompt 可以,但读、理解、验证后**用自己的话写回复**——自己的话 = 前三步的体面证书 ④**代码评审 = 责任反转**:copy ticket → 不看代码 → 粘贴反馈迭代;谁做了实现?评审者用 Claude Code 做的,作者只是 meat proxy
- 新建 3 页: sources/2026-08-03-dont-be-a-meat-proxy(第 52 源)、concepts/meat-proxy(术语概念化:投降的沟通侧形态;与薄包装同族不同侧——实现 vs 沟通;责任反转冲突 pr-contract"提交即声明完全理解")、entities/niklas-gruhn
- 更新 5 页: cognitive-surrender(meat proxy 标注"未收录待核"清除,链概念页)、2026-08-08-code-was-never-the-hard-part(相关文/待办更新)、2025-09-15-your-code-is-your-responsibility(相关文/待办更新)、senko-rasic(引用 Gruhn 术语)、主题页(第 52 源;视角 +Gruhn)
- 主题页: 52 份源文档;开放问题 +1(meat proxy 可测量性:原样转发率 = 投降的沟通侧代理;与拒绝率/采纳率并列为操作化测量;"自己的话"证书在 CI/自动化评审的形态;审计/合规场景的合法边界)
- 关键互证: 自己的话 ↔ 投降反制启发式("读输出前构建期望")沟通版;责任反转 ↔ pr-contract 知识转移义务/"A computer can never be held accountable";"我能直接问 Claude" ↔ expertise-leverage(代理无专长可加);术语密集 ↔ comprehension-debt(没消化也没降低);评审案例 ↔ vibe-coding 生产零评审形态;薄包装"地板抬高"解读对 meat proxy 不成立(接收端明确零增值)
- 无事实矛盾;待核: 转发在审计/合规场景可能是政策要求的适用边界未讨论;潜在新源: gruhn《What happens at 60% unemployment rate?》(2026-02-22,职业/行业侧)
