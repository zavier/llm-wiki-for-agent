---
type: concept
tags: [ai-agents, architecture]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, anthropic, parallel-agents, context-engineering, multi-agent-systems, humanlayer, loop-engineering, agent-teams, pi-coding-agent]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents, 2026-08-02-effective-context-engineering-for-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2026-03-12-skill-issue-harness-engineering, 2026-05-14-claude-code-large-codebases, 2026-06-07-loop-engineering, 2026-03-26-code-agent-orchestra, 2025-11-30-opinionated-minimal-coding-agent]
status: active
---

# Subagents

在主对话之外运行、拥有独立上下文窗口与工具集的专职子代理;主代理按需委派,回报摘要,不污染主上下文。

## 关键信息

- 配置:`.claude/agents/<name>.md`,frontmatter 指定 name/description/tools/model(如 security-reviewer:Read/Grep/Glob/Bash + opus),正文是"人才画像"式 system prompt(来源: [[2026-08-02-best-practices-claude-code]])
- 三大用途:
  1. **调查**:读大量文件的研究任务("用子代理调查认证系统如何处理 token 刷新")——文件读取不占主上下文
  2. **验证**:实现后独立评审("用子代理审查这段代码的边界情况")
  3. **对抗性评审**:新鲜上下文里只看 diff 与给定标准,不被"实现者的推理"带偏;报告 gap 而非风格偏好;只标影响正确性/需求的 gap,避免追逐导致过度工程
- 上下文是最根本约束,子代理是应对它的最强工具之一
- 上下文技术视角(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):子代理架构是长时任务的第三种绕过窗口限制的方式——每个子代理可用数万 token 深度探索,只回 1,000-2,000 token 的浓缩摘要;Anthropic 多代理研究系统相对单代理有实质提升(见 [[context-engineering]])
- 多代理系统案例(来源: [[2026-08-02-how-we-built-our-multi-agent-research-system]]):Claude Research 的 subagents 并行探索+压缩;委派需明确 目标/输出格式/工具与源/任务边界(模糊指令→重复劳动);数量按查询复杂度缩放;子代理 3+ 工具并行调用;长时任务可"输出直写文件系统、只传引用"避免传话游戏(见 [[multi-agent-systems]])
- 在 [[2026-01-13-good-spec-for-ai-agents|Osmani 指南]] 中:多代理架构的构件——各自独立上下文、专注角色提升准确度、支持并行;可与 spec 切片一一对应(数据库设计师子代理/API 编码子代理)
- 注意:子代理回报的是摘要,主代理看不到其完整推理
- **探索与编辑分离**(来源: [[2026-05-14-claude-code-large-codebases]],Anthropic 官方):harness 就位后,团队用**只读子代理映射子系统、发现写文件**,主代理带完整图景再编辑——"在同一会话里探索+编辑"被列为最常见的子代理误区;大代码库下与"调查→验证→实现"的委派模式互补(见 [[agent-verification]])
- **循环内 maker/checker 分裂**(来源: [[2026-06-07-loop-engineering]],Osmani):循环中最有用的结构——"写码的模型给自己的作业打分太 nice 了";常见三分:探索/实现/对照 spec 验证;Codex 侧 TOML 子代理(`.codex/agents/`)可指定 name/description/instructions/**model + reasoning effort**(安全审查员 = 强模型高 effort,探索者 = 快速只读);`/goal` 内部即此模式的自动化版——新模型决定循环是否结束(分裂应用到停止条件本身);子代理烧更多 token,"花在值得为第二意见付钱的地方"(见 [[loop-engineering]])
- **报告文件交接与层级子代理**(来源: [[2026-03-26-code-agent-orchestra]]):Link Shelf 案例——Data/Logic 子代理各产出 DATA.md/LOGIC.md 报告,API 子代理读报告后开工(**文件式交接工件**,成本中性 ~220k tokens);**层级子代理(teams of teams)**:父只派生 feature lead,各自再派生 2-3 专家——分解深度 3× 不炸父上下文,模拟真实组织(VP → tech leads)(见 [[agent-teams]])
- **极简派批判与替代**(来源: [[2025-11-30-opinionated-minimal-coding-agent]],[[pi-coding-agent]]):子代理 = "黑箱中的黑箱"——编排代理决定传什么初始上下文、你零可见性、出错难调试、上下文交接差。替代:**要隔离上下文就开独立会话,先收集上下文、产出工件,再在干净会话里复用**(与上面的文件式交接同构,但把"隔离"从会话内结构移到会话间结构);需要委派时让代理以 bash 自派生(`pi --print`,自定义 slash command 模板,可指定模型/思考级别,输出全可观测)。**并行派生多个子代理实现功能 = 反模式**——"除非你不介意代码库变成垃圾堆"(见 [[parallel-agents]])。补充实证:模型被训练成只读文件片段、不愿读全文,找不全上下文——pi-mono 的 PR 大量因代理没 grasp 全貌被返工("我们太信任代理了")。

> [!warning] 学派分歧:上下文防火墙价值(Anthropic/Osmani/HumanLayer) vs 黑箱不可接受(pi)——隔离与可观测性难以兼得,极简派选"会话级隔离 + 文件工件",富学派选"会话内隔离 + 摘要回流"(见 [[minimal-vs-rich-harness]])。
- **上下文防火墙**(来源: [[2026-03-12-skill-issue-harness-engineering]],HumanLayer):子代理的本质用途是**上下文控制**,不是人格分工——"前端工程师"式人格子代理不 work;中间工具调用/结果一律不进父上下文,父只见 prompt 与最终结果;每个子代理获得**全新小窗口 + 全新指令预算**,浓缩结果回流(带 `filepath:line` 引用,遵循渐进披露);**成本控制**:Opus 管规划/编排,子代理用 Sonnet/Haiku 处理小而离散的任务;不支持子代理的 harness 可用 MCP 服务器包装模式(注意"传话游戏"与超时);子代理 system prompt 三要素:角色(做什么**与不做什么**)、返回什么**与怎么返回**、给什么工具;对长上下文模型的怀疑论:"更大的窗口不会让你更会找针,只是把干草堆变大"——子代理是结构性的窗口隔离方案(见 [[context-engineering]])

## 与其他页面的关系

- 工具: [[claude-code]];规模化: [[parallel-agents]];公司: [[anthropic]]
- 与 [[agent-verification]]、[[llm-as-a-judge]] 的"第二意见/独立评审"模式相连
