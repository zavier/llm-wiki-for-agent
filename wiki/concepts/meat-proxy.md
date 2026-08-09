---
type: concept
tags: [ai-agents, human-factor, failure-mode, communication]
topic: ai-agents
created: 2026-08-09
updated: 2026-08-09
refs: [cognitive-surrender, agentic-engineering, pr-contract, expertise-leverage, vibe-coding, comprehension-debt, sean-goedecke, senko-rasic, niklas-gruhn, agent-verification]
sources: [2026-08-03-dont-be-a-meat-proxy, 2026-08-08-code-was-never-the-hard-part]
status: active
---

# Meat proxy (肉代理)

人作为 AI 输出与接收者之间的**原样转发层**——"Claude said:" 后整段粘贴;术语由 [[niklas-gruhn|Gruhn]] 2026-08-03 提出,被 [[senko-rasic|Senko]] 2026-08-08 引用为底线("不要当 meat proxy")。是 [[cognitive-surrender|认知投降]] 的**社交化/沟通侧形态**。

## 关键信息

**定义**(来源: [[2026-08-03-dont-be-a-meat-proxy]],一手)

- Slack 回答/PR 反馈/WhatsApp 争论里回"Claude said: [整段原文]"——不加价值:接收者自己能用 Claude,更快且能控制上下文,"我不需要中间的肉代理"
- **为什么零增值**:读 AI 输出是额外努力——冗长、全似可信的胡说、术语密集("NATS control-plane events: stream leader election / R3 quorum re-form during pod churn" 例,几乎每个词都要查)

**正确姿势 = 证书机制**:prompt AI 可以,但不要转发输出——**读、理解、验证,然后用自己的话写回复**;"自己的话 = 你做了前三步的体面证书"(decent certificate)——offloading 健康面的可检验形式,对应 [[cognitive-surrender]] 反制启发式("读输出前先构建期望")的沟通版

**代码评审案例 = 责任反转**:零努力交付工作流(copy ticket → 不看代码 → 粘贴评审反馈迭代)下,"谁做了实现?**评审者做的**——用 Claude Code,而你是个 meat proxy"——作者只剩转发,实现与责任都转移给评审方;与 [[pr-contract]] 的"提交 PR = 声明完全理解"([[2025-09-15-your-code-is-your-responsibility]])正面冲突,也违背知识转移义务("原作者解释不了,值班工程师更解释不了")

**与薄包装的关系**(Goedecke,来源: [[2026-05-09-ai-makes-weak-engineers-less-harmful]]):同一现象的**两侧**——薄包装 = 任务/代码粘贴往返(实现侧,delegate 给模型);meat proxy = 输出原样转发(沟通/批准侧,relay 给人类接收者);评审案例 = 两者叠加(粘贴进 + 粘贴出);薄包装的"改进"解读(地板抬高)对 meat proxy 不成立——接收端明确无增值("我可以直接问 Claude")

**与专长的关系**:接收者不需要代理 = 代理无专长可加(信息已直达模型);[[expertise-leverage|专长]] = 把输出变成自己的话的能力(读得懂、验得了、改得动);[[comprehension-debt]]:术语密集输出 = 理解债务的即时形态(转发者既没消化也没降低)

## 与其他页面的关系

- 上级: [[cognitive-surrender]](机制:无独立观点时输出以你的名义被转发)、[[vibe-coding]](评审案例 = 生产 vibe 的零评审形态)
- 反制: [[pr-contract]](证据义务)、[[agent-verification]]、[[agentic-engineering]](人拥有正确性)
- 实体: [[niklas-gruhn]](提出者)、[[senko-rasic]](引用者/底线化)
- 一手源: [[2026-08-03-dont-be-a-meat-proxy]]
