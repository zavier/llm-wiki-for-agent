---
type: concept
tags: [ai-agents, orchestration, attention, economics]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [conductor-orchestrator, multi-agent-systems, parallel-agents, agent-management, cognitive-surrender, intent-debt, comprehension-debt, agent-verification, pr-contract, harness-engineering, agent-teams, ralph-loop]
sources: [2026-05-24-orchestration-tax, 2026-03-26-code-agent-orchestra, 2026-06-05-intent-debt, 2026-01-08-coding-agents-manager]
status: active
---

# Orchestration Tax

编排税:启动代理便宜、闭环评审贵,而所有判断与合并必须路由经过**唯一一个串行处理器(你)**——两者之间的结构性缺口;术语由 Richard Seroter 在 Google I/O 2026 panel 命名,Osmani 正式展开(来源: [[2026-05-24-orchestration-tax]])。\"不是纪律问题,是架构问题\"——修复不是更努力,是把注意力当稀缺串行资源来架构。

## 关键信息

**两个精确类比**:

- **GIL**:Python 全局解释器锁——线程随便开,一次只有一个执行字节码,都要抢锁;你就是你代理们的 GIL,锁只有一把,你握着;代理可同时跑,但需要真理解架构/解合并冲突的工作必须拿到锁
- **Amdahl 定律**:加速上限被串行分数限制;代理开发里的串行分数 = **判断(judgement)**——8 个代理不加速你的判断时间,只加深喂给它的队列;\"优化非瓶颈部分不增加吞吐\"——代理优化了从来不是约束的部分,约束是评审步,系统吞吐 = 评审步吞吐

**不对称**:启动 = 一个按键/一句 prompt;闭环 = 检查正确性 + 调和与其他代理的触碰 = 你;\"有一个你,只有一个\"——人 = 并发系统里的慢串行组件

**疲劳结构成因**:每次 check-in 付 context switch 成本(flush 脑 + 冷 reload,永远无法完美 reload);5 个代理 = 5 次冷 reload + 后台脑进程持续焦虑\"该检查哪个\";感觉忙 ≠ 生产力——20 个代理跑满 dashboard,与真正往 main 运好代码脱钩,**从内部看一模一样**(失败模式不可见)

**五条实践(架构注意力)**:

1. **按评审率缩放舰队,不按 UI**:回压——agent 数(生产者)应匹配评审率(消费者);正确并行数 = 你能真正评审好的数量,多数人 = **个位低位数**;\"AI 工具乐意让你开 20 个,那只是 UI 功能\"
2. **分类工作(两堆)**:隔离工作(委托云端后台代理,异步,最终门槛才需要你)vs 复杂任务(判断即工作:怪 bug/架构设计);**大错 = 并行化第二堆**——多个复杂任务不扩展产出,只是抖动锁,一切更糟
3. **批量评审**:一次坐着审 4 个代理比逐个冷切换便宜;给代理长绳,让工作堆一点再批量处理
4. **只在判断上花锁**:机器能自证的(写通过的测试/生成截图)别耗人——代理证明无聊的 80%,你只花稀缺注意力在真需要人的 20%
5. **保护串行时间**:瓶颈需要最好的时段,不是 check-in 之间的边角料;最高杠杆有时 = 完全停止编排、握着锁想一个单一问题;\"**编排不是真正的工作,是工作周围的 overhead**\"

**不付税的路径**:税无论如何会付——要么刻意付(设计系统),要么悄悄付:浅层评审、[[cognitive-surrender|认知投降]](接受代码因为形成观点要付的注意力没了)、心智模型过期;Ciera Jaspan 引 Storey 债务框架(一手: [[2026-02-09-cognitive-debt]]):**同时累积技术债(合并没好好读的)+ 认知债(心智模型过期)**——今天 dashboard 不显示,生产爆了才发现不知道系统怎么工作了(见 [[intent-debt]]、[[comprehension-debt]])

**前传:ambient anxiety tax(来源: [[2026-04-07-cognitive-parallel-agents]],Osmani)**:并行代理上限 = 监督吞吐,不是理解吞吐;真正的隐藏成本 = 背景警觉("知道某线程 20 分钟没查可能正悄悄变糟")——不显示在任务列表,却从同一资源池取水;天花板随每线程复杂度移动(两个新架构问题比四个边界良好迁移更耗神);**先降范围再降数量**(每线程更紧任务 = 提高可真正掌控的并行数);"不像失败,像生产力"(爆过上限的体验)(见 [[parallel-agents]])

**与相邻概念的分工**:编排税 = 协调成本(人在环外的管理税);意图税 = 补供从未写下的意图(编排税很大部分是意图税);理解债 = 心智模型过期(编排税不付的账单之一)(见 [[intent-debt]])

## 与其他页面的关系

- 是 [[conductor-orchestrator]] 的经济学底座:orchestrator 人力杠杆高但必须付编排税;五轴光谱的\"人力前载/后载\"与此互证
- 对策机制: [[agent-management]](管理技能迁移)、[[agent-teams]](3-5 甜点区 = 并行上限的团队版)、[[agent-verification]]/[[pr-contract]](让代理自证 80%)
- 回压思想 ↔ [[harness-engineering]] 的验证回压(HumanLayer:验证必须上下文高效,同理)
- 来源: [[2026-05-24-orchestration-tax]];相关: [[parallel-agents]]、[[multi-agent-systems]]、[[ralph-loop]]
