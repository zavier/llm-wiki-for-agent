---
type: source
tags: [ai-agents, agents-md, empirical-study, efficiency, icse]
topic: ai-agents
created: 2026-11-06
updated: 2026-11-06
status: active
---

# On the Impact of AGENTS.md Files on the Efficiency of AI Coding Agents (ICSE JAWs 2026,2026-01-28)

- 原文: `raw/2601.20404v2.pdf`(arXiv 2601.20404v2,2026-03-30;v1 2026-01-28);ICSE 2026 Journal-Ahead Workshop(JAWs),Rio de Janeiro
- 类型: 实证论文(Lulla, SMU;Mohsenimofidi, Heidelberg;Galster, Bamberg;Zhang, KCL;Baltes, Heidelberg;Treude, SMU)
- 备注: 本 wiki 第六十五篇源文档;**与 ETH 研究结论方向相反的一手反证**——同一个对象(AGENTS.md),测的是**效率**而不是成功率

## 摘要

在 10 个仓库、124 个真实合并 PR 上做**配对实验**(同一快照,有/无根 AGENTS.md 各跑一次),固定 Codex CLI + gpt-5.2-codex。结果:中位墙钟时间 **98.57s → 70.34s(-28.64%)**、中位输出 token **2,925 → 2,440(-16.58%)**,均值分别为 -20.27% / -20.08%。作者结论:根 AGENTS.md 与**更少的探索、更快完成**相关。**没有测正确性**(只抽 50 个任务人工看输出非空、非随机)——这是解读所有"效率提升"时的首要限定。

## 关键主张

**构法**(来源: 同上):起点是先前工作采样的 132 仓库 → 只保留**根目录仅一个** AGENTS.md 的 89 个(排除多文件/子目录重叠造成的混淆)→ 用 gpt-oss-120b + 人工复核按内容分类筛出 26 个(要求含约定与最佳实践、架构与项目结构、项目描述三类)→ 随机取 10 仓库,每仓库至多 15 个 PR。PR 入样:改动 ≤100 行、≤5 文件、已合并、**晚于该仓库引入 AGENTS.md**、只改代码。每任务检出于合并前 commit,移除 AGENTS.md 作对照;任务描述由本地 LLM 生成 GitHub issue 风格(许多 PR 正文为空或只有"fix bug")。

**结果(Table 1)**(来源: 同上):墙钟均值 162.94s → 129.91s(Δ20.27%)、中位 98.57 → 70.34(Δ28.64%);输出 token 均值 5,744.81 → 4,591.46(Δ20.08%)、中位 2,925 → 2,440(Δ16.58%);输入 token 均值 353,010 → 318,652(Δ9.73%)、缓存输入均值 328,877 → 296,079(Δ9.97%),**但两者中位数基本不变或略升**(中位输入反而 +3.41%);总 token 均值 -9.93%。显著项(Wilcoxon,p<0.05):墙钟时间、输出 token。

**不均等受益**(来源: 同上):均值降幅明显大于中位降幅 → 作者推断 AGENTS.md 主要**压掉少数极高消耗的运行**,而不是均匀省;墙钟时间则均值与中位接近(20.3% vs 28.6%),说明是整体加快。

**机制(作者假设,未验证)**(来源: 同上):AGENTS.md 提前给出结构与约定 → 代理不必靠探索性导航自行推断 → 规划轮次更少、重复请求更少。作者明确把 trace 分析列为后续工作——**所以"为什么更快"目前是假设而非证据**。

**作者自陈的边界**(来源: 同上):①只有 Codex + 单一模型,跨 harness/模型待做;②任务被限制在**小改动**(≤100 LoC、≤5 文件)、单根文件、内容合格的文件,因此结论**不能外推**到大型重构或含多份/冲突指令文件的仓库;③**输出质量完全未评**(仅 50 例人工 sanity check),故"效率提升"与"质量不降"是两个独立命题;④未做 trace 归因。

## 与现有 wiki 的关系

- **与 ETH 研究的张力(本 wiki 最重要的对照对)**:ETH(Gloaguen et al.,[[2026-02-12-evaluating-agents-md]])说上下文文件让成本 **+20~23%**;本研究发现 token 与时长**双降 ~20%**。二者并不直接矛盾但不可混用——见 [[context-files-evidence]] 的三个解释(测的指标不同:步数+美元 vs token+时长;文件来源不同:官方 `/init` 生成 vs 开发者手写根文件;任务不同:SWE-bench/CTXbench 冷门仓库 vs 真实 ≤100 行小 PR)
- 更新:[[agents-md]](效率一侧的一手证据)、[[context-engineering]](预载上下文的**省费**方向)、[[agent-evals]](配对设计与"只测效率不测质量"的红线)、[[documentation-redundancy]](效率收益与冗余假说不冲突:省的是导航,不是补文档)
- 与 [[2026-02-11-codex-agent-first-engineering]]"给地图不给说明书"同向:省下来的是**探索**;但本研究没有区分地图里哪部分有效
- 方法学互证:与 [[2026-04-30-cursor-agent-harness-improvement]] 的 Keep Rate 互补——一个测在线质量,一个测运行成本

## 待办 / 后续

- 若能看到 v1(2026-01-28)与 v2(2026-03-30)的差异,补记版本漂移(本页引 v2)
- 缺一环:**同一批任务上成功率**。若后续版本补上正确性评测,整个"效率 vs 成功率"争论才算有共同落点
- 作者 roadmap 中的 trace 分析("更少规划轮次/更少探索")是检验 [[documentation-redundancy]] 的关键实验:若省的是**探索**而非**教学**,则与"概览无用"的 ETH 结论可以调和
- 复现包与数据在作者的 online appendix(论文 [14]);未验
