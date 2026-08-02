---
type: source
tags: [ai-agents, tools, evaluation]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Writing effective tools for AI agents—using AI agents (2025-09-11)

- 原文: `raw/Writing effective tools for AI agents—using AI agents.md`
- 类型: Anthropic 工程博客(作者 Ken Aizawa,研究/MCP/产品工程多方贡献;**发布于 2025-09-11,据外部转载确认,待原文核实**)
- 备注: 原文含 7 张图(评测流程示意、Slack/Asana 评测结果图、detailed/concise 响应示例、截断/错误响应示例),正文文本已覆盖其内容

## 摘要

[[agent-computer-interface|ACI]] 的实战手册:提出"工具 = 确定性系统与非确定性代理之间的契约",给出评测驱动的工具开发循环(原型 → 评测 → 与代理协作优化),并提炼五条工具设计原则。核心实证:评测 + 工具描述微调带来戏剧性提升——Sonnet 3.5 因此在 [[swe-bench|SWE-bench Verified]] 达 SOTA;"本文大部分建议来自用 Claude Code 反复优化内部工具的循环"(自举)。

## 关键主张

- **工具是新型软件**:确定性系统与非确定性代理之间的契约;不是给开发者写 API,而是给代理设计工具——目标是扩大代理可有效解决问题的表面积;"对代理最符合人体工学的工具,对人类直觉上也出奇地好懂"
- **开发循环**:①快速原型(给 Claude 库文档 llms.txt、包进本地 MCP server / Desktop 扩展测试)②运行评测(任务基于真实用例、强任务需多次工具调用;配可验证结果,verifier 从精确字符串到 Claude 判分;跑程序化 while 循环,让代理先输出推理/反馈块触发 CoT;收集准确率/调用次数/时长/token/错误指标)③把 transcript 拼给 Claude Code 批量重构工具;held-out 测试集防过拟合
- **分析要点**:代理"省略的往往比包含的更重要";读 CoT 与原始 transcript;web search 工具例——Claude 给 query 参数附加 "2025" 污染结果,改工具描述修正
- **五条原则**:
  1. 选择正确的工具(和不实现的):勿盲包 API 端点;代理上下文有限而计算机内存廉价(通讯录例:search_contacts 而非 list_contacts);合并高频链路(schedule_event / search_logs / get_customer_context)
  2. Namespacing:按服务/资源前缀分组;前缀 vs 后缀命名对评测有非平凡影响、因模型而异——用自家评测定
  3. 返回有意义上下文:高信号、避开低级标识(uuid 等);UUID→语义化名称显著降幻觉;response_format 枚举(detailed/concise,206→72 token)
  4. Token 效率:分页/范围/过滤/截断 + 合理默认(Claude Code 默认 25,000 token 上限);错误响应也做提示工程(具体可操作建议而非错误码)
  5. 提示工程工具描述:像给新员工介绍;把隐式上下文显式化;参数无歧义命名(user→user_id);Sonnet 3.5 微调描述后 SWE-bench Verified SOTA
- 响应结构(XML/JSON/Markdown)无万能解,依任务评测定
- 展望:面向代理的软件开发要从确定性模式转向非确定性模式;MCP tool annotations 披露开放世界访问/破坏性变更

## 与现有 wiki 的关系

- **重构了 [[agent-computer-interface]]**(五条原则 + 评测指向,成为 ACI 的完整落地手册)
- 新建:[[tool-evaluation]]
- 更新了 [[model-context-protocol]](namespacing/annotations/本地 server 原型)、[[swe-bench]](SOTA 实证)、[[claude-code]](25k 上限/协作优化角色)、[[context-engineering]](token 上限与 affordance)、[[llm-as-a-judge]](verifier 角色)、[[ai-feature-implementation-loop]](自举实证)
- 与四篇前源互补无矛盾;与前篇 context engineering 呼应(其引用本文章作为工具设计参考)

## 待办 / 后续

- 核实发布日期;看 tool evaluation cookbook 的端到端流程
- 跟踪 MCP tool annotations 规范(2025-06-18 版本)
- 找 Claude 判分 verifier 与精确比较在工具评测中的效果对比数据
