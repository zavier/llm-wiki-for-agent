---
type: concept
tags: [ai-agents, workflows, patterns]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agentic-systems, parallel-agents, llm-as-a-judge, agent-computer-interface, model-context-protocol, multi-agent-systems, lilian-weng, long-running-agents, context-anxiety]
sources: [2026-08-02-building-effective-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2023-06-23-llm-powered-autonomous-agents, 2026-08-02-harness-design-for-long-running-apps]
status: active
---

# Agentic workflow patterns

Anthropic 归纳的五个生产级工作流模式(可组合、可裁剪),从增强 LLM 构建块出发逐级增加复杂度;模式选择 = 任务结构匹配,而非越复杂越好。

## 关键信息

**构建块:增强 LLM**——LLM + 检索 + 工具 + 内存;两个实现重点:按用例裁剪能力 + 给 LLM 易用、文档良好的接口([[model-context-protocol|MCP]] 是实现途径之一)(来源: [[2026-08-02-building-effective-ai-agents]])

五种模式:

| 模式 | 机制 | 适用 | 例 |
|---|---|---|---|
| **Prompt chaining** | 固定顺序步骤,每步输出喂下一步;中间可加程序化 gate | 任务可干净拆成固定子任务;以延迟换准确率 | 营销文案→翻译;大纲→检查→成文 |
| **Routing** | 分类输入,导向专门子任务 | 类别分明且分类可靠;分离关注点 | 客服分流;易→Haiku/难→Sonnet 分级降本 |
| **Parallelization** | sectioning:拆独立子任务并行;voting:同任务多次多样输出 | 可并行提速,或需多样视角提置信度 | 守卫与主响应分离;漏洞多提示审查 |
| **Orchestrator-workers** | 中央 LLM 动态拆解任务、委派 worker、综合结果 | 无法预判子任务的复杂任务;与 parallelization 的区别是子任务不预定义 | 多文件编码改动;多源检索研究 |
| **Evaluator-optimizer** | 一个 LLM 生成、另一个评估反馈,循环迭代 | 有清晰评估标准 + 迭代有可测收益 | 文学翻译;多轮复杂搜索 |

要点:

- 模式非处方,可组合裁剪;只在"可证明改善结果"时增加复杂度,衡量性能并迭代
- 与自主 [[agentic-systems|agent]] 的边界:以上都有预定义结构(流程/角色),agent 无固定路径
- 生产案例(来源: [[2026-08-02-how-we-built-our-multi-agent-research-system]]):Claude Research 是 orchestrator-workers 的规模化实例(LeadResearcher + Subagents + CitationAgent),内部评测 +90.2%;委派细节与缩放规则是成败关键(见 [[multi-agent-systems]])
- 历史谱系(来源: [[2023-06-23-llm-powered-autonomous-agents]]):MRKL(2022,LLM 作 router 路由到专家模块)是 routing 的前身;HuggingGPT(ChatGPT 规划 + HuggingFace 模型执行)是 orchestrator-workers 的前身;LLM+P 用外部经典规划器(PDDL)做长程规划——一种至今少见的"规划外包"路线(见 [[lilian-weng]])
- **Evaluator-optimizer 深度案例**(来源: [[2026-08-02-harness-design-for-long-running-apps]]):Anthropic Labs 的 GAN 式 generator-evaluator——生成器产出,评估器带 Playwright MCP 操作活页面打分反馈,5-15 轮迭代(最长 4 小时);前端设计把主观质量拆成四条可评分标准(整体性/原创性/工艺/功能性),few-shot 校准评估器;生成器每轮做战略决策(趋好→精修,不行→换风格);全栈版加 planner 代理自动化"spec 展开"步骤,评估器改硬阈值验收——**evaluator-optimizer 从"生成-评估循环"升级为"验收门禁"**(见 [[long-running-agents]]);评估器价值随模型能力移动(见 [[llm-as-a-judge]]、[[context-anxiety]])
- 与既有概念的对应:parallelization → [[parallel-agents]] 的并行执行;evaluator-optimizer → [[llm-as-a-judge]] 的循环化;gate/ground truth → [[agent-verification]]

## 与其他页面的关系

- 分类框架: [[agentic-systems]];工具接口: [[agent-computer-interface]]
- 规模化执行: [[parallel-agents]];评审循环: [[llm-as-a-judge]]
