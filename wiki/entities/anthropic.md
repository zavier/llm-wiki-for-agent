---
type: entity
tags: [organization, ai-engineering]
topic: ai-agents
created: 2026-08-02
updated: 2026-10-15
refs: [context-engineering, llm-as-a-judge, claude-code, claude-md, skills, subagents, agentic-systems, hive-mind, alibaba, artifact-chain, governance-as-code, control-bands, official-sdlc-guides, agent-evals, agent-containment, lethal-trifecta, harness-engineering]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-08-02-building-effective-ai-agents, 2026-08-02-equipping-agents-with-agent-skills, 2026-05-08-ai-native-organization, 2026-08-21-ai-native-sdlc-playbook, 2025-11-04-code-execution-with-mcp, 2025-11-24-advanced-tool-use, 2026-01-09-demystifying-evals-for-ai-agents, 2026-01-21-ai-resistant-technical-evaluations, 2026-02-05-infrastructure-noise, 2026-03-06-eval-awareness-browsecomp, 2026-04-08-scaling-managed-agents, 2026-05-25-how-we-contain-claude]
status: active
---

# Anthropic

Claude 与 Claude Code 背后的 AI 公司;贡献了有效上下文工程、Skills、子代理、Plan Mode 等被 spec 指南采纳的模式。

## 关键信息

- **有效上下文工程**:建议把 prompt 组织成明确分区(`<background>`、`<instructions>`、`<tools>` 等),给模型强结构线索;并指出"minimal does not necessarily mean short"——该给的细节要给,但要聚焦(来源: [[2026-01-13-good-spec-for-ai-agents]])
- **Skills 系统**:可复用的 Markdown 行为定义,代理按需调用,与 spec 流程互补
- **Claude Code 子代理**:各自独立的上下文窗口、自定义 system prompt,主代理按领域委派,小上下文 + 专注角色提升准确度、支持并行
- **Plan Mode**(Claude Code 内 Shift+Tab):只读规划模式,先分析代码库出计划、对齐后再写码——spec 指南中"规划先行"的推荐工具
- **Claude Code 扩展体系**(来源: [[2026-08-02-best-practices-claude-code]]):[[claude-md|CLAUDE.md]] 持久上下文、hooks(确定性脚本,零例外强制执行)、[[skills]](SKILL.md 按需加载)、[[subagents]](独立上下文/工具/模型)、插件市场(/plugin)、[[model-context-protocol|MCP servers]]
- **auto mode**:独立分类器模型审批命令,拦截范围升级/未知基础设施/敌意内容驱动的动作,例行工作免打扰
- **agent teams**:多会话自动化协调(共享任务、消息、team lead),长时无人值守循环可用
- **内置 /code-review skill**:新鲜子代理上下文里审查当前 diff 找 bug
- **工程方法论**(来源: [[2026-08-02-building-effective-ai-agents]]):提出 [[agentic-systems|agentic systems]] 分类(workflows vs agents)与五种工作流模式;三原则——简单性、透明性(显式展示规划步骤)、精心打磨 [[agent-computer-interface|ACI]];立场:先找最简单方案,从 LLM API 直接开始
- **Skills 开放标准**(来源: [[2026-08-02-equipping-agents-with-agent-skills]]):2025-12-18 发布为 agentskills.io 开放标准,支持 Claude.ai/Claude Code/Agent SDK/Developer Platform(见 [[skills]])
- 与 GitHub 的 [[agents-md]] 思路互补:用规范文件定义代理行为
- **Hive Mind 文化**(来源: [[2026-05-08-ai-native-organization]],二手转述 Yegge):外部观察称 Anthropic"几乎肯定有比任何公司都精密的 Harness,但在 Harness 之上选择运行混乱的文化"——双层组织的原型案例(精密底层 + 松散上层,见 [[hive-mind]])

- **官方 SDLC playbook(2026-08-21)**:六阶段(Plan/Design/Build/Test/Deploy/Maintain)+ 16 plays 的全流程框架——官方立场:提交工件链(intent/spec/plan/diff/PR/incident,见 [[artifact-chain]]);**skill 建议层 + hook 确定层 + managed settings 强制层 + OTel 证据层**(见 [[governance-as-code]]);逐 play 领先/滞后指标;Stage 6 控制带闭环(见 [[control-bands]])与 Claude Tag / Claude Security 的自治形态;官方文档(保守闭环+满治理门)与内部实践(托管评审、值班代理)存在"对外保守/内部激进"张力,与 OpenAI 同构(见 [[official-sdlc-guides]])

- **工程博客四条主线(2025-11 → 2026-05)**:除早期的 agentic systems 分类学与上下文工程外,官方在四个月内又公开了四条独立的工程线:
  1. **工具规模化**——把"按需发现 + 代码调用"做进平台层:`defer_loading` / Tool Search Tool / Programmatic Tool Calling / Tool Use Examples(见 [[agent-computer-interface]]),以及把 MCP server 呈现为代码 API 树(见 [[model-context-protocol]]);实测**工具定义从 58 工具≈55K → ~8.7K(-85%)且准确率上升**
  2. **评测学**——从 agent evals 方法论([[agent-evals]])到评测自身的失效:基础设施噪声([[2026-02-05-infrastructure-noise]])、模型识破评测并解密答案键([[2026-03-06-eval-awareness-browsecomp]])、AI 抗性技术评测([[2026-01-21-ai-resistant-technical-evaluations]]);最硬的一条自曝:Opus 4.5 在 CORE-Bench 上初始 42%,修好 grader 后 95%
  3. **围堵与安全**——首次系统公开 blast radius 工程:三类风险 × 三层组件 × 三种隔离模式(见 [[agent-containment]]);自曝用户批准率 **93%**、沙箱化后提示降 **84%**、auto mode 拦 **~83% 但漏 ~17%**、钓鱼 prompt **25 次重试 24 次外传**
  4. **harness 维护的元规则**——组件会随模型升级成为死重、删除要一次一个、会话≠上下文窗口(见 [[harness-engineering]]、[[agentic-memory]])
- 方法学上的自我限定值得单独记:官方多篇明确写下自家 eval/benchmark 的不可全信条件(leaderboard 差距 <3pp 应存疑;0% pass@100 多半是任务坏了),这在厂商材料里少见(见 [[agent-evals]])

## 与其他页面的关系

- 详见 [[context-engineering]]、[[llm-as-a-judge]]
- 工具模式支撑 [[ai-agent-spec]] 的规划先行原则
