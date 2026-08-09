---
type: source
tags: [ai-agents, discourse, human-factor, communication]
topic: ai-agents
created: 2026-08-09
updated: 2026-08-09
status: active
---

# Don't be a meat proxy (2026-08-03)

- 原文: `raw/Don't be a meat proxy.md`
- 类型: 个人博客文章([[niklas-gruhn]]);本 wiki **第五十二篇源文档**
- 出处核实: 发布 **2026-08-03**(raw frontmatter);URL https://gruhn.me/blog/2026-08-03/;作者身份:DEV 社区资料(德国)、LinkedIn 转述(Tech Manager & Software Engineer @ Appliscale,未直接核实)
- 定位: "meat proxy" 术语的**一手源**;被 [[2026-08-08-code-was-never-the-hard-part|Senko craft 文]](2026-08-08)引用为底线——术语从提出到被引用的 5 天传播

## 摘要

"Claude said:[整段原文]"式的转发不增任何价值——接收者自己能直接问 Claude,更快且能控制上下文,"我不需要中间的肉代理"。正确姿势:prompt AI 可以,但**读、理解、验证,然后用自己的话写回复**——"自己的话"是前三步的体面证书(decent certificate)。代码评审案例:把票面描述粘贴进 Claude Code、不看代码、把评审反馈也粘贴回去迭代——"谁做了实现?**评审者做的**,用 Claude Code,而你是个 meat proxy"。

## 关键主张

- **定义**:meat proxy = 人作为 AI 输出与接收者之间的**原样转发层**(Slack 回答/PR 反馈/WhatsApp 争论);作者自认干过,"但被接收端太多次了"
- **为什么零增值**:读 AI 输出是额外努力——冗长、全似可信的胡说(plausible nonsense)、术语密集(例:"NATS control-plane events: stream leader election / R3 quorum re-form during pod churn",几乎每个词都要查);接收者自己控制上下文更快
- **证书机制**:用自己的话重写 = "体面证书",证明你做了读/理解/验证三步——把 offloading 健康面变成**可检验形式**
- **代码评审 = 责任反转**:零努力交付工作流(copy ticket → 不看代码 → 粘贴反馈迭代)下,**实现责任转移给评审者**(他们用 Claude Code 完成实现),作者只是转发层——与"提交 PR = 声明完全理解"([[2025-09-15-your-code-is-your-responsibility]])正面冲突

## 与现有 wiki 的关系

- 新概念页 [[meat-proxy]](术语一手化):[[cognitive-surrender]] 的沟通侧形态;与 Goedecke 薄包装([[2026-05-09-ai-makes-weak-engineers-less-harmful]])同族不同侧(实现 vs 沟通)
- 新实体 [[niklas-gruhn]]
- 互证:证书机制 ↔ [[cognitive-surrender]] 反制启发式("读输出前先构建期望"、把 diff 当 AI 没写过——own words = 其沟通版);责任反转 ↔ [[pr-contract]] 知识转移义务/"A computer can never be held accountable";"我能直接问 Claude" ↔ [[expertise-leverage]](代理无专长可加,信息直达模型);术语密集 ↔ [[comprehension-debt]](转发者既没消化也没降低)
- 被引用:[[2026-08-08-code-was-never-the-hard-part]](Senko:不要当 meat proxy)与 [[2025-09-15-your-code-is-your-responsibility]](责任观)的"未收录待核"标注清除
- **分歧记录**:无事实矛盾;"meat proxy 零增值"在"AI 输出需人工缓冲"场景(审计/合规/安全审查)的适用边界未讨论——转发可能是政策要求(待核)

## 待办 / 后续

- 潜在新源:gruhn 的 "What happens at 60% unemployment rate?"(2026-02-22,职业/行业侧)
- 开放问题:见主题页——meat proxy 的可测量性(原样转发率 = 投降的沟通侧代理)
