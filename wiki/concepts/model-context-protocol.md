---
type: concept
tags: [ai-agents, protocols, tool-integration]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, context-engineering, agentic-workflow-patterns, agent-computer-interface, skills]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents, 2026-08-02-building-effective-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-08-02-equipping-agents-with-agent-skills]
status: active
---

# Model Context Protocol (MCP)

标准化"模型 ↔ 外部工具/数据"连接的开放协议:Notion、Figma、数据库、issue 跟踪器等均可接入;是代理生态的工具互操作层。

## 关键信息

- 用法:`claude mcp add` 连接外部工具;Claude 可据此从 issue 跟踪器实现功能、查数据库、分析监控数据、集成 Figma 设计、自动化工作流(来源: [[2026-08-02-best-practices-claude-code]])
- 生态定位(见 [[2026-01-13-good-spec-for-ai-agents|Osmani 指南]]):由 Agentic AI Foundation 标准化;遵循此类协议的 spec 更易被代理可靠消费;MCP 可自动化"按任务喂正确上下文"
- 上下文工程价值:外部数据经 MCP 按需取,避免全量塞进 prompt(见 [[context-engineering]])
- 官方定位(来源: [[2026-08-02-building-effective-ai-agents]]):实现"增强 LLM"(LLM + 检索 + 工具 + 内存)的推荐途径之一——简单客户端实现即可接入第三方工具生态
- 工具侧细节(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]]):多 server 数百工具时用**命名空间**分组降低选择歧义(见 [[agent-computer-interface]]);本地 MCP server 用于工具原型测试(`claude mcp add`);**tool annotations** 披露哪些工具需开放世界访问/有破坏性变更(2025-06-18 规范)
- 可被插件打包分发;与多代理共享工具配合([[parallel-agents]] 的 MCP 工具共享)
- 与 [[skills]] 互补(来源: [[2026-08-02-equipping-agents-with-agent-skills]]):skill 教代理"涉及外部工具的复杂工作流",MCP 提供工具连接本身——一个管流程知识,一个管工具接入

## 与其他页面的关系

- 工具载体: [[claude-code]];上下文价值: [[context-engineering]]
- 与 [[skills]] 并列:一个管"知识按需加载",一个管"工具按需连接"
