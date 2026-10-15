---
type: source
tags: [ai-agents, tool-use, context-engineering, model-context-protocol]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# Introducing advanced tool use on the Claude Developer Platform (2025-11-24)

- 原文: `raw/Introducing advanced tool use on the Claude Developer Platform.md`
- 类型: Anthropic 工程博客(作者 Bin Wu 等;anthropic.com/engineering/advanced-tool-use);发布三项 beta 功能
- 备注: 原文含若干架构示意图与代码片段;正文文本已覆盖其内容

## 摘要

发布三项使 Claude 能"动态发现、学习、执行"工具的 beta 功能:Tool Search Tool(用搜索按需发现工具,避免把全部定义塞进 context)、Programmatic Tool Calling(在代码执行环境里调用并编排工具)、Tool Use Examples(用样本调用演示工具的用法约定)。三者分别针对工具定义膨胀、中间结果污染、参数调用错误三类瓶颈,并给出各功能的实现方式、适用/不适用场景与组合建议。

## 关键主张

- **三个新 beta 功能**:**Tool Search Tool**(用搜索工具访问成千上万工具而不吃 context window)、**Programmatic Tool Calling**(在代码执行环境里调用工具,降低对 context 的影响)、**Tool Use Examples**(演示如何有效使用某工具的统一标准);目标是让 agent 在数百上千工具上无缝工作、按需发现并加载工具
- **工具定义的 token 税**: 五服务器示例——GitHub 35 tools (~26K tokens)、Slack 11 (~21K)、Sentry 5 (~3K)、Grafana 5 (~3K)、Splunk 2 (~2K),即 **58 个工具 ≈ 55K tokens**(对话还没开始);再加 Jira(单独 ~17K)很快逼近 100K+ 开销;Anthropic 见过工具定义在优化前消耗 **134K tokens**
- **Tool Search 的省法**: 传统做法 50+ MCP 工具全部预载 ~**72K tokens**、总开销 ~**77K** 才开始干活;Tool Search 只预载 ~**500 tokens** 的搜索工具,按需发现 3-5 个相关工具 ~**3K tokens**,总 ~**8.7K**——**保留 95% 上下文窗口 / token 用量降 85%**(对比 191,300 vs 122,800 tokens)
- **Tool Search 的准确率收益**: 大规模工具库下 MCP eval 显著提升——**Opus 4 从 49% 到 74%,Opus 4.5 从 79.5% 到 88.1%**(启用 Tool Search 后)
- **实现机制**: 给 API 全部工具定义,标记 `defer_loading: true` 使其可被发现;deferred 工具初始不进 context,Claude 只看到搜索工具 + `defer_loading: false` 的关键常用工具;搜索返回引用再展开为完整定义;可按 server 整体 defer 而保留个别高频工具(`mcp_toolset` + `configs`);平台内置 regex / BM25 搜索,也可用 embedding 等自定义;**不破坏 prompt caching**(deferred 工具初始完全不在 prompt 里)
- **何时用 Tool Search**: 定义 >10K tokens、有工具选择准确率问题、多 server 的 MCP 系统、10+ 工具;收益有限:<10 工具、所有工具每次都常用、定义紧凑
- **PTC 解决两个问题**: ① **中间结果污染 context**——Claude 分析 10MB 日志时整个文件进 context,尽管它只要错误频率摘要 ② **推理开销与手工综合**——每次工具调用都要一次完整 inference pass,五个工具的流程就是五次 inference + Claude 逐条读结果
- **PTC 例证(budget compliance)**: 问"哪些团队成员超了 Q3 差旅预算";传统做法 20 人 × 每人 50-100 行明细 = **2,000+ expense line items(50 KB+)** 全进 context;PTC 让 Claude 写 Python 脚本编排,脚本在 Code Execution sandbox 里跑,工具结果由脚本而非模型消费,**对 Claude 只暴露最终的 2-3 个超支的人**;从 **200KB** 原始数据降到 **1KB** 结果
- **PTC 收益**: token 用量在复杂研究任务上平均 **43,588 → 27,297 tokens(-37%)**;消除 **19+** 次 inference pass(20+ 工具调用合成一个代码块);准确率——内部 knowledge retrieval **25.6% → 28.5%**、GIA benchmarks **46.5% → 51.2%**
- **PTC 实现**: 加 `code_execution` 工具,并用 `allowed_callers: ["code_execution_20250825"]` 让工具 opt-in;API 把工具定义转成 Claude 可调的 Python 函数;tool 请求带 `caller` 字段,结果在 Code Execution 环境处理;只有代码最终输出回到 context
- **何时用 PTC**: 只需聚合/摘要的大数据集、3 个以上相互依赖工具调用的多步流程、在 Claude 看到前要过滤/排序/变换结果、中间数据不该影响 Claude 推理的任务、跨多项的并行操作(如查 50 个端点);收益有限:简单单工具调用、Claude 应看到全部中间结果、小响应快速查询
- **Tool Use Examples 补 JSON Schema 之缺**: Schema 能定义结构(类型/必填/枚举)但表达不了 usage patterns——何时填可选参数、哪些组合合理、API 约定是什么;例如 `due_date` 该用 "2024-11-06" 还是 "Nov 6, 2024";用 `input_examples` 给 3 个样本(完整/部分/仅标题),教会格式约定(YYYY-MM-DD、USR-XXXXX、kebab-case)、嵌套结构构造、可选参数相关性(严重 bug 带完整联系+紧 SLA 升级;feature request 无 contact/escalation;内部任务只给标题)
- **Tool Use Examples 收益与用法**: 内部测试在复杂参数处理上准确率 **72% → 90%**;**每工具 1-5 个示例**、用真实数据(真实城市名/合理价格,不用 "string"/"value")、展示 minimal/partial/full 的多样性、只对 schema 说不清的模糊处加示例
- **最佳实践:分层针对瓶颈**: context 膨胀(工具定义)→ Tool Search Tool;大中间结果污染 context → PTC;参数错误/畸形调用 → Tool Use Examples;三者互补(找到对的工具、高效执行、正确调用);把三到五个最常用工具始终预载,其余 defer;搜索匹配名字与描述,故清晰命名与描述能提升发现准确率

## 与现有 wiki 的关系

- 更新 [[agent-computer-interface]]:工具契约设计的官方工具链延伸(定义/发现/调用/示例)
- 更新 [[model-context-protocol]]:直面 MCP 的"上下文税"并给出官方解法——与 [[pi-coding-agent]] 的 MCP 反对立场形成对照
- [[progressive-disclosure]]:Tool Search 就是工具层面的渐进式披露;[[context-engineering]]:与 JIT 检索、最小工具集一脉相承
- [[context-rot]]:**134K / 58 个工具 ≈ 55K tokens** 是"上下文是有限资源"的直接证据
- [[skills]]:Code Execution + 保存函数 + SKILL.md 在 [[2025-11-04-code-execution-with-mcp]] 中展开
- [[tool-evaluation]]:准确率 A/B(49%→74%、79.5%→88.1%、72%→90%)是评测驱动工具演进的又一证据
- [[claude-code]]、[[anthropic]]:Claude for Excel 用 PTC 处理数千行表格
- [[minimal-vs-rich-harness]]:工具生态扩张派 vs 极简派的分歧点

## 待办 / 后续

- 三功能均为 beta(header `advanced-tool-use-2025-11-20`),需跟踪 GA 与定价
- 与 [[2025-11-04-code-execution-with-mcp]] 是同一主题的两篇官方文档,值得合成一页
- latency 权衡未给具体数字(只说新增搜索步骤),需等更多数据
