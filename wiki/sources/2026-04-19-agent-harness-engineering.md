---
type: source
tags: [ai-agents, harness, configuration, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Agent Harness Engineering (2026-04-19)

- 原文: `raw/Agent Harness Engineering.md`
- 类型: 技术博客([[addy-osmani|Addy Osmani]],addyosmani.com;**发布于 2026-04-19**,frontmatter 已标注)
- 备注: 本 wiki 第十二篇源文档;Osmani 的第三篇源(继 spec 指南后),harness 工程作为一门学科的**综合论述**——把 Viv Trivedy 的 "Agent = Model + Harness"、HumanLayer 的 "skill issue" 框架、Anthropic harness 系列、Fareed Khan 的 Claude Code 架构拆解串成一条线;核心立场:模型之争忽略了系统的另一半

## 摘要

编码代理 = 模型 + 环绕它的一切(提示、工具、上下文策略、hooks、沙箱、反馈回路、恢复路径)。本文主张"**一般模型 + 好 harness 胜过好模型 + 差 harness**",把 harness 工程确立为一门有名字的学科,并给出核心习惯(棘轮原则:每个错误变成规则)、行为驱动设计法、各原语(文件系统/bash/沙箱/记忆/上下文/长时执行/hooks/AGENTS.md)的模式,以及 HaaS(Harness-as-a-Service)与模型-harness 训练回路的展望。

## 关键主张

- **Agent = Model + Harness**(Viv Trivedy 的等式;"If you're not the model, you're the harness"):原始模型不是代理,harness 给了它状态、工具执行、反馈回路与可强制约束;Claude Code/Cursor/Codex/Aider/Cline 都是 harness——底层模型有时相同,但体验由 harness 主导
- **harness 组成**:系统提示、CLAUDE.md/AGENTS.md、skills、子代理提示;工具/skills/MCP 及描述;捆绑基础设施(文件系统/沙箱/浏览器);编排(子代理、交接、路由);hooks 与中间件(compaction、continuation、lint);可观测性(日志、trace、成本/延迟计量)
- **"skill issue" 重构**(HumanLayer):大多数代理失败是配置问题而非模型问题——"it's not a model problem. It's a configuration problem.";与"等 GPT-6"叙事相反:**今天模型能做与你能看到它做的差距,大部分是 harness 差距**
- **关键数据**:Terminal Bench 2.0 上 Claude Opus 4.6 在 Claude Code 里得分远低于同一模型跑在定制 harness 里;Viv 团队**只改 harness 就把编码代理从 Top 30 提到 Top 5**;模型的后训练与它们训练时用的 harness 耦合(共训练造成过拟合——改工具逻辑有时引发莫名回归)
- **棘轮原则(ratchet)**:把每个代理错误当作永久信号——出过事才加约束,模型强到冗余才移除;"好的 AGENTS.md 每一行都应能追溯到一次具体的失败";这使 harness 工程是**纪律而非框架**(你的 harness 由你的失败史塑造,无法下载)
- **行为驱动设计**(Viv):从想要的行为出发推导 harness 组件——"如果你说不出某个组件服务于哪个行为,它大概不该存在"
- **原语清单**:文件系统+Git(最基础的持久状态;其他原语多半指向它);bash+代码执行(通用工具——"教人用单个厨房小工具 vs 给一整个厨房";ReAct 循环);沙箱(隔离执行、allow-list、网络隔离、预装运行时+无头浏览器;原则"成功静默、失败冗长");记忆与搜索(AGENTS.md 每次启动注入、编辑后重载=粗粒度持续学习;Context7 类 MCP 补知识截止);上下文腐烂三技术(compaction、**tool-call 输出卸载**——2,000 行日志只留头尾、全文落盘按需读、skills 渐进披露)+ 全量 context reset(引 Anthropic);长时执行(Ralph Loop: hook 拦截退出企图 → 新上下文窗口重注原 prompt 强制继续,每次干净起步、从文件系统读状态;plan 文件 + 验证 hooks;planner/generator/evaluator 拆分 + sprint contract);hooks(强制层——"告诉代理做 X" vs "系统强制 X";typecheck/lint/test 每改必跑、拦截破坏性 bash、PR/push main 需批准、写时自动格式化);AGENTS.md 与工具选择(短:HumanLayer 压在 60 行内,"飞行员的检查单而非风格指南";十把聚焦工具胜过五十把重叠的)
- **MCP 供应链安全**:工具描述每请求都进 prompt——**装的任何 MCP 服务器都是模型会读的可信文本**;马虎或恶意的 MCP 能在你输入任何东西之前 prompt-inject 你的代理
- **生产全景**:Fareed Khan 对 Claude Code 架构的分层拆解(输入/知识/集成/执行/输出/可观测性/多代理层,主循环居中)——前文几乎每个概念都在图上有个具名组件;**Claude Code 的轨迹关于 harness 至少不亚于关于底层模型**
- **Harness 不缩小,只移动**:Opus 4.6 基本消灭了上下文焦虑(Sonnet 4.5 会提前收尾)——一整类焦虑缓解脚手架变成死代码;但天花板也上移了:需要多天记忆策略、三专用代理协调、生成 UI 的设计质量评估器
- **模型-harness 训练回路**(Viv):harness 里发现的好原语 → 产品化 → 用于下一代模型训练 → 新模型更会用该原语;所以 Opus 4.6 在 Claude Code 里和在其他 harness 里感觉不同;harness 是活系统,不是设一次就完的配置文件;最佳 harness 不一定是你模型训练时所在的那个
- **HaaS(Harness-as-a-Service)**:从 LLM API(给你 completion)到 harness API(给你 runtime)——Claude Agent SDK/Codex SDK/OpenAI Agents SDK 同向;默认路径从"自己造循环"变成"选 harness 框架,配置四支柱(系统提示/工具/上下文/子代理)";"good agent building is an exercise in iteration. You can't do iterations if you don't have a v0.1."
- **方向**:顶级编码代理彼此长得比它们底下的模型更相似——harness 模式在收敛;开放问题:共享代码库上并行编排多代理、代理分析自己的 trace 来修 harness 级失败模式、**harness 按任务即时动态装配工具与上下文(从静态配置变成接近编译器的存在)**

## 与现有 wiki 的关系

- 新建概念: [[harness-engineering]]
- 更新了 [[addy-osmani]](第三篇源)、[[agents-md]](棘轮原则)、[[context-engineering]](tool-call 输出卸载)、[[long-running-agents]](Ralph Loop)、[[ai-feature-implementation-loop]](harness 差距论 + 供应链安全)
- 与既有 harness 系列(Anthropic 两篇)同向并强化:上下文焦虑的消失、组件即假设、"harness 空间移动"均与 [[2026-08-02-harness-design-for-long-running-apps]] 一致;新增的是**独立视角的量化证据**(Terminal Bench Top 30→5)与**学科化框架**(等式/棘轮/行为驱动/HaaS)
- 新安全维度:MCP prompt-injection 风险(此前 wiki 未覆盖);新实践:tool-call 输出卸载、Ralph Loop、成功静默失败冗长

## 待办 / 后续

- 核实 Terminal Bench 2.0 数据与 Viv Trivedy Top 30→Top 5 案例的原始来源
- 跟进 HaaS 生态(Agent SDK 四支柱的配置实践);动态 harness 装配("编译器"愿景)进展
- 代理自分析 trace 修复 harness 的落地案例(开放问题)
