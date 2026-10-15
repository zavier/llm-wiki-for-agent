---
type: concept
tags: [ai-agents, protocols, tool-integration]
topic: ai-agents
created: 2026-08-02
updated: 2026-10-15
refs: [claude-code, context-engineering, agentic-workflow-patterns, agent-computer-interface, skills, pi-coding-agent, progressive-disclosure, agent-containment, lethal-trifecta]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents, 2026-08-02-building-effective-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-08-02-equipping-agents-with-agent-skills, 2025-11-30-opinionated-minimal-coding-agent, 2025-11-04-code-execution-with-mcp, 2025-11-24-advanced-tool-use]
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

**反论:上下文税与 CLI 替代**(来源: [[2025-11-30-opinionated-minimal-coding-agent]],[[pi-coding-agent]]):极简派拒绝 MCP——每个 MCP server 的工具描述**全量常驻上下文**:Playwright MCP 21 工具 13.7k tokens、Chrome DevTools MCP 26 工具 18k tokens = 会话开始前 7-9% 窗口就没了,且多数工具某会话根本用不上;替代方案 = 普通 CLI 工具 + README,代理需要时才读 README(渐进披露的 CLI 形态,见 [[progressive-disclosure]]),bash 调用天然可组合、扩展 = 加一个脚本;必要场景用 mcporter(Steinberger)把 MCP server 包成 CLI。侧面收益:从根上规避 MCP 供应链攻击面([[harness-engineering]] 安全节)。

> [!warning] 学派分歧:MCP 标准化连接(Anthropic/生态) vs "MCP 是大多数用例的过度设计"(pi)——分歧核心是上下文预算的计量:协议生态收益 vs 每会话固定 token 税(见 [[minimal-vs-rich-harness]])。

**规模化路径:代码执行取代直接工具调用**(来源: [[2025-11-04-code-execution-with-mcp]])。协议本身的回应方式——MCP 从 2024-11 发布后被行业采纳为事实标准,但客户端默认的"预载全部工具定义 + 结果穿模型"两条路都随工具数量恶化:

- 两个结构性开销:①**工具定义预载**——接数千工具时,读请求之前就要先处理几十万 token;②**中间结果穿模型**——"从 Google Drive 下载会议记录并附到 Salesforce lead"这类任务,2 小时会议记录 **50,000 tokens 流经两次**(读出一次、写入再写一次),更大文档会直接超窗;且模型在工具之间复制大数据时更容易出错
- 解法:把 MCP server 呈现为**代码 API / 文件树**(`servers/google-drive/getDocument.ts` + `index.ts`),代理探索目录、只读需要的定义 → token **150,000 → 2,000(-98.7%)**
- 取数后在执行环境里**过滤后再给模型**:10,000 行表格只 `console.log` 前 5 行 → 代理看到 5 行而非 10,000 行
- 控制流用代码表达(例:循环轮询 Slack 等部署完成通知)优于"工具调用 + sleep"交替;条件树在执行环境跑还能降低首 token 延迟(不必等模型评估 if)
- **隐私保护**:中间结果默认留在执行环境,模型只看你显式 log 或返回的部分;更敏感场景可由 MCP client **自动 tokenize PII**(`[EMAIL_1]`/`[PHONE_1]`),真实值只在 client 侧查表还原、**永不流经模型**;这也能用来定义确定性的数据流向规则
- **状态持久化与 skills**:代理可把中间结果写文件以便续跑,并把跑通的代码存成可复用函数;给它加 SKILL.md 就成为结构化 skill——"代理逐步搭建自己的高阶能力工具箱"(见 [[skills]])
- **原文自认代价**:运行 agent 生成的代码需要安全的执行环境(沙箱、资源限制、监控),这是直接工具调用不承担的运维与安全开销;降 token / 降延迟 / 提升工具组合性的收益需与实现成本对账(沙箱侧见 [[agent-containment]])
- 同族的平台化路径:[[2025-11-24-advanced-tool-use]] 的 `defer_loading` / `tool_search` / `allowed_callers`,即把"按需发现 + 代码调用"做进 API 层(见 [[agent-computer-interface]])
- 安全侧呼应:**MCP 把外部工具接进来的同时也把提示注入入口接进来**;tool annotations 能声明哪些工具需开放世界访问/有破坏性变更,属声明层而非边界层(见 [[lethal-trifecta]])

## 与其他页面的关系

- 工具载体: [[claude-code]];上下文价值: [[context-engineering]]
- 与 [[skills]] 并列:一个管"知识按需加载",一个管"工具按需连接"
