---
type: source
tags: [ai-agents, claude-code, best-practices]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Best practices for Claude Code (2026-08-02)

- 原文: `raw/Best practices for Claude Code.md`
- 类型: 官方文档(Anthropic,code.claude.com/docs/en/best-practices;无署名与发布日期,按剪藏日期归档)
- 相关: [[claude-code]] 的官方使用指南,基于 Anthropic 内部团队跨代码库/语言/环境的经验

## 摘要

Anthropic 官方 Claude Code 最佳实践。总纲:一切实践源于一个约束——**上下文窗口填满很快,性能随填充下降**。围绕它组织出八大主题:验证闭环、先探索后规划再编码、具体化提示、环境配置(CLAUDE.md/权限/CLI/MCP/hooks/skills/子代理/插件)、有效沟通(问代码问题/让代理采访你)、会话管理(纠正/上下文/checkpoint/续接)、自动化与规模化(并行/非交互/fan-out/对抗评审)、常见失败模式。

## 关键主张

- 上下文窗口是**最重要的资源**:LLM 性能随上下文填充而下降,可能"忘记"早期指令(来源即本页)
- **给代理一个可运行的检查**(测试/构建/截图):"看起来完成"与"验证通过"之别,决定你是旁观者还是验证回路本身;要求**证据而非断言**
- 验证门禁四档强度:同 prompt 迭代 → `/goal` 条件 → Stop hook 确定性门禁 → 独立评审子代理("干活的不给自己打分")
- 规划先行四阶段,但**小任务跳过计划**:"能用一句话描述 diff,就跳过 plan"
- 具体化提示四策略:scope 任务、指向源码、参照既有模式、描述症状;`@` 引用文件、贴图、管道传数据
- CLAUDE.md 是持久上下文但**过长会被忽略**——剪枝规则:"删掉这一行 Claude 会犯错吗?不会就删"
- 采访式开局:AskUserQuestion 采访 → SPEC.md → **新会话**执行(干净上下文 + 书面 spec)
- 失败模式五条:厨房水槽会话、反复纠正、过度规格化 CLAUDE.md、信任-验证鸿沟、无限探索

## 与现有 wiki 的关系

- 更新了 [[anthropic]](扩展体系)、[[context-engineering]](会话级上下文管理)、[[ai-agent-spec]](具体化提示与采访式开局)、[[curse-of-instructions]](CLAUDE.md 证据)、[[ai-feature-implementation-loop]](验证门禁分层与失败模式)
- 新建:[[claude-code]]、[[claude-md]]、[[agent-verification]]、[[plan-mode]]、[[skills]]、[[subagents]]、[[parallel-agents]]、[[model-context-protocol]]
- 与 [[2026-01-13-good-spec-for-ai-agents|Osmani 的 spec 指南]] 相互印证:规划先行、spec 先行、上下文模块化、并行代理、子代理;无矛盾——Anthropic 补充了"何时跳过计划"的粒度判断
- 注意:官方文档是持续演化的活文档,发布日期未知,归档快照于 2026-08-02

## 待办 / 后续

- 定期重抓原文对比变化(活文档)
- 深挖 `/goal`、hooks、agent teams 的机制细节(对应官方页)
- 找"上下文填充导致性能退化"的量化数据/实验(本页仅给定性表述)
