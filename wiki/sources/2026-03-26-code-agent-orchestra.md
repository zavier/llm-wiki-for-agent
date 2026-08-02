---
type: source
tags: [ai-agents, multi-agent, orchestration, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# The Code Agent Orchestra — what makes multi-agent coding work (2026-03-26)

- 原文: `raw/The Code Agent Orchestra - what makes multi-agent coding work.md`
- 类型: O'Reilly AI CodeCon 演讲文字稿([[addy-osmani]],发布于 **2026-03-26**,frontmatter 已标注;配套互动幻灯片 talks.addy.ie/oreilly-codecon-march-2026/)
- 备注: 本 wiki 第二十四篇源文档;即 [[2026-06-07-loop-engineering|Loop Engineering]] 引用的 code-agent-orchestra 文;多代理编排的模式全景(子代理 → Agent Teams → 规模化编排)+ 质量门 + 纪律;含 **ETH Zurich 研究精确数字**(与 HumanLayer 同一研究,此处给出归因与量化)

## 摘要

核心转变:**从"指挥"(conductor,一个乐手、实时引导)到"编排"(orchestrator,整个乐团、异步协调)**——六个月前多数开发者与单个 AI 紧密同步循环工作(上下文窗口是硬天花板、对话线程是工作区);现在最高产的开发者协调多个异步代理(各自上下文窗口/文件范围/职责),代码库成为画布。单代理有三堵墙(上下文过载、无专长、无协调);多代理四个**乘法**理由(并行 3×、专长化、隔离、复合学习——"三个专注代理持续胜过干三倍时间的一个通才")。模式谱系:子代理(手动协调)→ 层级子代理(teams of teams)→ Agent Teams(共享任务列表 + 依赖跟踪 + 文件锁 + 对等消息)→ 2026 工具三层谱系(Tier 1 进程内 / Tier 2 本地编排器 / Tier 3 云端异步)。质量三件套:计划审批、hooks、AGENTS.md 复合学习。核心纪律:瓶颈已从生成移到**验证**;"委派任务,别委派判断";"人类瓶颈曾是特性不是 bug"。

## 关键主张与数据

**单代理三堵墙**:①上下文过载(大代码库淹没单一窗口)②无专长(什么都会=什么都不精;只懂 db.js 的代理写出更好的数据库代码)③无协调(帮手之间不能通信/共享任务列表/解析依赖)

**多代理四理由(乘法)**:并行(3× 吞吐)、专长化(聚焦上下文)、隔离(worktree,无合并冲突)、复合学习(AGENTS.md 跨会话累积模式与坑);"三个专注代理持续胜过干三倍时间的一个通才"

**Pattern 1 · 子代理**(最简单,先试):Task tool 派生专责子代理;父代理分解、派生、**手动管理依赖图**;Link Shelf 案例(Express+SQLite):Data 子代理写 db.js 并产出 **DATA.md 报告**,Logic 子代理写 validation.js 产出 **LOGIC.md**,API 子代理读两份报告后写 server.js——报告文件 = 文件式交接工件(成本中性 ~220k tokens);缺失:无对等消息、无共享任务列表、文件作用域粗心会写冲突

**Pro-tip · 层级子代理(teams of teams)**:父代理只派生两个 feature lead,各自再派生 2-3 个专家——分解深度 3× 而不炸父上下文(模拟真实组织:VP 不直接给工程师派活,经过 tech lead 层)

**Pattern 2 · Agent Teams**(Claude Code 实验特性,`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`):三层架构——**Team Lead**(分解/建任务列表/综合结果)+ **共享任务列表**(pending/in_progress/completed/blocked + 依赖跟踪 + **文件锁**)+ **Teammates**(独立 Claude Code 实例,tmux split panes;自认领任务、**对等消息直连不经 lead**、完成自动解锁阻塞任务、Ctrl+T 可视化);hero demo:搜索功能三队友(Backend/Frontend/Test),Test 初始 blocked,Backend 完成并直发 API 契约给 Frontend,Test 自动解锁;**3-5 队友是甜点区,token 成本线性,三个专注队友胜过五个散漫的**;计划审批:写码前先写计划,lead 审批准/拒绝(架构问题在代码存在前被抓)

**可靠性 Pro-tips**:循环护栏 + 强制反思——每个队友硬 `MAX_ITERATIONS=8`,每次重试前强制反思("什么失败了?什么具体改动能修?我在重复同一方法吗?")——**大幅减少卡死代理**(无护栏则无限循环同一错误方法);专职 @reviewer 队友——Claude Opus 4.6(只读)、工具仅 lint/test/security-scan、每次 TaskCompleted 自动触发、1:3-4 构建者比例——lead 只见绿评过的代码("内置的永久 CI 质量门")

**Pattern 3 · 规模化编排(2026 工具三层)**:

- Tier 1 进程内:Claude Code 子代理 + Agent Teams(单终端,零额外工具,从这里开始)
- Tier 2 本地编排器:本机多代理隔离 worktree,仪表盘/diff 审查/合并控制,3-10 代理已知代码库——Conductor(Melty Labs,macOS,免费,3-8 并行特性,diff-first)、Vibe Kanban(解决"doomscrolling gap":代理干活时 2-5 分钟没事干;板上建卡、拖到 In Progress 自动开 worktree、板上审 diff、BYOK 跨平台)、Gastown、OpenClaw+Antfarm、Claude Squad、Antigravity、Cursor Background Agents
- Tier 3 云端异步:派活、合上笔记本、回来收 PR——Claude Code Web(claude.ai/code,云 VM;心智模型:Teams=并肩干活,Web=委派后走开)、GitHub Copilot Coding Agent(issue 派给 @copilot,GH Actions 环境开 draft PR,**自评循环后才找你**;可从 Slack/Jira/Linear/Azure Boards 触发)、Jules by Google(Gemini;计划审批后才写码;音频 changelog、中途打断、自动读 AGENTS.md 零配置)、Codex Web(沙箱容器预载仓库;**verifiable evidence**:每任务返回终端日志与测试输出的引用供审计)
- Cursor Cloud Agents + **Glass**:代理管理成为主界面,编辑器退居其下——"控制平面成为主要体验"的生态趋势
- 大多数人 2026 年三层都用:Tier 1 交互、Tier 2 并行冲刺、Tier 3 夜里清积压

**规模化 Pro-tips**:多模型路由(MODEL_ROUTING.md:规划→Gemini、实现→Opus/Sonnet、评审→专用安全模型);worktree 生命周期脚本(agent-spin/agent-merge/agent-clean,约 12 行 bash);**AGENTS.md 只许人工维护**——ETH Zurich 研究(Gloaguen et al.,一手已核: [[2026-02-12-evaluating-agents-md]]):LLM 生成的 AGENTS.md **无收益且平均成功率 -3%、推理成本 +20% 以上**(一手口径 -0.5%/-2%,见新 source 页);人工写的约 +4%;绝不让代理直接写 AGENTS.md,lead 批准每一行;结构:STYLE/GOTCHAS/ARCH_DECISIONS/TEST_STRATEGY

**质量门(trust but verify)**:计划审批(修坏计划比修坏代码便宜得多;teammate 写计划 → lead 审查 → 批准/拒绝 → 实现);hooks(TeammateIdle 验证测试全过才让停;TaskCompleted 跑 lint+测试,不过就继续干);AGENTS.md 复合学习(每会话读、每会话加:demo 里捕获"给已有表加列必须带 ALTER TABLE 迁移")

**瓶颈转移**:验证而非生成——改动前通过的测试不保证抓回归;代理写"技术上有效但漏关键用例"的测试;40 个代理同时撞同一 flaky 测试 = 系统级阻塞;**在验证基础设施追上生成之前,人工审查不是可选开销,是安全系统**

**Ralph Loop 形式化**(Geoffrey Huntley + Ryan Carson 推广;"shipping while you sleep"背后的模式):五步循环 Pick(tasks.json)→ Implement → Validate(测试/类型/lint)→ Commit(通过才提交并更新状态)→ **Reset(清上下文重来)**——**stateless-but-iterative**:小而有界任务比一个巨型 prompt 产出更干净、幻觉更少;安全网:错误回喂自动重试但 **3+ 卡死迭代即杀并重新指派**、永远在特性分支、硬限制迭代/时间/token、代理开 PR 你审后才合;**四通道记忆**:git 提交历史、进度日志、tasks.json、AGENTS.md(长期语义记忆);从一个循环过夜开始,晋级到十个循环十条分支(工具:snarktank/ralph;Antfarm 在其上叠多代理编排)

**让代理随时间变聪明**:REFLECTION.md 提案(每任务后强制写:什么让我意外/一条可加进 AGENTS.md 的模式/一条 prompt 改进;lead 审查合并)——复合学习的系统化;token 预算与终止标准(前端 180k/后端 280k 预算,85% 自动暂停通知 lead;3+ 卡死杀并换新代理);**Beads/Gastown**:不可变、git 支撑的每条决策与结果的完整 provenance 记录,经任务图与 SQL 可寻址数据平面查询——**不是向量 RAG,是可查询的结构化制度记忆**(见 [[agentic-memory]])

**纪律:人类瓶颈曾是特性,不是 bug**——人速下错误缓慢复合、痛苦迫使早期纠正;代理军团的微小无害错误(代码味道/重复/不必要抽象)以超出你追赶能力的速率复合;"你把自己移出了循环,感觉不到痛苦,直到为时已晚";质量门存在不是因为锦上添花,而是"没有它们你会代理式地把代码写进墙角"

**委派任务,别委派判断**:代理擅长有紧密评估函数的事(样板、迁移、测试脚手架、探索你没时间试的方法);留给自己:架构与 API 设计(代理训练数据里见过大量烂架构,会高高兴兴地把企业模式货搬运进你的创业公司)、决定**不做什么**(说不 = 代理没有的特性)、带全系统上下文的评审(代理只有局部视角);"少建功能,但建对的。代码生成速度是海妖之歌。"

**spec 是杠杆**(舰队版):50 个并行代理下模糊想法乘法式放大——每个并行运行各偏一点;"spec 不是 prompt,是产品思维的外显";强工程师从代理获得**更多**杠杆

**工厂六步流水线**:Plan(带验收标准的 spec)→ Spawn(建团队派活)→ Monitor(每 5-10 分钟解阻塞,别hover)→ Verify(验证是瓶颈)→ Integrate(合并分支)→ Retro(更新 AGENTS.md);实务:WIP 上限(别跑超过你能有意义评审的代理数,3-5 甜点)、终止标准(3+ 卡死即停重派)、异步检查(5-10 分钟)、**一文件一主人**(绝不让两个代理编辑同一文件)

**5 个今天就能开始的模式**:①子代理做分解 ②Agent Teams 做并行 ③worktree 做隔离 ④质量门做信任 ⑤AGENTS.md 做复合学习

## 引用的外部文章(未入库的可作后续源)

- 已入库:good-spec([[2026-01-13-good-spec-for-ai-agents]])、code-review-ai([[2026-01-07-ai-code-review]])、comprehension-debt([[2026-03-14-comprehension-debt]])、agents-md 相关([[2026-02-11-codex-agent-first-engineering]]/[[2026-03-12-skill-issue-harness-engineering]])
- 未入库:future-agentic-coding、coding-agents-manager、agentic-engineering、self-improving-agents、adversarial-code-review、orchestration-tax、agent-skills(Osmani 版)

## 与现有 wiki 的关系

- 新建概念: [[agent-teams]](协调原语)、[[ralph-loop]](stateless-but-iterative 形式化)
- 更新了 [[multi-agent-systems]](指挥→编排、三堵墙、四理由、工具三层)、[[parallel-agents]](WIP/一文件一主人/token 预算)、[[subagents]](报告文件交接 + 层级子代理)、[[agents-md]](ETH 精确数字 + Gloaguen 归因)、[[self-reflection]](循环护栏强制反思 + REFLECTION.md)、[[long-running-agents]](Ralph Loop 形式化)、[[factory-model]](六步流水线)、[[ai-feature-implementation-loop]]
- 关键互证:**ETH 数字精确化**(HumanLayer 的"损害性能且贵 20%+" = 本源的 ~3% 成功率降低 + >20% 推理成本,归因 Gloaguen et al.,arXiv 2602.11988 待核);Agent Teams 的协调原语 = 对 [[multi-agent-systems]]"实时协调委派不成熟"开放问题的直接回应;@reviewer 队友 = [[agent-verification]] 回压的团队形态;Ralph Loop 四通道记忆 = [[file-as-memory]] 与 [[long-running-agents]] 的交叉验证;"人类瓶颈曾是特性" ↔ [[cognitive-surrender]]/[[comprehension-debt]];验证仍是瓶颈 ↔ [[factory-model]];"委派任务不委派判断" ↔ [[intent-debt]] 的意图唯一来源论;2026 工具三层 = 多代理工具谱系的 snapshot(2026-03 时点)

## 待办 / 后续

- ETH Zurich 研究精确数字与归因核实(arXiv 2602.11988,Gloaguen et al.);Agent Teams 正式发布进度(实验特性);Beads/Gastown 的制度记忆形态跟进
- 2026 工具三层谱系的时效性(2026-03 snapshot,需随季度更新);Copilot Coding Agent 自评循环细节
