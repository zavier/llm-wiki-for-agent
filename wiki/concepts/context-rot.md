---
type: concept
tags: [context, llm-behavior]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [context-engineering, agentic-memory, cursor]
sources: [2026-08-02-effective-context-engineering-for-ai-agents, 2026-04-30-cursor-agent-harness-improvement]
status: active
---

# Context rot

上下文腐烂:随着上下文窗口内 token 数增加,模型准确召回其中信息的能力下降——needle-in-a-haystack 式基准揭示的现象,是上下文工程存在的理由。

## 关键信息

- 定义与证据(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):needle-in-a-haystack 式基准测试;Chroma(trychroma.com)的 context rot 研究;**所有模型均呈现此特征**,只是退化曲线陡缓不同
- 机制:
  - transformer 全对全注意力 → n 个 token 产生 n² 成对关系,上下文变长时注意力被摊薄
  - 训练数据分布以短序列为主 → 模型对上下文级依赖经验少、专门参数少
  - 位置编码插值(position encoding interpolation)可适配长序列,但损失 token 位置理解精度
- 性质:**性能梯度而非硬悬崖**——长上下文下模型仍强,但信息检索与长程推理的精度下降
- 推论:上下文 = 有限资源、边际收益递减;LLM 有"注意力预算",每个新 token 都在消耗
- **工具错误致腐**(来源: [[2026-04-30-cursor-agent-harness-improvement]],Cursor):一次失败的工具调用虽常可自纠,但**错误会留在上下文中**——浪费 token 并累积错误,降低后续决策质量("上下文腐坏");偶发卡住或失控;工具错误率因此成为 harness 的健康信号(见 [[tool-evaluation]])

## 与其他页面的关系

- 是 [[context-engineering]] 的核心动因;与 [[curse-of-instructions]] 同族(信息/指令过载的两种表现:一个毁召回,一个毁遵循)
