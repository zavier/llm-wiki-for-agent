---
type: entity
tags: [organization, ai-engineering]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [context-engineering, llm-as-a-judge, claude-code, claude-md, skills, subagents, agentic-systems, hive-mind, alibaba]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-08-02-building-effective-ai-agents, 2026-08-02-equipping-agents-with-agent-skills, 2026-05-08-ai-native-organization]
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

## 与其他页面的关系

- 详见 [[context-engineering]]、[[llm-as-a-judge]]
- 工具模式支撑 [[ai-agent-spec]] 的规划先行原则
