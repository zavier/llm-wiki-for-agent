---
type: concept
tags: [ai-agents, memory, context]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [context-engineering, claude-code, subagents, multi-agent-systems, file-as-memory, self-reflection, long-running-agents]
sources: [2026-08-02-effective-context-engineering-for-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2025-10-06-file-system-is-the-new-database, 2023-06-23-llm-powered-autonomous-agents, 2026-08-02-effective-harnesses-for-long-running-agents]
status: active
---

# Agentic memory

结构化笔记 / 代理记忆:代理定期把笔记持久化到上下文窗口之外、稍后拉回——以最小开销获得跨回合、跨上下文重置、跨会话的持久记忆。

## 关键信息

- 机制(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):Claude Code 的 to-do list、自定义代理的 NOTES.md——代理在窗口外维护进度与依赖,需要时读回;上下文重置后靠读自己的笔记继续
- 例证:**Claude plays Pokémon**——数千游戏步骤中精确记账("过去 1,234 步在 Route 1 训练,Pikachu 已升 8 级,目标 10 级")、绘制已探索区域地图、记录技能搭配与战斗策略;跨上下文重置保持多小时的训练/地牢探索连贯
- 工具化:Sonnet 4.5 发布时,Claude Developer Platform 推出 memory tool(公开 beta):基于文件系统存储/取回上下文外信息,支持跨会话积累知识库、维护项目状态
- 与 compaction 互补:compaction 压缩历史后重开;笔记把关键状态留在窗口外按需取回
- 选择依据:compaction 适合需要来回对话流的任务;笔记适合有清晰里程碑的迭代开发;子代理适合并行探索(见 [[subagents]])
- 生产案例(来源: [[2026-08-02-how-we-built-our-multi-agent-research-system]]):Claude Research 的 LeadResearcher 把研究计划存入 Memory——上下文超 200k 会被截断,计划必须外存;长时对话模式:总结完成阶段 → 存外部记忆 → 必要时派生新子代理接续,保持跨上下文连贯(见 [[multi-agent-systems]])
- **情景记忆扩展**(来源: [[2025-10-06-file-system-is-the-new-database]]):experiences/decisions/failures 三日志存"判断"而非仅事实——情感权重 1-10、推理过程、备选方案、根因与预防;"事实告诉发生了什么,情景记忆告诉什么重要、我会怎么做不同、如何权衡";failures 日志最值钱("用真实痛苦换来的模式识别");决策日志让代理引用"你实际怎么想"而非通用建议(例:职业权衡框架 Learning > Impact > Revenue > Growth);载体见 [[file-as-memory]]
- **生成式代理记忆**(来源: [[2023-06-23-llm-powered-autonomous-agents]]):记忆流(memory stream)记录自然语言观察;检索按 相关性/近因性/重要性 三权重(importance 直接问 LLM 打分——与情景记忆的情感权重同思路);反思机制把记忆综合为高层推断(最近 100 条观察 → 3 个最显著高层问题 → 回答);25 个虚拟角色涌现出信息扩散、关系记忆、社交事件协调
- 历史对照:2023 向量库记忆(embedding + MIPS)vs 2025-26 [[file-as-memory|纯文件记忆]]——两种长期记忆路线;生成式代理的"重要性打分"与文件派的"判断优先"殊途同归
- **跨会话 harness 记忆**(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]]):Claude Agent SDK 长时任务用 **progress 文件 + git 历史**承担跨会话记忆——每个会话以空记忆开始,靠"读 git log + progress 文件"快速进入状态;会话结束写 git commit(描述性消息)+ 进度更新;feature list 的 passes 状态同时充当**反事实目标记忆**(未完成特征的完整清单,防止"提前宣布完成");"每次新会话从零开始"的设定把记忆问题变成显式的文件读写协议(见 [[long-running-agents]])

## 与其他页面的关系

- 属于 [[context-engineering]] 长时任务三技术之一;工具: [[claude-code]]
- 与 [[subagents]]、[[context-rot]] 并列的上下文约束应对手段
