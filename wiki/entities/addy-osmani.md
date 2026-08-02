---
type: entity
tags: [people, ai-engineering, web-performance]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, harness-engineering, vibe-coding, simon-willison, factory-model, pr-contract, comprehension-debt, cognitive-surrender]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-04-19-agent-harness-engineering, 2026-02-25-factory-model-coding-agents, 2026-01-07-ai-code-review, 2026-03-14-comprehension-debt, 2026-05-05-cognitive-surrender]
status: active
---

# Addy Osmani

谷歌 Chrome 团队工程经理,资深 Web 性能与前端工程作者,近年深耕 AI-assisted engineering,提出面向 AI 代理的 spec 写作框架。

## 关键信息

- 身份:Chrome 团队工程经理;Web 性能领域知名作者(TL;DR 系列,如《Learning JavaScript Design Patterns》)
- 2026 年发布 O'Reilly 新书《AI-assisted Engineering》,书站 beyond.addy.ie 提供免费技巧;另一本《Beyond Vibe Coding》(O'Reilly)深入 AI-assisted/agentic 工程框架(来源: [[2026-02-04-agentic-engineering]])
- **agentic engineering 术语采纳**:2026-02 接受 Karpathy 的 "agentic engineering" 为纪律化 AI 开发的正式名称(vibe coding = YOLO;agentic engineering = AI 做实现、人拥有架构/质量/正确性;见 [[agentic-engineering]])
- 2026-01-13 发表 [[2026-01-13-good-spec-for-ai-agents|How to write a good spec for AI agents]],日常使用 Claude Code、Gemini CLI 等编码代理
- 核心立场:区分 [[vibe-coding|vibe coding]] 与 AI-assisted engineering——后者需要 spec、测试、审查的工程纪律
- 主张 spec-driven development:spec 是"活的可执行工件",人类负责引导,代理负责大量写作
- 2026-04-19 发表 [[2026-04-19-agent-harness-engineering|Agent Harness Engineering]]:harness 工程学科化的综合论述——引 Viv Trivedy 的"Agent = Model + Harness"等式与棘轮原则、HumanLayer 的"skill issue"框架、Terminal Bench 2.0 证据(同模型不同 harness 得分差距巨大),把 Anthropic harness 系列、Ralph Loop、HaaS 串成完整图景(见 [[harness-engineering]])
- 2026-02-25 发表 [[2026-02-25-factory-model-coding-agents|The Factory Model]]:行业范式级论述——软件第三纪元(定义意图而非写指令)、工厂心智模型(建生产软件的工厂)、spec 是杠杆、**验证是未解问题**(见 [[factory-model]]);此前两篇关联文章(自改进代理、2026 趋势)也同属该世界观
- 2026-01-07 发表 [[2026-01-07-ai-code-review|AI writes code faster. Your job is still to prove it works.]]:AI 时代代码评审——负担转移显式化;**PR Contract 四字段证据契约**;solo/团队分野;安全不可谈判(45% 缺陷率);评审即知识转移(见 [[pr-contract]])
- 2026-03-14 发表 [[2026-03-14-comprehension-debt|Comprehension Debt]]:理解力债务——代码量 vs 人类理解量的差距;速度不对称(初级生成快过资深审计);测试/spec 都非完整答案;Anthropic RCT(理解力 -17%);理解力成为稀缺资源(见 [[comprehension-debt]])
- 2026-05-05 发表 [[2026-05-05-cognitive-surrender|Cognitive Surrender]]:认知投降——理解力债务的机制层;offloading vs surrender 分界线;Wharton 数据(73% 接受错答案、借用信心);互惠放大;反合理化表格(见 [[cognitive-surrender]])

## 与其他页面的关系

- 其 spec 框架总览见 [[ai-agent-spec]]
- 常引用 [[simon-willison]] 的观点(管理隐喻、一致性测试、致命三要素);本 wiki 收录其三篇源文档(spec 指南、harness 工程)与两篇关联文章(编码代理工具、自改进代理)
- 实证依据来自 [[github]] 的 2,500+ 配置文件研究;模式参考 [[anthropic]] 的 Skills 与子代理

## 演变 / 争议

- 暂无。其"spec 化开发"主张与 Willison 的"先写文档"经验论一致,未见公开分歧
