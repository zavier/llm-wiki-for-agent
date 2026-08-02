---
type: concept
tags: [ai-agents, tools, design]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agentic-systems, agentic-workflow-patterns, ai-agent-spec, swe-bench, tool-evaluation, model-context-protocol, agent-readability]
sources: [2026-08-02-building-effective-ai-agents, 2026-01-13-good-spec-for-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-02-11-codex-agent-first-engineering]
status: active
---

# Agent-computer interface (ACI)

代理-计算机接口:代理与工具之间的契约设计——工具是"确定性系统与非确定性代理之间的契约";投入与 HCI 同等的精力,用评测驱动迭代。

## 关键信息

**定位**

- 工具 = 确定性软件与非确定性代理之间的契约(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]]):不是给开发者写 API,而是给代理设计工具——目标是扩大代理可有效解决问题的表面积
- "对代理最符合人体工学的工具,对人类直觉上也出奇地好懂"
- 原则:"想想 HCI 花多少精力,就计划在 ACI 上花同样多"(来源: [[2026-08-02-building-effective-ai-agents]])

**五条设计原则**(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]])

1. **选择正确的工具(以及不实现什么)**:更多工具 ≠ 更好;勿盲包 API 端点——代理的"affordance"不同,上下文有限而计算机内存廉价(通讯录例:`list_contacts` 暴力全量 vs `search_contacts` 跳到相关页);合并高频链路:`schedule_event`(找空档+预定)、`search_logs`(只回相关行)、`get_customer_context`(一次汇总)
2. **Namespacing(命名空间)**:按服务/资源前缀分组(`asana_search`/`jira_search`、`asana_projects_search`);前缀 vs 后缀命名对评测有非平凡影响且因模型而异——用自家评测定;同时减少载入上下文的工具数
3. **返回有意义上下文**:只回高信号信息,避开低级标识(`uuid`/`256px_image_url`/`mime_type`);UUID→语义化名称显著降幻觉;`response_format` 枚举(detailed/concise,206→72 token 例)提供 GraphQL 式灵活性
4. **Token 效率**:分页/范围/过滤/截断 + 合理默认(Claude Code 默认 25,000 token 上限);引导代理"多次小搜索而非单次大搜索";错误响应也做提示工程——具体可操作建议而非不透明错误码
5. **提示工程工具描述**:像给新员工介绍那样写;把隐式上下文显式化(专用查询格式/术语/资源关系);参数无歧义命名(`user`→`user_id`);小改动可带来戏剧性提升——Sonnet 3.5 微调工具描述后达 [[swe-bench|SWE-bench Verified]] SOTA

- 响应结构(XML/JSON/Markdown)无万能解,依任务与代理评测定
- 实证:SWE-bench 代理"优化工具的时间 > 优化整体 prompt";web search 工具缺陷例(Claude 给 `query` 附加 "2025" → 改描述修正)
- 评测驱动的开发流程见 [[tool-evaluation]]

**术语对应**:[[addy-osmani|Osmani]] 的 AX(Agent Experience,见 [[ai-agent-spec]])是同一思想在 spec 层的表达——AX 管文档/格式的代理可消费性,ACI 管工具接口的代理可用性;都是"为代理做设计"

**边界扩展:应用与可观测性也是接口**(来源: [[2026-02-11-codex-agent-first-engineering]],OpenAI 零人工代码实验):工具契约之外,智能体的"接口表面"还包括——应用本身(按 git worktree 起实例、Chrome DevTools 协议、DOM 快照/截图/导航技能,让代理复现错误/验证修复/推理 UI 行为)与可观测性(本地栈 Vector→Victoria Logs/Metrics/Traces,LogQL/PromQL 查询——"服务 800ms 内启动"类约束提示化);"运行时上下文之外的一切都不存在"是 ACI 的第一性原则(见 [[agent-readability]])

## 与其他页面的关系

- 所属框架: [[agentic-systems]];工具连接: [[model-context-protocol]];评测: [[tool-evaluation]]
- 实证: [[swe-bench]];与 [[ai-agent-spec]] 的 AX 同族
