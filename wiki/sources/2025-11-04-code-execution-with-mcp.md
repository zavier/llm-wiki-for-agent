---
type: source
tags: [model-context-protocol, context-engineering, code-execution, ai-agents]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# Code execution with MCP: Building more efficient agents (2025-11-04)

- 原文: `raw/Code execution with MCP.md`
- 类型: Anthropic 工程博客(作者 Adam Jones、Conor Kelly;anthropic.com/engineering/code-execution-with-mcp)
- 备注: 原文含示意与代码片段;正文文本已覆盖其内容

## 摘要

直指 MCP 规模化后的两类 token 消耗——工具定义撑爆 context、中间结果二次过模型——提出把 MCP server 呈现为代码 API、让 agent 写代码调用工具的方案。由此获得按需加载定义、在执行环境里过滤/变换数据、用熟悉控制流、tokenize PII、持久化状态并沉淀可复用 skill 等好处;代价是需要安全的代码执行环境。

## 关键主张

- **MCP 现状**: 2024 年 11 月发布,MCP 是连接 agent 与外部系统的开放标准;此后社区建了数千个 MCP server、各主流语言都有 SDK,已成 de-facto 标准;但 agent 接入数百上千工具时,预载全部定义 + 中间结果过 context 会让 agent 变慢变贵
- **两大 token 消耗**: ① 工具定义撑爆 context window(连上千工具时要先处理**数十万 tokens**才能读到一个请求)② 中间工具结果再吃 token
- **中间结果翻倍例**: 让 agent"下载 Google Drive 会议记录并附到 Salesforce lead";全文记录经过模型两次(读取一次、再写出到另一个调用),**2 小时销售会议可能多处理 50,000 tokens**;更大文档可能超窗口、破坏流程,且复制数据时模型更易出错
- **解法:把 MCP server 呈现为 code API**: agent 写代码与 MCP server 交互,只加载需要的工具,并在执行环境里处理数据再回传模型;一种实现是生成所有工具的**文件树**(`servers/google-drive/getDocument.ts` …),每个工具一个文件,agent 通过探索文件系统发现工具
- **token 巨降**: 上述做法把 token 用量**从 150,000 降到 2,000,节省 98.7%**;Cloudflare 的 "Code Mode" 得出同样结论——LLM 擅长写代码,应利用这一长处
- **Progressive disclosure**: 把工具作为文件系统上的代码,模型按需读定义;或者加 `search_tools`,带 detail level 参数(仅名字 / 名字+描述 / 完整 schema)以进一步省 context
- **context 高效的结果处理**: 取 10,000 行表格时,在代码里过滤/变换后再返回——**agent 只看到 5 行而不是 10,000 行**;聚合、跨源 join、抽字段同理
- **更强的控制流**: loop/条件/错误处理用熟悉的代码模式而非串起单个 tool call;轮询 Slack 部署通知可写成 while 循环,比在 agent loop 里交替调 tool 与 sleep 更高效;还能省 "time to first token"(不必等模型评估 if 语句,交给执行环境)
- **隐私保护**: 中间结果默认留在执行环境,agent 只看到显式 log/return 的内容;更敏感场景下 harness 可**自动 tokenize PII**(看到的邮箱/电话/姓名是 `[EMAIL_1]` 等占位),共享到另一个 MCP tool call 时再在 MCP client 里反查还原;真实数据从 Google Sheets 流到 Salesforce,**全程不经过模型**;还能定义确定性的数据流向安全规则
- **状态持久化与 skills**: 有文件系统访问后,agent 可把中间结果写文件、跨操作续跑;也可把可用代码保存为可复用函数(如 `./skills/save-sheet-as-csv.ts`),加上 SKILL.md 就成结构化 skill,逐步积累更高层工具箱
- **代价**: 代码执行引入自身复杂度——跑 agent 生成的代码需要**安全的执行环境**(sandboxing、资源限制、监控),带来直接 tool call 没有的运维开销与安全考虑;要用降 token/降延迟/更好工具组合的收益去权衡
- **总论**: context 管理、工具组合、状态持久化看似新问题,其实软件工程早有成熟解法;code execution 把既有模式套用到 agent 上

## 与现有 wiki 的关系

- 更新 [[model-context-protocol]]:官方对该协议的效率补强
- [[context-engineering]]:JIT 检索、最小工具集、执行环境过滤的工程化
- [[progressive-disclosure]]:文件树 + `search_tools` detail level
- [[skills]]:保存函数 + SKILL.md = skill 的动态生成版;[[agentic-memory]]:文件即持久状态
- [[agent-computer-interface]]:工具呈现形态从 JSON 定义转向 code API
- [[context-rot]]:数十万 token 定义开销
- [[long-running-agents]]:写文件、resume、track progress
- [[anthropic]]、[[claude-code]]:官方生态
- [[pi-coding-agent]]、[[minimal-vs-rich-harness]]:极简派对 MCP 的反对 vs 官方"扩容工具库"路线的分歧可对照

## 待办 / 后续

- 安全执行环境的运维成本未量化
- 与 [[2025-11-24-advanced-tool-use|Tool Search Tool / PTC]] 是同一主题的两篇,应合成
- Cloudflare Code Mode 原文可另找
