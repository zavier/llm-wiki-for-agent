---
type: source
tags: [ai-agents, goedecke, career, industry]
topic: ai-agents
created: 2026-08-04
updated: 2026-08-09
status: active
---

# I don't know if my job will still exist in ten years (2026-03-06)

- 原文: `raw/I don't know if my job will still exist in ten years.md`(AI 直抓版 2026-08-04;raw frontmatter 由抓取脚本补全)
- 类型: 个人博客文章([[sean-goedecke]]);本 wiki **第四十八篇源文档**
- 出处核实: 发布 **2026-03-06**(站点页头 "March 6, 2026" 确认;tags: tech companies, ai, zirp);URL https://www.seangoedecke.com/will-my-job-still-exist/;HN 讨论(47292902)、r/programiranje、Tildes、lobste.rs 评论
- 定位: Goedecke 职业/行业侧——[[2026-05-09-ai-makes-weak-engineers-less-harmful|weak-engineers-less-harmful]]"工程师给 AI 加什么价值"追问的展开(行业收缩版);[[2026-04-03-programming-with-ai-agents-as-theory-building|theory-building 源]]的同标签相关文;**与 [[2026-07-24-llms-reward-expertise|llms-reward-expertise]] 构成同一作者的立场弧线**(2026-03 悲观 → 2026-07 专长升值)

## 摘要

2021 当个好工程师感觉很棒;2026 作者不确定软件工程行业能否再活十年——"我爱的这份工作正在消失"。三个论证:自尝苦果(编程自动化其他行业,现在轮到自己的行业;staff 工程师大概最后被替换);超调/欠调框架(未来十年主导问题 = 行业对 AI 代理能力是超调还是欠调,超调世界资深需求中期上升);反驳 Jevons 效应(AI 代理修 bug/清理和写新代码一样好——"没有真正的新能力 AI 代理需要才能取代我,只需更好更可靠")。

## 关键主张

- **时代感受**:2021 工作不会枯竭的信心 vs 2026 "行业能否再活十年";出路 = 监督 AI 代理的利基,或离开行业
- **自尝苦果(tasting our own medicine)**:编程的杠杆意义 = 自动化掉其他工作 → 自动化掉自己行业 = "某种宇宙正义";staff 的工作早就像监督 AI 代理(用人类语言沟通、确保别人在正轨)——**"为什么雇一群工程师当少数资深者的手,而不花零头租 Claude Opus 4.6 实例?"** → 初级/中级工程师先受苦
- **超调 vs 欠调(overshooting/undershooting)**:欠调 = 继续雇人,工作更久但"我的工作"= 监督代理群(更多时间评审代码而非写、读模型输出而非代码库);超调 = 停止雇人太早 → 公司抢技术人才管理 AI 生成代码库、初级市场枯竭、资深/staff 存量停滞 → **中期需求上升**(直到模型完全替换)——"超调世界我可能中期更好"
- **反驳 Jevons 效应**:乐观派("软件总量激增 → 工程师需求上升";"总有人清理 AI 代码")需要 AI 编程**平台期**(能大量产代码、不足以维护)——"维护比写难"常识上 plausible 但作者认为**不成立**:过去一年几乎把所有代码库问题并行问 agent,看到它们从"无望"→"有时比我快"→"通常比我快、有时更有洞察";**修 bug/清理能力 = 生成能力,每月进步**
- **结论**:没有真正新的能力是 AI 代理缺的——只需更好更可靠 → 需求更可能降而非升;"自动化列车追上我们,工程师抱怨有点傻";希望自己错
- **历史安慰无效**:高级语言/外包都没杀死行业,但行业确实会因技术过时而死;2026 的自己在零利率时代结束后仍觉得幸运

## 与现有 wiki 的关系

- 更新 [[sean-goedecke]](第 10 源 + 立场张力标注)、[[agentic-engineering]](行业级雇佣风险)、[[expertise-leverage]](乐观/悲观张力)
- 互证:staff 最后被替换 ↔ [[expertise-leverage]] 的专长梯度(弱端托底 → 中级压缩 → 资深监督);"监督 AI 代理群" ↔ [[agent-management]]/[[orchestration-tax]](评审时间 > 写代码时间);初级池枯竭(超调世界)↔ [[distillation-anxiety]] 培养断裂;能力趋势("更好更可靠即可")↔ [[2025-03-19-measuring-ai-long-tasks|METR 时间地平线]]
- **分歧记录**:Goedecke"AI 维护 = 生成能力" vs [[2026-06-15-agentic-code-review|agentic-code-review]] 的 Faros 数据(评审时长 +441.5%、churn +861%、"写便宜了,理解没便宜")——AI 修 bug 能力上升 vs 人类评审成本上升,两侧都真实,交汇点未定(见主题页开放问题)
- **立场张力(同一作者)**:03-06 悲观(需求收缩)vs 07-24 乐观(专长升值、人=瓶颈)——调和:专长决定**相对位置**(谁最后留下),行业收缩是**绝对量**
- 相关文:why-do-ai-enterprise-projects-fail(95% AI 企业项目零回报,MIT NANDA 报告)——潜在新源
- **同构互证**:[[2026-08-08-code-was-never-the-hard-part]](Senko,2026-08-08)——what changes / what doesn't / how to thrive 结构相同,但问题维度不同:Goedecke 问"行业是否收缩",Senko 答"技艺从未容易且仍相关",不冲突(见 [[senko-rasic]])

## 待办 / 后续

- 开放问题:Jevons 效应 vs AI 维护能力的实证缺口(见主题页);行业需求预测的量化(与 METR 外推、Osmani 宏观指标核实同族)
- 潜在新源:why-do-ai-enterprise-projects-fail(95% 失败率,MIT NANDA 报告二手)、good-times-are-over(zirp 主题,与 wiki 弱相关)
