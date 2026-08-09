---
type: source
tags: [ai-agents, responsibility, code-review, ethics, discourse]
topic: ai-agents
created: 2026-08-09
updated: 2026-08-09
status: active
---

# Your code is your responsibility, even if AI wrote it (2025-09-15)

- 原文: `raw/Your code is your responsibility, even if AI wrote it.md`
- 类型: 个人博客文章([[senko-rasic]]);本 wiki **第五十一篇源文档**
- 出处核实: 发布 **2025-09-15**(raw frontmatter);URL https://blog.senko.net/your-code-is-your-responsibility-even-if-ai-wrote-it
- 定位: [[2026-08-08-code-was-never-the-hard-part|craft 辩护文]] 的**姊妹篇/前身**——责任观的原发(早近一年),2026-08 文将其列为底线("don't abdicate your responsibility");PR 提交义务的最小声明版

## 摘要

按 "Create PR" 按钮 = 接受所提交代码的**全部责任**——与工具无关(vibe-coding、AI 自动补全、抄 Stack Overflow、外包、请阿姨帮忙):提交即声明 ①完全理解代码在做什么 ②有合法权利提交(不是偷)。评审者视角:作者不懂代码如何/为何工作 = red flag;**隐藏** AI/Stack Overflow/Upwork 的使用 = 严重违反职业操守。例外:spike/原型/快速丢弃代码/低影响内部工具可 spaghetti——"vibe-code 一个功能性 mockup?请便"。"The AI wrote it" = "狗吃了我的作业"。

## 关键主张

- **提交即声明**:按 Create PR 即 attest 完全理解 + 合法权利;责任与所用工具无关——所需质量与理解程度由场景(生产 vs 原型)决定,不由工具决定
- **操守面**:评审/生产代码时作者不知 how/why = red flag;**隐藏使用 AI/SO/Upwork 比使用本身更糟**——"严重且不可接受的职业操守违规"
- **例外区间**:spike/原型/throwaway/低影响内部工具——"duct-tape spaghetti 完全没问题";vibe-code 功能性 mockup 无罪;除最初级新手(他们要学的是这件事本身)外,每个人都该知道需要放多少 care
- **不可弃责**:"The AI wrote it" carries the same weight as "the dog ate my homework"

## 与现有 wiki 的关系

- **PR 契约的独立提出者**(见 [[pr-contract]]):Osmani 版 = 四字段证据义务清单;Senko 版 = 提交前最小声明(理解 + 合法权利)——互补:Senko 补 **合法权利**(版权/许可证:SO 复制、AI 输出的许可证问题的入口)、补 **披露义务**(隐藏 AI/外包使用 = 操守违规)、补 **例外区间**(原型/内部工具免于完整理解义务);"狗吃作业" ↔ "A computer can never be held accountable"(人类问责底线同构)
- [[vibe-coding]] 的合法边界独立确认:spike/原型/mockup/内部工具 = vibe 无罪场景;"生产代码要求理解"与工具无关——与 Osmani"原型用 vibe 没问题,上线必须切回工程模式"一致
- [[cognitive-surrender]]:不披露 + "AI 写的"借口 = 投降的社交化(见 [[2026-08-08-code-was-never-the-hard-part|craft 文]] 的 meat proxy 讨论;此篇为其责任观基础)
- [[agentic-engineering]]:"如果你解释不了一个模块是干什么的,它就不该进"的独立表述(提交义务版本)
- 实体: [[senko-rasic]] 第二源;与 [[2026-08-08-code-was-never-the-hard-part]] 构成 Senko 立场对(2025-09 责任观 → 2026-08 以此为底线论 craft)
- **分歧/张力**:"隐藏 AI 使用 = 严重违规" vs 行业现实——AI 代码占比已普遍(20-40% 量级,Faros/GitClear 数据类)且大量未标注;披露规范是公司政策/社区规范的灰色带,Senko 立场 = 个体操守端(见主题页开放问题)
- 相关文:[[2026-08-03-dont-be-a-meat-proxy|gruhn 的 meat proxy]](2026-08-03,已收录第 52 源)——术语一手化,见 [[meat-proxy]]

## 待办 / 后续

- 开放问题:见主题页——AI 代码披露/标注的行业规范实证(政策差异、许可证实践)
