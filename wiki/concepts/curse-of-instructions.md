---
type: concept
tags: [prompt-engineering, llm-behavior]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, context-engineering]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Curse of instructions

研究现象:提示中指令/要求越多,模型对每一条的遵循度显著下降——即使 GPT-4 与 Claude 级别的模型,在同时满足大量需求时也会挣扎。

## 关键信息

- 实证:提示中叠加的指令或数据越多,模型对每条的遵循性能显著下降(来源: [[2026-01-13-good-spec-for-ai-agents]],openreview 论文)
- 直观表现:给出 10 条详细规则,AI 可能认真执行前几条、逐渐忽略其余
- 行业共识缓解法:把复杂需求**分解为顺序、简单的指令**,一次聚焦一个子问题
- 与 [[context-engineering|模块化上下文]] 互为印证:小、聚焦的上下文优于巨型 prompt

## 与其他页面的关系

- 是 [[ai-agent-spec]] 原则 3(模块化任务)的理论依据
- 上下文管理解法见 [[context-engineering]]
