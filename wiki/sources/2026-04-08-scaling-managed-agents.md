---
type: source
tags: [harness-engineering, long-running-agents, context-engineering, ai-agents]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# Scaling Managed Agents: Decoupling the brain from the hands (2026-04-08)

- 原文: `raw/Scaling Managed Agents.md`
- 类型: Anthropic 工程博客(作者 Lance Martin、Gabe Cemaj、Michael Cohen;Claude Platform 上的 hosted service;anthropic.com/engineering/managed-agents)
- 备注: 原文含若干架构图;正文文本已覆盖其内容

## 摘要

harness 会编码"Claude 做不到什么"的假设,而这些假设随模型变强会过期。Managed Agents 把 agent 组件虚拟化为 session(追加式事件日志)、harness(调用 Claude 并路由工具调用的循环)、sandbox(执行环境)三个接口,使其中任一实现可独立替换或失败。文中记录从"单体容器 pet"到 brain/hands 解耦的动机与收益(可调试性、VPC 连接、TTFT 大降、凭据隔离),并给出 session 作为窗口外 context object 的设计。

## 关键主张

- **harness 假设会过期**: harness 编码了"Claude 做不到什么"的假设,须常被质疑,因为随模型进步会 **go stale**(bitter lesson);实例:先前发现 Sonnet 4.5 会因感知上下文逼近上限而提前收尾("context anxiety"),于是在 harness 里加 context resets,**但同一 harness 用在 Opus 4.5 上时该行为消失,resets 成了 dead weight**
- **虚拟化三组件**: Managed Agents 把 agent 组件虚拟化为三个接口——**session**(记录一切发生的 append-only log)、**harness**(调 Claude 并把其工具调用路由到基础设施的循环)、**sandbox**(Claude 跑代码/改文件的执行环境);对接口形态有自己的观点,但对背后跑什么不预设,实现可互换
- **"Don't adopt a pet"**: 最初把三个组件都放进一个容器,好处是文件编辑即直接 syscall、无需设计服务边界;但容器成了 **pet**(命名、手工照料、不能丢)——容器失败即丢 session,容器无响应就要"治病";唯一观察窗口是 WebSocket 事件流,分不清 harness bug、事件流丢包还是容器离线;调试要进容器 shell,而容器常含用户数据,等于没法调试;harness 还假设被操作的东西就在同一容器里,导致连客户 VPC 只能网络对等
- **解耦 brain 与 hands**: harness 不再住在容器里,而像调任何工具一样调容器——`execute(name, input) → string`;容器变 **cattle**:死了就把失败当 tool-call error 传回 Claude,重试时用 `provision({resources})` 按标准配方重建
- **harness 也变 cattle**: 因 session log 在 harness 之外,harness 里没有东西需要跨崩溃存活;挂了就用 `wake(sessionId)` 重启、`getSession(id)` 取回事件日志、从最后一个事件续跑;agent loop 中用 `emitEvent(id, event)` 写持久记录
- **安全边界**: 耦合设计里 Claude 生成的不受信代码与凭据同容器,prompt injection 只需说服 Claude 读自己的环境;拿到 token 就能开新的不受限 session 并委派;结构性修法是**让 token 永远无法从沙箱触及**——Git 用仓库 access token 在沙箱初始化时 clone 并 wire 进本地 remote(push/pull 无需 agent 碰 token);自定义工具支持 MCP,OAuth token 存 secure vault,Claude 经专用 proxy 调 MCP,proxy 用 session 关联的 token 换取 vault 凭据再调外部服务,**harness 从不知晓任何凭据**
- **session ≠ context window**: 长任务常超窗口,而 compaction/memory tool/trim 都涉及对"留什么"的不可逆决策,难知未来轮次需要哪些 token;Managed Agents 让 **session 成为活在 context window 之外的 context object**,持久存在 session log 里;接口 `getEvents()` 允许按位置切片事件流——从上次读到的地方续读、回退几个事件看前情、在某个动作前重读
- **context 管理与存储分离**: 取到的事件可在 harness 里变换后再进 Claude 的 context(可做组织以提升 prompt cache 命中率、做 context engineering);**我们无法预测未来模型需要什么 context engineering**,所以把 context 管理推给 harness,接口只保证 session 持久、可被询问
- **many brains**: 解耦后,想让 Claude 操作客户 VPC 的资源不再需要网络对等;性能上,过去 brain 在容器里意味着 N 个 brain 要 N 个容器,每个 session 都要预付完整容器启动成本(即使它根本不碰 sandbox);TTFT(用户最强烈感知的延迟)因此很差;**按需 provision 后 p50 TTFT 降约 60%、p95 降超 90%**;扩展 many brains = 起很多无状态 harness,只在需要时连 hands
- **many hands**: 让每个 brain 连接多个 hands,意味着 Claude 要推理多个执行环境、决定把活派到哪——比单 shell 更难的认知任务;早期模型做不到所以从单容器起步,随智力 scaling,单容器反成限制(容器失败就丢所有 hand 的状态);解耦后每个 hand 是一个 tool(`execute(name, input) → string`),支持任意自定义工具、任意 MCP server、自家工具;harness 不知道 sandbox 是容器、手机还是 Pokémon 模拟器;因为 hand 不与 brain 耦合,**brains 可互相传递 hands**
- **结论: meta-harness**: 问题是旧问题——如何为"尚未被想到的程序"设计系统;OS 几十年的做法是把硬件虚拟成足够通用的抽象(process、file);Managed Agents 是 **meta-harness**:对具体 harness 不表态,只对围绕 Claude 的接口有观点(需要操作状态 session、执行计算 sandbox、扩展到 many brains / many hands),不假设 brain/hand 的数量与位置

## 与现有 wiki 的关系

- 更新 [[harness-engineering]]:harness 假设过期 + meta-harness 是"harness 会变"的架构级回答;与 [[minimal-vs-rich-harness]] 的"精简派"呼应
- [[long-running-agents]]:long-horizon agent 的 session/恢复机制
- [[context-anxiety]]:Sonnet 4.5 → resets → Opus 4.5 行为消失,是该概念最强的"会过期"证据;[[context-engineering]]:session as external context object
- [[agentic-memory]]、[[file-as-memory]]:append-only session log 作为窗口外记忆
- [[multi-agent-systems]]、[[subagents]]:brains 互相传递 hands
- [[model-context-protocol]]:自定义工具经 MCP + vault proxy
- [[anthropic]]、[[claude-code]]:Claude Code 被点名为 excellent harness,Managed Agents 可容纳它
- [[governance-as-code]]:凭据隔离与沙箱边界的治理含义

## 待办 / 后续

- 原文自认:无法预测未来模型需要什么 context engineering / harness,所以故意对具体实现不表态;哪些假设会成为下一个 dead weight 需持续观察
- session log 的存储成本与 `getEvents()` 切片语义值得对照 [[long-running-agents]]
- 可与 [[2026-05-25-how-we-contain-claude]] 合成"沙箱与凭据隔离"页
