---
type: concept
tags: [ai-agents, rationalization, engineering-discipline, artifact]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [cognitive-surrender, process-over-prose, agent-verification, skills, addy-osmani]
sources: [2026-05-03-agent-skills, 2026-05-05-cognitive-surrender]
status: active
---

# Anti-rationalization tables

反合理化表格:每个工作流配一张"常见跳过借口 → 书面反驳"的表——**对代理(或累了的工程师)还没说出口的谎言的预写反驳**;因为 LLM 极擅长合理化,会产出听起来合理的段落解释为什么这个任务不需要 spec、这个改动可以不评审。

## 关键信息

**形态**(来源: [[2026-05-03-agent-skills]],Osmani,agent-skills 项目中最独特的设计):每个 skill 内含借口 → 反驳表,例如:

| 借口 | 反驳 |
|---|---|
| "任务太简单不需要 spec" | 验收标准仍然适用。五行可以,零行不行 |
| "我以后再写测试" | "以后"是承重词。没有以后。先写失败测试 |
| "测试过了,发吧" | 通过的测试是证据,不是证明。你查运行时了吗?验证用户可见行为了吗?有人类读 diff 吗? |

**原理**:LLM 是"合理化机器"——总能编出令人信服的理由跳过它不想做的部分;反合理化表把这些理由提前写好、配好反驳,**代理(或人)试图用借口时无处可逃**;这正是 [[cognitive-surrender]] 中"反合理化"反制的完整工件化——投降的借口被结构性拦截,而非依赖个人意志

**对人类团队同样有效**:工程腐烂大多不是有人选择做坏工作,而是人们接受听起来合理的跳过理由("发版后再修测试""改动太小不需要设计文档""没事,我们有监控");"写下谎言的团队,谎言更少"——放进 AGENTS.md 或工程 wiki 的团队实践

**配套原则**:验证不可妥协(证据 = 绿测试/截图/日志/评审批准,没有它任务不算完成);process over prose(工作流才有可跳过的步骤,散文没有)(见 [[process-over-prose]])

**公开样例集**:github.com/addyosmani/agent-skills(MIT,27K+ stars)每个 skill 内置表格——此前 wiki 开放问题"反合理化表格的公开样例集"由此部分回答

## 与其他页面的关系

- 机制根源: [[cognitive-surrender]](合理化 = 投降的辩护形态);工程化: [[agent-verification]](证据退出标准)
- 载体: [[skills]]、[[process-over-prose]];倡导者: [[addy-osmani]]
