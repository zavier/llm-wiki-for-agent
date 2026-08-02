---
type: entity
tags: [organization, ai-engineering]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [context-engineering, llm-as-a-judge]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Anthropic

Claude 与 Claude Code 背后的 AI 公司;贡献了有效上下文工程、Skills、子代理、Plan Mode 等被 spec 指南采纳的模式。

## 关键信息

- **有效上下文工程**:建议把 prompt 组织成明确分区(`<background>`、`<instructions>`、`<tools>` 等),给模型强结构线索;并指出"minimal does not necessarily mean short"——该给的细节要给,但要聚焦(来源: [[2026-01-13-good-spec-for-ai-agents]])
- **Skills 系统**:可复用的 Markdown 行为定义,代理按需调用,与 spec 流程互补
- **Claude Code 子代理**:各自独立的上下文窗口、自定义 system prompt,主代理按领域委派,小上下文 + 专注角色提升准确度、支持并行
- **Plan Mode**(Claude Code 内 Shift+Tab):只读规划模式,先分析代码库出计划、对齐后再写码——spec 指南中"规划先行"的推荐工具
- 与 GitHub 的 [[agents-md]] 思路互补:用规范文件定义代理行为

## 与其他页面的关系

- 详见 [[context-engineering]]、[[llm-as-a-judge]]
- 工具模式支撑 [[ai-agent-spec]] 的规划先行原则
