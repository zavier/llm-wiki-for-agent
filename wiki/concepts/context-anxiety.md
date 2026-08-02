---
type: concept
tags: [ai-agents, context, failure-mode]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [context-engineering, long-running-agents, agent-verification, cursor]
sources: [2026-08-02-harness-design-for-long-running-apps, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-04-30-cursor-agent-harness-improvement]
status: active
---

# Context anxiety

上下文焦虑:模型在接近自己**以为的**上下文极限时开始提前收尾、匆忙完事——与任务实际需求无关的过早结束行为;长时任务中"提前宣布完成"类失败的一种机制解释。

## 关键信息

- 现象(来源: [[2026-08-02-harness-design-for-long-running-apps]]):上下文窗口将满时,模型开始 wrapping up work prematurely——即使任务远未完成;属于上下文相关的模型缺陷而非任务理解问题
- 模型差异:S​​onnet 4.5 表现强烈到"compaction 不足以保证长任务性能",**context reset 成为 harness 必需**;Opus 4.5 基本消除了该行为(harness 因此去掉 reset,改单连续会话);Opus 4.6 发布即称"更会规划、能更久地维持代理任务"
- **第三次独立报告**(来源: [[2026-04-30-cursor-agent-harness-improvement]],Cursor):某模型在窗口将满时开始**拒绝执行任务**、犹豫地称"任务看起来太大了"——与 Anthropic 观察的"提前收尾"同族但表现不同(拒做 vs 赶工);Cursor 用**提示调优**成功减轻——至此三种缓解并存:Anthropic context reset(换窗口)、Cursor 提示调优(改行为)、Osmani/模型换代(能力上移消失)
- **Reset vs Compaction**(来源: [[2026-08-02-harness-design-for-long-running-apps|同文]],对照 [[context-engineering]]):compaction 就地总结缩短历史、同一代理继续——保留连续性但**不给干净起点**,焦虑可残留;reset 清空窗口 + 新代理 + 结构化交接(携带状态与下一步)——干净起点,代价是交接工件要足够好 + 编排复杂度/token 开销/延迟
- 与"提前宣布完成"的关系(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]]):harness 早期观察到的"后到会话看到进展就宣布完成"与焦虑同族——都缺少"任务远未完成"的外部信号;特征清单 passes 门禁是反制(见 [[long-running-agents]])
- 对策:context reset 换窗口;feature list 反事实目标;评估器硬阈值(见 [[agent-verification]]);或等更强模型(能力上移使该缺陷自然消失)

## 与其他页面的关系

- 属于 [[context-engineering]] 的上下文管理问题;长时任务场景见 [[long-running-agents]]
- 反制机制: [[agent-verification]]、[[conformance-testing]]
