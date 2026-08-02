---
type: concept
tags: [ai-agents, scalability, workflow]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, subagents, lethal-trifecta, agentic-workflow-patterns, multi-agent-systems, agent-teams, orchestration-tax, agent-verification]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents, 2026-08-02-building-effective-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2026-03-26-code-agent-orchestra, 2026-05-24-orchestration-tax]
status: active
---

# Parallel agents

同时运行多个代理会话横向扩展产出;用 worktrees/隔离/团队机制避免冲突;附带质量工作流(如 Writer/Reviewer)。

## 关键信息

- 工具形态(来源: [[2026-08-02-best-practices-claude-code]]):
  - **Worktrees**:独立 git checkout,编辑不冲突
  - 桌面应用 / Web 版:多会话可视化管理;web 版跑在 Anthropic 托管 VM
  - **Agent teams**:共享任务、消息、team lead 的自动化协调,适合长时无人值守循环
- 质量模式:Writer/Reviewer——A 实现,B 在**新鲜上下文**评审(避免"给刚写的代码打分"的偏置);同理可一个写测试、另一个写代码使其通过
- Fan-out:`claude -p` 循环批量处理 + `--allowedTools` 限定权限;可嵌入数据处理管道(`claude -p ... --output-format json | your_command`)
- auto mode:分类器模型审查命令,拦截越权/未知基础设施/敌意内容驱动动作;非交互模式下反复拦截会中止
- Osmani 视角(见 [[2026-01-13-good-spec-for-ai-agents|spec 指南]]):并行代理"出奇地有效,但精神上很累";限 2-3 个起步;任务须真独立(别让两个代理写同一文件);共享内存(向量库)可作公共上下文
- 风险:协调开销、写冲突、非确定性叠加——[[lethal-trifecta]] 在并行下被放大;厨房水槽会话(串行混任务)是反面的会话卫生问题
- 量化实证(来源: [[2026-08-02-how-we-built-our-multi-agent-research-system]]):多代理 vs 单代理内部研究评测高 **90.2%**;token 用量解释 BrowseComp 80% 方差;代价 4×/15× token(聊天基线);**编码任务并行度不足,Anthropic 自评暂不适合多代理**;生产部署用彩虹部署逐步切流量避免打断运行中代理(见 [[multi-agent-systems]])
- 模式定位(来源: [[2026-08-02-building-effective-ai-agents]]):parallelization 工作流有两个变体——**sectioning**(拆独立子任务并行,如守卫审查与主响应分离,比同一 LLM 调用同时处理两者更好)与 **voting**(同任务多次多样输出提置信度,如漏洞多提示审查);与 orchestrator-workers 的区别:子任务预定义与否(见 [[agentic-workflow-patterns]])
- **编排纪律**(来源: [[2026-03-26-code-agent-orchestra]]):WIP 上限——别跑超过你能有意义评审的代理数(3-5 甜点);**一文件一主人**——绝不让两个代理编辑同一文件(冲突杀死速度);worktree 生命周期脚本(agent-spin/agent-merge/agent-clean,约 12 行 bash,Conductor 可视化替代);token 预算与终止标准(每代理预算如前端 180k/后端 280k,85% 自动暂停通知 lead,**3+ 卡死迭代即杀并换新代理**);异步查岗每 5-10 分钟一次,别 hover(见 [[agent-teams]])
- **人类是瓶颈:并行上限 = 评审率**(来源: [[2026-05-24-orchestration-tax]]):启动代理便宜、闭环评审贵——你是唯一串行处理器(GIL/Amdahl:串行分数 = 判断);**正确并行数 = 你能真正评审好的数量,对多数人是个位低位数**("AI 工具乐意让你开 20 个,那只是 UI 功能");回压原则:agent 数(生产者)匹配评审率(消费者);批量评审比逐个冷切换便宜(每次 check-in 付 context switch 成本);两堆分类:隔离工作可委托后台,复杂任务(判断即工作)**绝不同时并行**;代价 = [[orchestration-tax]](不付 = 浅层评审 + [[cognitive-surrender]] + 心智模型过期)

## 与其他页面的关系

- 构件: [[subagents]];工具: [[claude-code]];风险: [[lethal-trifecta]]
- 质量门: [[agent-verification]]、[[llm-as-a-judge]]
