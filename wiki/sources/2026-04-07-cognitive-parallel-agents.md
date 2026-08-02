---
type: source
tags: [ai-agents, parallel-agents, attention, addy-osmani, orchestration]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Your parallel Agent limit (2026-04-07)

- 原文: 无 raw 文件(AI 直接抓取自 addyosmani.com/blog/cognitive-parallel-agents/,2026-08-02;页面 meta 确认发布于 **April 7, 2026**)
- 类型: 技术博客([[addy-osmani]],2026-04-07)
- 备注: 本 wiki 第三十七篇源文档;**[[2026-05-24-orchestration-tax|The Orchestration Tax]] 的前传**(Osmani 自述"last month";同一注意力经济学主题的初版);"ambient anxiety tax"术语的原始出处

## 摘要

并行代理的上限不是代理数,是**你的监督吞吐**。可监督的代理数 > 能深理解的代理数,但"无理解的监督"正是理解力债的所在——每个额外线程让心智模型更落后。conductor 比喻:指挥不弹每个乐器,但"握着整首曲子"的全局意识正是最耗神的。上限不是固定数字:随每线程复杂度移动——两个真新颖的架构问题比四个边界良好的迁移更快耗尽你;**每线程范围比线程数更大的变量**。真正的隐藏成本:背景警觉(ambient anxiety)——"知道某个 20 分钟没查的线程可能正在悄悄变糟"的部分大脑,不显示在任务列表里,却从同一个资源池取水。

## 关键主张

- **理解吞吐 vs 监督吞吐**:能监督比能深理解多;监督而无理解 = [[comprehension-debt]] 的栖息地;单会话中理解债有界,并行会话中**跨线程同时复合**,且你无法总判断哪个线程在跑最大账单
- **ambient anxiety tax**:并行代理耗神的元凶不是主动认知而是**背景警觉**——四线程 = 四个不同代码库、四个问题框架、四个信任校准、四个"这能悄悄错得多离谱"的近似;不显示在任务列表但消耗同一资源池
- **天花板是技能**:大多数人会以硬方式发现——爆过它(两代理顺利→加第三→加第四→中午不再认真评审只是接受输出);"不像失败,像生产力"
- **先降范围再降数量**:杠杆通常不是"少跑代理"而是"**给每个代理更紧的任务**"——每线程更紧的范围降低每线程心智开销,实际提高能真正掌控的并行数
- **该多谈的**:对话几乎全在谈代理能做什么,需要同样谈**人类能持续承担什么**("The conversation ... needs to also be about what humans can sustain")
- 与 conductor 框架互文:conductor 不演奏每个乐器但握整曲;整曲意识令人疲惫,靠更努力无法扩展

## 与现有 wiki 的关系

- 更新 [[orchestration-tax]](前传入库:ambient anxiety tax 出处;理解吞吐 vs 监督吞吐的精确表述), [[parallel-agents]](上限动态性:范围 > 数量), [[comprehension-debt]](并行复合机制), [[ai-feature-implementation-loop]] 编排税层
- 互证:"先降范围再降数量" ↔ [[ai-agent-spec]] 原子任务/范围纪律与 [[pr-contract]]"刻意小 PR";"监督无理解 = 理解债" ↔ [[cognitive-surrender]] 注意力耗尽路径;四线程 = 四个信任校准 ↔ [[agent-verification]] 传感器非裁决;上限随复杂度移动 ↔ [[orchestration-tax]] 五实践(两堆分类:判断即工作的任务绝不同时并行)
- 与 [[2026-03-26-code-agent-orchestra|Code Agent Orchestra]] 直接互文(conductor 比喻同源);与 [[agent-teams]] 3-5 甜点区一致(上限个位数)

## 待办 / 后续

- 无重大待核;页面含少量省略号段落(抓取截断),核心论点完整
