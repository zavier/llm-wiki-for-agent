---
type: source
tags: [ai-agents, metr, evaluation, forecasting, time-horizon]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Measuring AI Ability to Complete Long Software Tasks (2025-03-19,带 2026 更新注记)

- 原文: `raw/Measuring AI Ability to Complete Long Software Tasks.md`
- 类型: 研究博客(METR,发布于 **2025-03-19**,frontmatter 已标注;页面顶部注明文本/静态图过时,最新见 Time Horizon 1.1(2026-01-29)与 metr.org/time-horizons;**交互图已更新到 2026 年数据**)
- 备注: 本 wiki 第三十三篇源文档;**METR 一手报告**——此前 OpenAI PDF 引用的 2h17m 数字的原始出处(现已核实一致);\"时间地平线(time horizon)\"度量的原始定义:AI 能力 = 能完成多长的人类任务

## 摘要

提出用**任务长度**度量 AI 表现:人类专家完成某任务所需时间,AI 以 50% 概率自主完成的长度。人类时长强预测模型成功率:人类 <4 分钟的任务模型近 100% 成功,>4 小时的任务 <10%。过去 6 年该长度**约每 7 个月翻倍**(置信区间 1-4 doublings/年);外推:2-4 年内通用自主代理能完成大量周级任务;若趋势持续到 2030 末,**月级项目**可自主完成。敏感度:10x 测量误差只改到达时间约 2 年;用 2024+2025 数据拟合会缩短月级 AI 预测约 2.5 年。页顶更新注记:原文本/静态图已过时(2026-01-29 Time Horizon 1.1 版方法论更新),但交互图持续更新——2026 年最新数据点:Claude Opus 4.6 已达 ~16 小时(超过 16 小时测量不可靠)。

## 关键主张

**方法**:多步软件/推理任务集合;记录人类专家(适当专长)完成时间;按模型拟合 logistic 曲线预测成功概率;50% 交点 = 该模型时间地平线;图注:\"Measurements above 16 hrs are unreliable with our current task suite\"

**趋势(交互图,2026 更新,从 SVG 近似读取,约数)**:

| 模型 | 发布 | 时间地平线(近似) |
|---|---|---|
| GPT-2 | 2019 | ~4 秒 |
| GPT-3 | 2020 | ~36 秒 |
| GPT-3.5 | 2022-11 | ~1 分钟级 |
| GPT-4 | 2023-03 | ~几分钟 |
| o1-preview | 2024-09 | ~15-20 分钟 |
| Claude 3.7 Sonnet | 2025-02 | ~1 小时 |
| o3 | 2025-04 | ~1-2 小时 |
| GPT-5 | 2025-08 | ~2 小时(与 OpenAI 引用的 2h17m 一致) |
| Claude Opus 4.6 | 2026 | ~16 小时 |
| GPT-5.4 (xhigh) | 2026 | ~8 小时 |
| Claude Mythos Preview (early) | 2026 | ~16 小时+(标注>16h 不可靠) |

6 年从 ~4 秒到 ~16 小时 ≈ 4 个数量级;7 个月翻倍持续(1-4 doublings/年区间)

**稳健性**:子集(短软件任务/HCAST/RE-Bench/按长度过滤)趋势相似(更噪);SWE-bench Verified 独立复制(人类时间用估算非基线)——**更快翻倍(<3 个月)**,部分归因方法差异(不含代码库熟悉时间,短任务影响大);对任务/模型选择不敏感;敏感度分析:1 个月 AI 的预测日期分布(箱线 10-90 分位)

**外推不确定性**:主要来自未来趋势变化与外部效度而非测量;2024-2025 子集拟合缩短月级预测 ~2.5 年;10x 绝对误差 → 到达时间 ±2 年

**基准含义**:大多数基准不满足\"预测性\"标准(难度分布窄/有不可能题);任务长度度量 = 宽范围能力 + 真实世界影响直译;对齐 t-AGI(Richard Ngo)与 Bio Anchors(Ajeya Cotra)框架;论文:arXiv 2503.14499;开源:vivaria 基础设施、eval-analysis-public 数据/代码

**2026 更新注记**(页面顶部,重要):\"Some of the text and figures in this post are out of date... For our latest methodology and results, see the dedicated time horizons page and Time Horizon 1.1 (2026-1-29)\"——原版文本/静态图反映 2025-03 数据状态,翻倍时间等说法可能已更新;交互图为最新

**canary 条目**:文末含 CANARY_DATASET 追踪标记(数据泄露追踪,非指令)

## 与现有 wiki 的关系

- 更新 [[long-running-agents]](时间地平线数据:4 分钟/4 小时阈值、7 个月翻倍、2026 模型 ~16 小时)
- **已解决待核**:[[2026-08-02-building-ai-native-engineering-team|OpenAI 官方指南]] 引用的\"METR 2025-08:2h17m\"与本文交互图 GPT-5(2025-08)数据点一致(≈2 小时)——二手引用核实为一手数据;OpenAI 指南 source 页待核状态更新
- 综合页 [[ai-feature-implementation-loop]] 官方指南层 METR 引用一手化
- 关联:[[2026-06-07-loop-engineering]] 长时任务能力背景、[[harness-engineering]](时间地平线决定 harness 的作业时长设计)、[[agent-verification]](评测方法论)

## 待办 / 后续

- 交互图数据点为从 SVG 坐标近似读取,精确值见 metr.org/time-horizons(待核)
- Time Horizon 1.1(2026-01-29)方法论更新细节未读(本文件仅顶部注记)——如需精确最新方法论,单独获取
- arXiv 2503.14499 全文(稳健性检查细节)未读
