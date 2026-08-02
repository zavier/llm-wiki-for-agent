---
type: concept
tags: [ai-agents, environment-design, readability, harness]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agent-computer-interface, progressive-disclosure, file-as-memory, agents-md, harness-engineering, openai, comprehension-debt, alibaba]
sources: [2026-02-11-codex-agent-first-engineering, 2026-05-08-ai-native-organization]
status: active
---

# Agent readability

智能体可读性:把代码仓库、应用运行时与可观测性设计成智能体**能直接推理**的形式——"运行时上下文之外的一切都不存在",因此可读性是智能体能力的乘数。

## 关键信息

**第一性原则**(来源: [[2026-02-11-codex-agent-first-engineering]])

- 智能体运行时无法在上下文中访问的任何内容都是不存在的:Google Docs、聊天记录、人脑里的知识都不可访问;仓库本地的、版本化的工件(代码/Markdown/模式/可执行计划)是它能看到的一切
- 推论:Slack 里的架构讨论若智能体无法发现,它就像迟三个月入职的新员工;随时间推移须把越来越多情境**推入仓库**
- 目标:让智能体**直接从仓库推理出完整的业务领域**(如同提升代码库对新入职工程师的可导航性)

**可读性阶梯**(三级,层层外扩)

1. **仓库层**:AGENTS.md 作内容目录(~100 行)指向结构化 docs/(见 [[agents-md]]);文档评分(QUALITY_SCORE)追踪差距
2. **应用层**:应用可按 git worktree 启动——每次更改一个实例;Chrome DevTools 协议接入智能体运行时;DOM 快照/截图/导航技能——复现错误、验证修复、直接推理 UI 行为
3. **可观测性层**:日志/指标/追踪经本地可观测性栈(Vector → Victoria Logs/Metrics/Traces)按 worktree 临时供应,智能体用 LogQL/PromQL 查询关联——"服务 800ms 内启动"类约束可提示化;任务完整个实例含日志一并删除

**配套工程**:linter + CI 验证知识库新鲜度/交叉链接/结构;doc-gardening 代理定期扫过时文档并发修复 PR;偏好可完全内化在仓库的依赖("枯燥"技术更易建模);必要时重实现子集而非绕过不透明上游

**AI 友好 5 维度**(来源: [[2026-05-08-ai-native-organization]],阿里工程师归纳):测试完备性、环境完备性、架构合理性(无循环依赖、无跨服务隐式调用)、端到端测试可执行性、文档充分性——共同本质是要求"AI 友好"而非"能用";"我们今天的系统能用是因为人聪明,不是因为它 AI 友好"

**人形偏置与隐性成本**(来源: 同上):传统系统为**人**设计——人靠开会/问老王/凭经验/试环境悄悄补缺(隐性工作,不算进组织账);AI 没有"猜"和"问老王"的能力,这些被吸收的隐性化/非结构化/缺失信息第一次以瓶颈形式暴露;员工被迫当**"人肉中间件"**(手动从各系统导出数据喂 AI 再搬回)——系统打通与数据整合是内部调研中提及断层第一的痛点;反讽图景:AI 已能处理(模型强),系统没留接口(为人设计),人成了中间件

## 与其他页面的关系

- 是 [[agent-computer-interface|ACI]] 的扩展:ACI 管工具契约,可读性管**应用与观测环境本身**也是智能体的接口
- 实现机制: [[progressive-disclosure]]、[[file-as-memory]];实践方: [[openai]]
- 人侧对应:新工程师入职可导航性(见 [[comprehension-debt]] 的"投资测试")
