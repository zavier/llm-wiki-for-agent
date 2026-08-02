---
type: source
tags: [ai-agents, harness, configuration, humanlayer]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Skill Issue: Harness Engineering for Coding Agents (2026-03-12)

- 原文: `raw/Skill Issue_ Harness Engineering for Coding Agents.md`
- 类型: 技术博客(HumanLayer,作者 Kyle;**发布于 2026-03-12**,frontmatter 已标注)
- 备注: 本 wiki 第十九篇源文档;**"skill issue"框架的出处**(Osmani 的 harness 工程文直接引用了它);独立产品公司视角(人类审批基础设施),大量 brownfield 企业级代码库实战;与 Viv Trivedy、Dex Horthy(12-factor agents)同话语圈

## 摘要

一年来观察编码代理以各种方式失败(无视指令、未提示执行危险命令、最简单任务绕圈),结论始终一致:**不是模型问题,是配置问题**——意外失败模式是非确定性系统的根本问题,等 GPT-6 不如用好今天的模型。harness 工程(维 Viv 命名)是"利用配置点定制编码代理以提升输出质量与成功率"的实践;本文逐一走过六个配置面:AGENTS.md/CLAUDE.md、MCP、skills、子代理、hooks、回压,并给出"什么没用/什么有用"的经验清单。

## 关键主张

- **定义**:coding agent = AI model(s) + harness;harness = 代理的运行时/外设(配置面:skills、MCP、子代理、记忆、AGENTS.md);Mitchell Hashimoto 表述:"每次代理犯错,花时间设计一个让它永不再犯同样错误的方案";harness engineering 是 **context engineering 的子集**(Dex Horthy 的 12-factor agents 框架):主要涉及用配置点管理编码代理的上下文窗口——新能力、代码库知识、超越 "CRITICAL: always do XYZ" 的确定性、防止上下文快速膨胀
- **六个配置点**,Viv 四个杠杆(系统提示/工具 MCP/上下文/子代理)+ 两个补充(**hooks** 确定性控制流、**skills** 渐进披露——Dex 称"指令模块")
- **后训练耦合的双刃**:模型在后训练的 harness 上表现好(Codex 模型与 `apply_patch` 工具强耦合,OpenCode 得为 GPT/Codex 模型加 apply_patch 工具,而 Claude 用普通 edit/write)——**但模型会被 harness 过拟合**:Terminal Bench 2.0 上 Opus 4.6 在 Claude Code 里排 **#33**,换到后训练未见过、专门调优的 harness 排 **#5**(±4)(与 Osmani 的 Top 30→Top 5 同源,给出精确名次)
- **AGENTS.md/CLAUDE.md**:其他配置前先定制;确定性注入系统提示;**ETH Zurich 研究**(arXiv 2602.11988,一手已核: [[2026-02-12-evaluating-agents-md]];138 个 agentfile 跨多仓库):多数无用或有害——LLM 生成的反而**损害性能且贵 20%+**(一手口径 -0.5%/-2%,见新 source 页数字协调);人工写的只提升约 4%;代理多花 14-22% reasoning token 处理上下文指令、步骤更多、工具更多,**成功率没有提升**;代码库概览与目录列表完全没用(代理自己能发现仓库结构);HumanLayer 认为该研究印证其既有建议:不要自动生成、少即是多、用渐进披露、内容简洁普遍适用;**其 CLAUDE.md 压在 60 行内**
- **MCP 是给工具的**:resources/prompts/elicitations 支持不佳;工具描述注入系统提示 → **绝不连接不信任的 MCP(prompt injection 向量;STDIO 服务器可执行宿主机代码)**;**工具太多是坏事**:描述填满上下文 → 进入"愚蠢区"(instruction budget,每一条无关工具描述都是无收益的指令);Anthropic 已发布实验性 **MCP tool search** 做工具渐进披露;不用的多工具服务器就关掉;**CLI 优先**:如果 MCP 复制了训练数据里表现良好的 CLI(GitHub/Docker/数据库),直接用 CLI——模型已会用它,还获得与 grep/jq 组合的上下文效率;Linear 例:自写 CLI 包装 + CLAUDE.md 里 6 条示例用法,省下数千 token 的工具定义与冗长响应
- **Skills 是可复用知识(与工具)**:开放标准(Codex/OpenCode 支持);激活机制(SKILL.md 以用户消息载入,告知目录,可捆绑文件实现多层披露);**不能直接捆绑 MCP/自定义工具,需写成可执行文件/CLI/NPM 包**(例:BrowserBase agent browser skills、Vercel agent-browser CLI 替代 Playwright MCP);**供应链警告**:skill 注册表已被发现分发数百个恶意 skill(ClawHub),按 `npm install random-package` 的标准对待——skill 可在你的机器上执行任意代码
- **子代理是上下文控制**:人格化子代理("前端工程师"/"后端工程师")**不work**;管用的是**上下文防火墙**——隔离整个会话,父代理只见 prompt 与最终结果,中间工具调用/结果不进父上下文;Chroma context rot 研究佐证(18 模型 needle-in-a-haystack;低语义相似度时退化更陡;干扰项在长上下文下**复合**);**对长上下文模型持怀疑**:"更大的窗口不能让你更会找针,只是把干草堆变大"(YaRN 类扩展);子代理每个获得**全新小窗口 + 全新指令预算**,只回流浓缩结果;子代理应用例:定位定义、分析模式、跨服务追踪、研究——问题简单但中间调用多;返回带 `filepath:line` 引用的高度浓缩答案(渐进披露);**成本控制**:Opus 管规划/编排,子代理用 Sonnet/Haiku 处理小而离散的任务;Codex 直到最近才支持子代理(实验性);不支持时可用 **MCP 服务器包装子代理模式**(claudelayer 参考实现),但注意"传话游戏"风险与 MCP 超时;子代理 system prompt 要写清:角色(做什么**与不做什么**)、返回什么**与怎么返回**、给什么工具
- **Hooks 是控制流**:Claude Code hooks/OpenCode plugins(Codex 没有等价物);事件触发、可静默运行、可在工具调用时返回额外上下文、可把构建/类型错误**在代理完成前**亮出来强迫它继续修;用例:通知(完成/待审批提示音)、审批(自动拒绝跑迁移的 Bash 调用并指示转人工)、集成(Slack/PR/预览环境)、**验证**(每次停止时跑 typecheck/build);示例 hook:biome 格式化 + TS typecheck,**成功完全静默,失败只输出错误并以 exit 2 让 harness 重新接续代理**
- **回压(back-pressure)是最高杠杆**:任务成功率与"代理能否验证自己的工作"强相关;机制:强类型语言 typecheck/build、单测/集成测试、覆盖率报告(Stop hook 提示补)、UI 测试(playwright/agent-browser);**验证必须上下文高效**——早期每改必跑全量测试,4,000 行通过输出淹没上下文,代理丢失任务线索开始对刚读过的测试文件产生幻觉;现在**吞掉输出,只浮出错误**——成功静默、失败冗长
- **经验清单**:**没用**——没遇到真实失败前设计理想 harness、装一堆"以防万一"的 skills/MCP、每会话末跑全量测试(5+ 分钟)、微调子代理的工具访问(工具 thrash 反而更差);**有用**——从简单开始、失败后按需加配置、设计-测试-迭代并扔掉(扔掉的多于在用的)、仓库级配置分发实战验证的配置、优化迭代速度而非"一次做对"、先给能力再收窄暴露面
- 结论:"下次代理表现不佳,先检查 harness。模型大概没问题,只是 skill issue。"

## 与现有 wiki 的关系

- 新建实体: [[humanlayer]]
- 更新了 [[agents-md]](ETH Zurich 研究)、[[subagents]](上下文防火墙)、[[agent-verification]](回压)、[[context-engineering]](指令预算/愚蠢区/长上下文怀疑)、[[harness-engineering]](精确名次 + 供应链 + 经验清单)、[[skills]](恶意注册表 + 工具分发)、[[ai-feature-implementation-loop]](实证层)
- 与既有互证:Terminal Bench #33/#5 是 Osmani"Top 30→Top 5"的原始精确化;"成功静默、失败冗长" ↔ Osmani harness 文与 Cursor 护栏史;指令预算/愚蠢区 ↔ [[context-rot]] 与 [[curse-of-instructions]];子代理=上下文防火墙 ↔ [[subagents]] 与 [[context-engineering]] 长时任务三技术;ETH 研究 ↔ OpenAI AGENTS.md 四败因与 HumanLayer <60 行三方互证;MCP/skill 供应链 ↔ MCP prompt-injection 风险([[harness-engineering]] 已记录)的扩展(恶意 skill 注册表)

## 待办 / 后续

- 核实 Terminal Bench #33/#5 原始数据;Chroma context rot 研究原文(ETH agentfile 研究已一手化 ✓: [[2026-02-12-evaluating-agents-md]])
- Anthropic MCP tool search 的进展与效果(工具渐进披露的触发机制);恶意 skill 注册表的后续
- 12-factor agents(Dex Horthy)框架的跟进;HumanLayer 后续文章(上下文高效回压、好 CLAUDE.md)
