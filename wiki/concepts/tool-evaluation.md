---
type: concept
tags: [ai-agents, evaluation, tools]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agent-computer-interface, llm-as-a-judge, swe-bench, agentic-workflow-patterns, cursor, context-rot]
sources: [2025-09-11-writing-effective-tools-for-ai-agents, 2023-06-23-llm-powered-autonomous-agents, 2026-04-30-cursor-agent-harness-improvement]
status: active
---

# Tool evaluation

评测驱动的工具开发循环:原型 → 评测 → 用代理分析/优化——系统化测量"工具对代理的有效性",替代直觉判断。

## 关键信息

**原型**(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]]):快速搭原型再打磨;给 Claude 依赖库/SDK 的文档(常见于官方站的 `llms.txt`);包进本地 MCP server / Desktop 扩展(DXT),用 `claude mcp add` 接入 Claude Code 测试;自己先试出粗糙边缘

**评测**

- 任务生成:基于真实世界用例与真实数据源(内部知识库/微服务);**避免过于简单的沙箱**——强任务需要多次工具调用(可达数十次);弱任务("按 customer_id=9182 搜日志")测不出工具价值
- 可验证配对:每个 prompt 配可验证结果;verifier 从精确字符串比较到 [[llm-as-a-judge|Claude 判分]];**避免过度严格的 verifier**(格式/标点/合法变体差异误杀正确回答)
- 可选标注期望工具调用,以测量代理是否 grasp 每个工具的用途——但避免过度指定(合法路径可能多条)
- 运行:程序化 `while` 循环(LLM API 与工具调用交替),每个评测代理单任务;system prompt 让代理**先输出推理与反馈块再输出响应**(触发 CoT,可解释"为什么调用/不调用某工具");或用 interleaved thinking
- 指标:准确率之外,收集工具调用总次数/单任务时长/token 消耗/工具错误——冗余调用 → 分页或 token 上限参数需调整;参数错误 → 描述或示例需更清晰

**分析**:读 CoT 与原始 transcript(含工具调用与响应);**代理省略的往往比包含的更重要**;web search 工具例——Claude 给 `query` 附加 "2025" 污染结果,改描述修正;held-out 测试集防过拟合,还能挖出超越"专家手写"的改进

**协作优化**:把评测 transcript 拼接后交给 Claude Code,批量重构工具(保证实现与描述自洽);"本文大部分建议来自此循环"——用 AI agents 写 AI agents 的工具;Slack/Asana 内部评测显示 Claude 优化版优于人类专家手写版

## 与其他页面的关系

- 服务对象: [[agent-computer-interface]];判分: [[llm-as-a-judge]];实证基准: [[swe-bench]]
- 与 [[agent-verification]] 的 verifier 思想同源(可验证结果配对)
- 基准谱系(来源: [[2023-06-23-llm-powered-autonomous-agents]]):API-Bank(2023)是最早的工具增强 LLM 基准——53 个 API、264 对话、**三级能力**(L1 调用 API/L2 检索 API/L3 规划多 API 解决模糊需求);AutoGPT 的教训——"大量代码在解析输出格式",NL 接口可靠性是早期瓶颈;现代表评驱动循环(原型→评测→优化)是对此谱系的工程化
- **在线评测:Keep Rate 与语义满意度**(来源: [[2026-04-30-cursor-agent-harness-improvement]],Cursor):离线基准(自建套件 + 公开 CursorBench)只能近似真实使用 → 框架变体在线 A/B;直接指标(延迟/token 效率/工具调用数/缓存命中率)只能看趋势;**Keep Rate(保留率)**:智能体提出的代码变更在固定间隔后仍保留在用户代码库的比例——用户手动调整或迭代修复 = 初始质量低的信号;**语义满意度**:用 LLM 读用户对初始输出的回应判断(继续下一个功能 = 完成强信号;粘贴堆栈 = 失败可靠信号);反例:更贵模型做上下文摘要质量改善微乎其微被搁置——在线评测能拦截"看起来有前景"的假改进
- **工具错误即评测信号**(来源: 同上):工具调用是最易缺陷的界面;错误留在上下文浪费 token 并致上下文腐坏(见 [[context-rot]]);未知错误一律按缺陷处理,预期错误按成因分类(InvalidArguments/UnexpectedEnvironment/ProviderError/UserAborted/Timeout);告警 = 未知错误率阈值 + 预期错误异常检测(**按每个工具每个模型分别算基线**——不同模型工具出错率不同);每周自动化(带技能教模型搜日志找新问题、Linear 建单) + 云端智能体推动修复;集中冲刺把意外工具错误降低一个数量级(工具可靠性 ≥99%,多 99.9%)
