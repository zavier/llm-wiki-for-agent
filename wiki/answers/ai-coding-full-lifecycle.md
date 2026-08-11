---
type: answer
tags: [ai-agents, workflow, learning-path]
topic: ai-agents
created: 2026-08-09
updated: 2026-08-09
refs: [ai-feature-implementation-loop, ai-agent-spec, spec-driven-development, plan-mode, three-tier-boundaries, intent-debt, agentic-engineering, factory-model, context-engineering, context-rot, curse-of-instructions, subagents, orchestration-tax, expertise-leverage, 2026-01-28-skill-formation-rct, cognitive-surrender, comprehension-debt, process-over-prose, harness-engineering, agent-management, pr-contract, conformance-testing, llm-as-a-judge, agent-verification, codebase-consistency, ralph-loop, agentic-memory]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-02-25-factory-model-coding-agents, 2026-02-04-agentic-engineering, 2026-01-28-skill-formation-rct, 2026-07-24-llms-reward-expertise, 2026-05-05-cognitive-surrender, 2026-06-05-intent-debt, 2026-05-24-orchestration-tax, 2026-08-02-building-ai-native-engineering-team, 2026-03-12-skill-issue-harness-engineering, 2025-01-02-large-established-codebases, 2026-05-03-agent-skills, 2026-05-14-claude-code-large-codebases]
status: active
---

# AI coding 全流程设计、开发、验证的体系化能力建设

> 切面:与 [[ai-coding-vs-traditional-development]](AI coding 相比传统开发解决什么、新增什么)互补——那条讲"为什么",这条讲"怎么做 + 学什么"。

## 回答

核心主线:让 AI 高质量交付的关键不是"更聪明的提问",而是把功能拆成**「意图 → spec → 计划 → 小任务 → 自检 → 反馈」的闭环**,在每个环节消除歧义、控制上下文、锁定验收标准(综合论证见 [[ai-feature-implementation-loop]])。实现失败的四大主因——模糊输入、过载输入、无验收标准、无反馈回路——每条都对应闭环中的一个动作。

### 一、需求设计与设计 (意图 → spec → 计划)

- **写清楚 why**:*为什么* 是模型唯一只能捏造的东西,人写意图是流程里不可外包的一环([[intent-debt]])。
- **spec 六区域清单**:目标(愿景与验收)、上下文(背景与约束)、非目标、依赖、验收标准(Success 节)、边界;用 [[three-tier-boundaries|三层边界]] 限定行为;注入领域知识("products-categories 是多对多,别让 AI 猜");大任务先让 AI 采访你(AskUserQuestion → SPEC.md)。框架见 [[ai-agent-spec]]。
- **计划纳入流程**:[[plan-mode]] 先探索后规划再编码;小任务(能一句话描述 diff)跳过计划(见 [[spec-driven-development]])。

### 二、开发

- **上下文为主战场**:JIT 检索 + 只喂相关切片 + compaction/重启;任务间用 `/clear`;让 [[subagents]] 去做隔离探索(见 [[context-engineering]]、[[pi-coding-agent|极简派]] 的工件文件法,见 [[context-engineering]]、[[agentic-memory]])。
- **任务切分**:拆成可独立测试的小任务(如"建注册端点并校验邮箱"),一次只喂一个任务。
- **触发失败的护栏**:厨房水槽会话(混入无关问题)→ 任务间 `/clear`;反复纠正(连续两轮仍错)→ 重开 + 重写初始 prompt;过度规格化(文件太长被忽略)→ 剪枝或转 hook 确定性执行。常见失败模式与修复见 [[ai-feature-implementation-loop]]。

### 三、验证(真正的瓶颈)

- 生成不再是瓶颈,**验证是**([[factory-model]]);可靠性的来源是给代理"你能运行、能验证"的检查,不是让它发誓([[process-over-prose]])。
- 门禁四档(见 [[agent-verification]]):同 prompt 跑测试 → `/goal` 停止条件 → Stop hook 确定性守卫 → 独立评审子代理("干活的不给自己打分")。
- **测试 = 事实源**([[conformance-testing]]):toBe 红/绿的验收标准写在前面;测试先行在舰队规模下从好实践降为强制(红/绿 TDD)。
- 证据而非断言:要求代理输出证据(测试通过记录、运行产出)而非"看起来对";人始终 exec in the loop(评审 = 安全系统)。
- 自评偏差:代理系统性自我感觉乐观,LLM-as-a-Judge 与自验证存在共同盲区 → 独立评审必要。

### 四、全流程的血流:反馈闭环

测试失败 → 修 spec 或 prompt → 重新同步代理;spec 是活文档;成功路径与失败模式沉淀为 [[skills]]。失败的修复看得更细在 [[ai-feature-implementation-loop]] 的"失败模式与闭环修复"节。

## 体系化能力建设:六块素养(不是"学提示词")

1. **领域专长**:AI"奖励专长"——同模型,懂领域的人潜力上限和效率更高;设计决策里"知道 X 在这里不适用"这类问题只有懂系统的人能问([[expertise-leverage]])。
2. **意图外化 + 纪律**:把想法写成 spec / 决策日志,用工作流 + 检查点 + 退出标准约束代理——"把纪律编码成代理无法说服自己绕开的东西"([[intent-debt]]、[[process-over-prose]]、[[anti-rationalization-tables]])。
3. **验证手艺**:测试编写 + 验收标准、红/绿 TDD、小 PR = 可读 diff = 设计约束;自己的验证能力是整条流水线的出货口([[conformance-testing]]、[[pr-contract]])。
4. **harness 工程**:Agent = Model + Harness;逐步搭建 配置文件 / hooks / skills / MCP,让规则自身可执行、可版本化([[harness-engineering]]、[[2026-05-14-claude-code-large-codebases|Claude Code at scale]])。
5. **评审 / 编排 / 管理**:delegate–review–own 三分法 + 批量评审 + 按评审率缩放舰队——编排名单的上限是你的串行评审吞吐([[agent-management]]、[[conductor-orchestrator]])。
6. **个人认知防线**:防认知投降(先构建期待、让模型反驳自己、识别疲劳),护住理解能力——RCT 显示 AI 使用使概念理解/阅读/调试受损(-17%),保持"先理解再委托"的节奏([[cognitive-surrender]]、[[2026-01-28-skill-formation-rct]])。

## 能力建设路线

| 阶段 | 目标 | 标志 / 里程碑 |
|---|---|---|
| 0: 单兵 | 熟悉工具、上下文工程、`/clear` 纪律 | 能稳定跑通"小任务 → 测试 → 提交" |
| 1: 闭环 | 完整走一遍  意图/设计→实现→验证 的门禁流 | 一次 5k+ 行变更在独立评审后落地 |
| 2: 复用 | SPEC/skill/hook 沉淀成可复用资产 | 同一规范能在不同 repo 复用,越跑越稳 |
| 3: 规模化 | 多代理 / 并行工作;按评审吞吐调舰队 | 批量评审成为流程常态而不是负担 |
| 4: 组织 | 知识资产继承、配置定期评审(3-6 月) | 团队走通 agent 原生开发而不靠个体英雄 |

核心论断:**真正稀缺的不是提问技巧,而是"持续判断 + 理解不腐烂"。** 能力建设聚焦在两件事:一是把意图外部化到 spec / 文档 / 测试里(让代理可执行、可验证);二是保护"人作为最终评审与理解环"的质量(证据标准 + 认知防线)。这样才谈得上"体系化"——否则只是碰运气式调用 [[ai-coding-vs-traditional-development]]。

## 背景问题

- 记录时的问题:"想要利用好,使用好AI coding来进行整体需求全流程的设计、开发、验证,有哪些需要学习和注意的点?有什么体系化的能力建设吗?"
- 当时的 wiki 状态:52 份源文档已摄入;综合页 [[ai-feature-implementation-loop]] 已覆盖规范→落地的闭环与失败模式;answers 已有 [[ai-coding-vs-traditional-development]](相比传统开发),本页定位为"全流程实践路线图 + 能力建设框架"。