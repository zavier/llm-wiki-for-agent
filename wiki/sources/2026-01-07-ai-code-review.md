---
type: source
tags: [ai-agents, code-review, verification, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# AI writes code faster. Your job is still to prove it works. (2026-01-07)

- 原文: `raw/AI writes code faster. Your job is still to prove it works..md`
- 类型: 技术博客([[addy-osmani|Addy Osmani]],addyosmani.com;**发布于 2026-01-07**,frontmatter 已标注)
- 备注: 本 wiki 第十四篇源文档;Osmani 的第五篇源(时间上是他四篇中的最早一篇:2026-01-07 评审 → 01-13 spec → 02-25 factory → 04-19 harness);主题:AI 时代的代码评审——负担转移与证据义务

## 摘要

AI 没有杀死代码评审,而是**把证明负担显式化**。核心判断:如果 PR 里没有"它工作"的证据,你不是更快了,只是把工作推给了下游。单独开发者靠测试自动化跟上 AI 速度("信任 vibe"),团队靠评审建立共享上下文与责任;两种模式都以验证(谁、什么、何时)为分野。给出可落地的 **PR Contract**(作者对评审者的四字段证据契约)与五条核心原则。

## 关键主张

- **负担转移**:2026 年初 30%+ 资深开发者主要提交 AI 生成代码(InfoWorld 调查,二手);AI 擅长起草功能、栽在逻辑/安全/边界——逻辑错误率高出 75%(CodeRabbit,二手);"如果你没亲眼见过代码做对的事,它就不算工作"——AI 放大这条规则,不是豁免
- **Solo vs 团队**:solo"以推理速度发货"——只审关键部分,靠测试兜底(Peter Steinberger:"大部分代码我不读");瓶颈从打字变为推理时间;**陷阱:没有强测试实践,感知的速度收益消失——"跳过评审不是消除工作,是推迟工作"**;负责任者用高覆盖率(>70%)+ AI 生成的端到端测试做安全网;语言无关、数据驱动的测试是游戏规则改变者(让代理能用任何语言构建/修复并边做边验);solo 仍要做最终产品的手动测试与批判性推理;引 [[simon-willison]]:"你的工作是交付你证明过能工作的代码"
- **团队:评审成为限速器**:AI 不能替代人类判断与签字(Greg Foster/Graphite:"AI 永远不会成为人类工程师签字的替身");AI 提升产出量把负担转给人——**PR 变大 ~18%、每 PR 事故 +24%、变更失败率 +30%**(Jellyfish/Cortex,二手);当产出增速超过验证容量,评审成为限速器;"如果代码从未被同伴读过,我们冒巨大风险";对策:增量主义(把代理输出拆成可消化的 commit),人类签字转向 AI 漏掉的东西(路线图对齐、机构上下文)
- **安全不可谈判**:约 **45% 的 AI 生成代码含安全缺陷**(Veracode,二手);逻辑错误 1.75×、**XSS 2.74×**(ACM 论文,二手);代理工具与 AI 集成 IDE 带来新攻击面(prompt injection、数据外泄、甚至 RCE);**规则:凡触碰 auth/支付/secrets/不可信输入,合并前必须人类威胁模型评审 + 安全工具扫描**(把 AI 当高速实习生)
- **评审即知识转移**:AI 写代码而无人能解释 → on-call 变得昂贵;OCaml 维护者拒绝 13,000 行 AI 生成 PR——不是代码不好,是没人有带宽审,且**审 AI 代码比审人代码更费力**;"AI 能淹没你,团队必须管理体量避免评审瓶颈"
- **AI 评审工具的配置**:体验两极——有团队抓到 95%+ bug;也有开发者视为"文本噪音";需调灵敏度、关无用评论类型、定 opt-in/opt-out;配置得当可抓 70-80% 低垂果实(Graphite,二手),把人解放给架构与业务逻辑;多模型评审(生成用一个模型、审计用安全向模型)可抵消偏差
- **PR Contract**(见 [[pr-contract]]):①What/why(1-2 句意图)②Proof it works(测试通过、手动步骤、截图/日志)③Risk + AI role(风险分层 + 哪些部分 AI 生成)④Review focus(1-2 个人类评审重点);"填不出来 = 你不够理解自己的变更,没资格请别人批准"
- **五原则**:坚持证据而非承诺(没有新测试或演示,PR 不许上);AI 是一审不是终审(spellcheck 不是编辑);人类评审聚焦 AI 漏的(安全洞、代码重复、可维护性);强制增量开发(小提交、清晰消息、**绝不提交无法解释的代码**);维持高测试标准(AI 擅长起草边界用例测试)
- **展望**:瓶颈从写代码移到**证明它工作**;评审变成"审对话/计划"而非逐行 diff;AI 治理(公司政策、签字要求、**"AI code auditor" 角色**);"proof over vibes";人类最终负责

## 与现有 wiki 的关系

- 新建概念: [[pr-contract]]
- 更新了 [[addy-osmani]](第五篇源)、[[agent-verification]](验证瓶颈的量化 + 人工评审侧)、[[llm-as-a-judge]](AI 评审工具配置)、[[ai-feature-implementation-loop]](知识转移失败模式 + 安全规则)
- 与既有证据链互证:验证是瓶颈(factory model)→ 本篇给出量化(事故 +24%、失败率 +30%、45% 安全缺陷);"要求证据而非断言"(Claude Code 实践)→ PR Contract 是其正式化;"审 AI 代码更费力" ↔ 评估器调优成本(Anthropic harness);代理工具攻击面 ↔ MCP 供应链风险(harness 工程)
- 新失败模式入账:知识转移断裂(无人能解释 → on-call 昂贵);评审限速(产出 > 验证容量)

## 待办 / 后续

- 核实各统计的原始出处(InfoWorld/CodeRabbit/Jellyfish/Cortex/Veracode/ACM)——均为二手引述
- 跟进"AI code auditor"角色与 AI 治理政策的落地形态;PR Contract 在团队中的实际采用数据
