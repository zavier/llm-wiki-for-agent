---
type: source
tags: [ai-agents, comprehension-debt, theory-building, goedecke]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-03
status: active
---

# In defense of not understanding your codebase (2026-07-11)

- 原文: `raw/In defense of not understanding your codebase.md`(AI 直抓裁剪版,2026-08-03;raw frontmatter 的 `published:` 与 `author:` 为空)
- 类型: 个人博客文章([[sean-goedecke]],seangoedecke.com);本 wiki **第三十九篇源文档,首篇 Goedecke 源**
- 出处核实: 发布 **2026-07-11**(站点文章页头确认,标签 "software design, naur theory";popular 页抓取曾现异值,以文章页为准)
- 互文: 与 [[2026-02-09-cognitive-debt|Storey 认知债]]、[[2026-03-23-triple-debt-model|Triple Debt Model]] 同论 Naur 1985《Programming as Theory Building》——Storey 以它立论,本篇直接反驳(交锋点见 [[theory-building]])

## 摘要

为大公司工程师的"部分理解"状态辩护:小代码库/低流动团队(pure 文化)主张必须完全理解,大代码库/高流动团队(impure 文化)只能局部理解——后者才是大系统常态,而且没有问题。直接反驳 Naur 的"理论不可重建、应废弃重写":大系统无法从零重建,且被遗弃的代码库一直在被新人复活。核心:大系统里**人人都持部分错误的理论**,能力 = 带着部分正确的理论工作(take a position、最 educated guess、承担后果);理论维护只是众多工程价值之一,LLM 是双刃剑(更难建详细理论,但能快速建部分理论并更有效利用——作者自认"仍在思考"的复杂权衡)。

## 关键主张

- **两种工程文化**(另文详述于 pure/impure 工程):pure(完全理解;Redis、The Witness)vs impure(局部理解;Google 搜索后端、GitHub);pure 在线上讨论**过度代表**(开源作者更爱写博客、原始内容更抢眼、专有系统写不得、写大代码库需要太多特定上下文)——"在很多环境里,部分理解没什么不对;在大系统里,部分理解就是最好的你能做到"
- **驳 Naur,两条**:①**大系统无法从零重建**——有用户的系统含数千个 weird cases/quirks 不可重实现(机制:[[wicked-features]]);成功的重写总是先切出小隔离块、一块块重写——"重写 = 对旧系统做一系列修改,改不动旧系统就换不掉它"②**废弃系统一直在复活**——几人在错误时机离职或停维护一年就出现;作者本人多次接手废弃代码库:先端到端理解一条流,再逐步扩展、谨慎修改——"建立新理论是可能的"
- **人人都持部分错误理论**:系统太大,没人(或整个团队)装得进脑子(nobody knows how software products work);不能等完美理解的人给答案——"如果你称职,**那个人就是你**";做最 educated guess,承担后果
- **对 Naur 的宽容**:1985 年的"大程序"是 20 万行工业监控程序、编译器;GCC 1987 约十万行 → 2015 超一千四百万行;一两十万行重写相对直接(还能复用测试),一两百万不行
- **理论构建是众多权衡之一**(LLM 段落):LLM 常被指责阻碍理论构建——"过于简化":双刃剑——更难构建详细心智理论,但能快速构建部分理论并借它更有效工作;作者未下结论(注意:他承认"更难",与"AI 必损理解"叙事同向,对冲的是单向断言)
- **损害理论维护的还有**:别人在代码库里写代码/法定功能(无障碍、数据保护)/同事离职转组/安全补丁升级/引入依赖——"维护理论"常为速度、合规或政治让路;**被付钱 = 采纳雇主的工程价值集**(纯工程师的完整理解偏好留给自己的开源业余项目,这没问题)
- **edit 补充**:lobste.rs——能"局部"推理代码自古就是 CS 核心目标;Joel Adejola 推文:**理论可能是时间性的**——能答"为什么此时建 X""Y 何时加入"(→ [[intent-debt]]);拒绝给文章打 AI 标签(HN 因一段 LLM 文字打 vibecoding 标签,作者坚持不 tag AI)

## 与现有 wiki 的关系

- 核心更新 [[comprehension-debt]]:部分理解 = 大系统常态与**能力**,而非纯债务;LLM 双刃剑对冲"AI 必损理解"单向叙事;时间性理论连 [[intent-debt]]
- 更新 [[cognitive-surrender]]:"部分理论 + 承诺猜测" = 完整理解 vs 投降之外的第三路径
- 更新 [[distillation-anxiety]]:程序理论可从代码重建(复活是常态)→ 反证"知识随人消失";但组织隐性知识 ≠ 程序理论,边界需区分
- 更新 [[2026-02-09-cognitive-debt|Storey 认知债源页]] 与 [[2026-03-23-triple-debt-model|论文源页]]:Naur 引用指向新概念页 [[theory-building]]
- 新增 [[theory-building]](Naur 1985 概念页——Storey 与 Goedecke 的交锋点)、[[sean-goedecke]](实体)
- 互证:重写 = 切块逐块 ↔ [[comprehension-debt]] 的"架构尺度而非逐行尺度";"那个人就是你" ↔ [[cognitive-surrender]] 反制的"盯住信心的来源";"人人部分理论" ↔ Storey"不需要一个人理解全部,需要足够共享"(Shared understanding 层)

## 待办 / 后续

- Goedecke 系列为候选源:pure/impure 工程文化、Taking a position、Nobody knows how software products work、How good engineers write bad code at big companies(文尾互链)
- "LLM 双刃剑"是作者自认未定论的问题——博客有 naur theory 标签,主题持续,跟进后续展开
- 新张力(暂不建页):"部分理解无妨"(Goedecke)vs "理解差距是债"(Storey/Osmani)——差异在**测量单位与时间尺度**:Goedecke 辩护分布式理解的稳态,债务框架针对分布式理解的失效(速率/检测难度,论文明言"分布式理解自古有之");synthesis 候选
