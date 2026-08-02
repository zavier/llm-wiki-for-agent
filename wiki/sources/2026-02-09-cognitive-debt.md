---
type: source
tags: [ai-agents, cognitive-debt, storey, debt]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-03
status: active
---

# How Generative and Agentic AI Shift Concern from Technical Debt to Cognitive Debt (2026-02-09)

- 原文: `raw/How Generative and Agentic AI Shift Concern from Technical Debt to Cognitive Debt.md`(人工裁剪版,2026-08-03 提供)——此前(2026-08-02)由 AI 直接抓取自 margaretstorey.com/blog/2026/02/09/cognitive-debt/;**两版核对一致 ✓,raw 版更完整,补入 3 段抓取版缺失内容**(见下方补充)
- 类型: 研究者博客(Margaret-Anne Storey,维多利亚大学;发布于 **2026-02-09**,frontmatter 与 URL 双确认)
- 备注: 本 wiki 第三十四篇源文档;**认知债概念的一手来源**(此前 [[2026-06-05-intent-debt|意图债]] 与 [[2026-05-24-orchestration-tax|编排税]] 均二手引用 Storey;现可核实);与 Triple Debt Model 论文(arXiv 2603.22106)同作者——此篇为其面向工程社区的展开

## 摘要

生成式与代理式 AI 把工程关注的债务从**技术债(住在代码里)转移到认知债(住在开发者脑子里)**——债务从"走得快"复合而来,住在人的脑中,影响他们继续"走得快"或做变更的能力。即使代理产出易理解的代码,人类可能已经"丢了剧本":不知道程序该做什么、意图怎么被实现、怎么改。缓解:至少一个人类完全理解每个 AI 生成的变更才 ship、记录 what 与 why、定期检查点(评审/回顾/知识共享)重建共享理解;认知债可能比技术债威胁更大。

## 关键主张

- **定义**:技术债在代码里;认知债在开发者头脑里——影响"go fast"与做变更的能力;"即使 AI 代理产出容易理解的代码,人类也可能只是丢了剧本(lost the plot):不知道程序应该做什么、意图如何实现、如何更改"
- **核心警告**:velocity without understanding is not sustainable——AI 采用后**认知债可能比技术债威胁更大**
- **缓解实践(团队层)**:①每个 AI 生成的变更 ship 前至少一个人类完全理解它 ②记录 not just what changed but why ③定期检查点:评审/回顾/知识共享会议重建共享理解
- **理论基础**:Peter Naur 的经典——**程序不只是源码,而是活在开发者头脑中的理论**(program is a theory,见 [[theory-building]]),碎片分布在许多(可能上千)开发者的脑子里;Naur 几十年前的话在代理时代成为日常现实
- **Brooks 神话人月回声**:给项目加代理 = 加协调开销、隐形决策、认知负荷;代理也可用来管理认知负荷(总结变更),但人类记忆与工作容量的硬约束会被"不惜一切求速度"拉伸
- **Kent Beck**:拒绝慢下来做"make the hard change easy"正是未来认知债与负荷的来源
- **⚠️ raw 版补全三段**(2026-08-03 人工裁剪版核对时补入):①**创业课实证**:7-8 周时一个团队撞墙——简单变更也弄坏意外之处;最初怪技术债(乱代码/坏架构/仓促实现),深挖发现真问题 = 没人能解释"为什么做这些设计决策/各部分如何协作"——"系统理论、共享理解已碎片化或完全消失;认知债累积快过技术债,瘫痪了他们"②**Fowler/Thoughtworks 退思会**(2026-02-09 同日 breakout session,Martin Fowler 组织):讨论开发者需慢下来用结对编程/重构/TDD 同时对付技术债与认知债——"慢下来遵循这些实践,认知债也能降低,团队共享理解被重建"③**认知债警告信号**:团队犹豫变更(怕意外后果)/日益依赖一两个人的"部落知识"/系统逐渐变成黑箱的感觉——"共享理论正在侵蚀的信号"(另:文章开头的 traction 引用指向 MIT media《Your Brain on ChatGPT》)
- **开放研究问题**:怎么测量认知债?什么实践最能预防/减少?分布式团队/开源项目中新人必须重建"理论"时认知债如何扩展?——"理解与管理认知债可能是我们领域面临的最重要挑战之一"

## 与现有 wiki 的关系

- 更新 [[comprehension-debt]](一手来源;与 Osmani 理解力债互为独立提出), [[intent-debt]](债务三元组作者的博客展开), [[orchestration-tax]](Storey 引用一手化;Brooks 回声 = 编排税的学术同构), [[cognitive-surrender]]
- 互证:Brook 回声 ↔ [[orchestration-tax]]("加代理 = 加协调开销/隐形决策/认知负荷" = 编排税的学术表述);"ship 前至少一人完全理解" ↔ [[pr-contract]] 知识转移义务与 [[agent-management]] own 侧;Naur 理论分布 ↔ [[distillation-anxiety]](知识藏匿/继承)与 [[hive-mind]] 组织模型;定期检查点 ↔ Ralph Loop 的评审节奏与 [[agent-management]] 查岗
- 与 [[2026-06-05-intent-debt|Osmani 意图债]] 的关系:Storey 的认知债 = 意图债三元组中的认知债位(被引为 Triple Debt Model 来源);本篇补充了缓解实践与测量呼吁

## 待办 / 后续

- Triple Debt Model 论文已一手化 ✓([[2026-03-23-triple-debt-model]])
- 认知债测量方法仍是开放问题(本篇即呼吁);MIT《Your Brain on ChatGPT》链接可作神经测量背景(与 Kosmyna et al. 2024 呼应)
- raw 版含图片(cognitive-debt.png 信息图),文字内容已全覆盖
