---
type: entity
tags: [tool, ai-engineering, anthropic]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-md, agent-verification, plan-mode, skills, subagents, parallel-agents, model-context-protocol, tool-evaluation, harness-engineering]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-05-14-claude-code-large-codebases]
status: active
---

# Claude Code

Anthropic 的代理式编码环境:能读文件、跑命令、改代码、自主工作;与"问答式聊天机器人"相对,是 spec 指南中反复出现的工具案例。

## 关键信息

- 定位:从"你写代码让 AI 评审"变为"你描述,Claude 探索、规划、实现"(来源: [[2026-08-02-best-practices-claude-code]])
- 核心约束:上下文窗口填满很快,性能随填充下降;自动压缩(compaction)保留重要代码/决策
- 扩展体系:[[claude-md|CLAUDE.md]](持久上下文)、hooks(确定性脚本,零例外)、[[skills]](按需领域知识)、[[subagents]](独立上下文)、插件市场、[[model-context-protocol|MCP servers]]、权限模式(auto 分类器/allowlist/sandbox)
- 关键命令:`/init`、`/clear`、`/compact`、`/rewind`、`/goal`、`/btw`、`/code-review`、`/plugin`、`/hooks`、`/context`
- 非交互模式:`claude -p` 可接入 CI/pre-commit/脚本;`--output-format stream-json` 流式输出
- 并行:worktrees(隔离 git checkout)、桌面应用多会话、Web 版(托管 VM)、agent teams(共享任务/消息/team lead)
- 会话持久化:`claude --continue` / `--resume`;checkpoint 可恢复对话/代码(仅跟踪文件编辑工具,不替代 git)
- 工具侧(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]]):工具响应默认 25,000 token 上限;可把评测 transcript 拼接交给 Claude 批量重构工具(工具协作优化角色,见 [[tool-evaluation]])
- 在 [[2026-01-13-good-spec-for-ai-agents|Osmani 的 spec 指南]] 中:Plan Mode 与子代理被引为规划先行/多代理架构的范例工具
- **企业规模部署**(来源: [[2026-05-14-claude-code-large-codebases]],"Claude Code at scale" 系列):官方定位——"模型周围的生态(harness)决定表现的程度超过模型本身";harness 五扩展点按序构建(CLAUDE.md → hooks → skills → plugins → MCP)+ LSP + 子代理两个能力;导航架构 = **agentic search**(本地文件系统遍历/grep,无索引)对比 RAG 工具(embedding pipeline 追不上活跃团队 → 陈旧索引返回已改名函数/已删模块且无过期提示);大规模代码库(百万行 monorepo/数十年遗留/多仓库);LSP 集成给符号级精度(无它则文本匹配落到错误符号);**配置评审每 3-6 个月**(随模型进化:补偿旧模型缺陷的规则/工具在新模型下变约束);组织层:agent manager(混合 PM/工程师)或最小可行 DRI + 先基础设施后开放 + 跨职能工作组治理(见 [[management-collapse]])

## 与其他页面的关系

- 详见 [[claude-md]]、[[agent-verification]]、[[plan-mode]]、[[skills]]、[[subagents]]、[[parallel-agents]]
- 所属公司: [[anthropic]];工具集成协议: [[model-context-protocol]]
