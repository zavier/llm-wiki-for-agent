---
type: source
tags: [ai-agents, multi-agent, research]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# How we built our multi-agent research system (2026-08-02)

- 原文: `raw/How we built our multi-agent research system.md`
- 类型: Anthropic 工程博客(作者 Jeremy Hadfield、Barry Zhang、Kenneth Lien、Florian Scholz、Jeremy Fox、Daniel Ford;**原始发布日期未标注,待核实**;按剪藏日期归档)
- 备注: Claude Research 功能的架构复盘;原文含 3 张图(多代理架构、完整流程、Clio 使用分布),正文文本已覆盖其内容

## 摘要

Claude Research 多代理系统从原型到生产的完整复盘:orchestrator-workers 架构(LeadResearcher 规划委派 + Subagents 并行探索 + CitationAgent 引用归因)、多代理的量化收益与 token 代价、七条提示工程原则、三类评测实践(小样本/LLM-judge/人工)、生产可靠性工程(状态与错误复合、追踪、彩虹部署、同步瓶颈)。附录含终态评测、长时对话管理、子代理输出直写文件系统三条技巧。

## 关键主张

- **收益量化**:多代理(Opus 4 主导 + Sonnet 4 子代理)vs 单代理 Opus 4,内部研究评测**高 90.2%**;BrowseComp 上 token 用量解释 **80%** 性能方差(加工具调用数与模型选择共 95%)——多代理本质是"花足够 token 解决问题"
- **代价量化**:代理 ≈ 4× 聊天 token,多代理 ≈ **15×**;需高价值任务才经济;多数编码任务并行度不足、实时协调委派不成熟,**当前不适合多代理**
- **七条提示原则**:①像代理一样思考(用 Console 模拟观察)②教编排者如何委派(目标/输出格式/工具与源/任务边界;模糊指令→重复劳动,2021 芯片危机例)③按查询复杂度缩放投入(1 代理 3-10 调用 → 10+ 子代理)④工具设计选择是 [[agent-computer-interface|ACI]](给显式启发式)⑤让代理自我改进(工具测试代理改写描述 → 任务完成时间 **-40%**)⑥先宽后窄(短宽查询起步)⑦引导思维过程(extended thinking 规划 + interleaved thinking 评估工具结果)
- **并行工具调用**:3-5 子代理并行 + 子代理 3+ 工具并行,复杂查询研究时间**降至 90%**
- **评测**:立即小样本启动(约 20 条真实查询,提示微调 30%→80%);LLM-judge 单次调用输出 0.0-1.0 + pass/fail 最一致(事实准确性/引用准确性/完整性/来源质量/工具效率五维 rubric);人工测试抓自动化漏掉的(早期偏好 SEO 内容农场,加来源质量启发式解决)
- **涌现行为**:主导代理小改动不可预测地改变子代理行为;最佳 prompt 是"协作框架"(分工/方法/投入预算)而非严格指令
- **生产工程**:代理有状态、错误复合——断点续跑、告知代理工具失败让其自适应、retry+checkpoint;全链路追踪(只监控决策模式不监控对话内容,保隐私);彩虹部署避免打断运行中的代理;同步执行是当前瓶颈,异步是未来方向
- **附录技巧**:状态变更类代理用**终态评测**而非逐步;长时对话=总结阶段+外部记忆+新子代理接续;子代理输出直写文件系统(传引用而非复制大输出,避免"传话游戏")

## 与现有 wiki 的关系

- 新建:[[multi-agent-systems]]
- 更新了 [[subagents]](委派教法/缩放/文件系统输出)、[[parallel-agents]](量化实证)、[[llm-as-a-judge]](rubric 判分/小样本启动)、[[agentic-workflow-patterns]](orchestrator-workers 生产案例)、[[agentic-memory]](计划入内存/长时模式)、[[context-engineering]](长时对话管理)、[[ai-feature-implementation-loop]](多代理开放问题获数据)
- 与五篇前源互补无矛盾;多代理"编码暂不适合"与 Claude Code 实践并行不悖(后者是单代理为主)

## 待办 / 后续

- 核实发布日期;找 BrowseComp 基准构成
- 看 Cookbook 中 Research 系统的开源 prompt,对照七原则逐条验证
- 跟踪异步执行(agent 间实时协调)的进展
