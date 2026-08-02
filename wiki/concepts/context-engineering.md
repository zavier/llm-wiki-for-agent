---
type: concept
tags: [context, prompt-engineering, ai-agents]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [curse-of-instructions, anthropic, ai-agent-spec]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# Context engineering

管理给 AI 的上下文:质量比长度重要——用扩展 TOC、分层摘要、RAG、MCP 让代理只取当前任务所需的信息。

## 关键信息

- 核心命题:"context length 不是 context quality 的替代品"(来源: [[2026-01-13-good-spec-for-ai-agents]])
- **扩展 TOC / 分层摘要**:把大 spec 每节压成 1-2 句摘要 + 引用标签(如"Security: 用 HTTPS、保护 API keys、输入校验,详见 §4.2"),留在 prompt 里当"心理地图";细节按需喂入——像人浏览目录后翻到相关页
- **按任务喂相关切片**:后端任务只带 backend 部分;任务间开新会话清上下文;全局规则(约束节)每次简短重申
- **工具化**:Context7 按当前任务自动抓取相关文档片段;RAG 把大 spec 分块嵌入向量库按需检索;MCP 自动化"根据任务喂正确上下文"
- **结构化 prompt**:Anthropic 建议分节(`<background>`、`<instructions>`、`<tools>`),给模型强结构线索
- 与 [[curse-of-instructions]] 互为因果:上下文/指令超载 → 遵循度下降;解法即本页技术
- 降本:别喂 20k tokens 当 5k 就够;更多 token 常是边际收益递减

## 与其他页面的关系

- 现象依据: [[curse-of-instructions]];方法来源: [[anthropic]]、[[2026-01-13-good-spec-for-ai-agents]]
- 在 [[ai-agent-spec]] 中对应原则 3(模块化)的技术实现
