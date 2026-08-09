---
type: concept
tags: [ai-agents, code-review, verification, contract]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-09
refs: [agent-verification, conformance-testing, llm-as-a-judge, addy-osmani, simon-willison, factory-model, comprehension-debt, cognitive-surrender, openai, agent-management, intent-debt, senko-rasic]
sources: [2026-01-07-ai-code-review, 2026-03-14-comprehension-debt, 2026-05-05-cognitive-surrender, 2026-02-11-codex-agent-first-engineering, 2026-01-08-coding-agents-manager, 2026-06-15-agentic-code-review, 2026-08-02-building-ai-native-engineering-team, 2025-09-15-your-code-is-your-responsibility]
status: active
---

# PR contract

PR 契约:作者对评审者的**证据义务清单**——AI 生成代码时代代码评审的显式化框架;把"证明它工作"从口头期望变成四个必填字段。

## 关键信息

**四字段**(来源: [[2026-01-07-ai-code-review]])

1. **What/why** — 意图 1-2 句
2. **Proof it works** — 测试通过、手动验证步骤、截图/日志
3. **Risk + AI role** — 风险分层(high=支付类)+ 哪些部分 AI 生成
4. **Review focus** — 1-2 个人类评审重点(如架构)

"这不是官僚主义,是对评审者时间的尊重,也是作者问责的强制函数;填不出来 = 你不够理解自己的变更,没资格请别人批准。"

**2026 升级:证据门槛与意图恢复**(来源: [[2026-06-15-agentic-code-review]],Osmani):评审者成为"第一个见到这段代码的人"——agent 的推理在 diff 产生瞬间被丢弃,契约的重心从"检查推理"移到"**恢复意图**";修复 = 工具问题:代理在 PR 上写**决策日志**(想做什么、排除了什么、为什么),大块重构成本消失;**提高进入评审的门槛**:拒绝无证据变更(builder.io)——变更说明/diff 可读(非 3500 行无注释)/测试输出/证明真跑过,把意图重构推回提交方(便宜)而非自己吸收(贵);**刻意小 PR**:agent PRs 平均大 51%(Faros),reviewer 参与度是合并的最强预测之一,大而不可审被拒或橡皮图章——"人可读的 diff 是设计约束,不是礼貌";**快失败昂贵尾部**:agent 擅长小而清(~28% 即时合并)但收主观反馈即 ghost 弃来回(被拒 agent PR 38% 归因弃审,arXiv 2601.15195)——先 triage 分拣,别在 agent 一推就弃的 PR 上耗人(断路器预测:arXiv 2601.00753)

**配套原则**

- **证据而非承诺**:"没有新测试或演示,PR 不许上";让代理生成后立即执行代码/跑单测再交
- **AI 是一审不是终审**:AI 评审输出是建议性(spellcheck,不是编辑);一个 AI 写、另一个 AI 审、人类编排修复;**评审器异质性**(来源: [[2026-06-15-agentic-code-review]]):4 工具并行 93.4% 的发现恰好只被一个工具抓到、四个从未同抓一行——跑两个性格不同的,别纠结单一最佳;AI 评审 = **传感器不是裁决**(数据不是决定),"looks good"的自信声音是它没赚到的信心([[cognitive-surrender]])(见 [[agent-verification]])
- **人类聚焦 AI 漏的**:安全洞、重复代码(常见 AI 缺陷)、可维护性;AI 分流易事,人类攻坚难事
- **增量强制**:小提交 + 清晰消息 = 检查点;**绝不提交无法解释的代码**
- **知识转移义务**:AI 写的代码必须有人能解释——否则 on-call 变得昂贵;原作者解释不了,值班工程师凌晨 2 点更解释不了
- **人类问责底线**("A computer can never be held accountable. That's your job as the human in the loop.")——无论 AI 贡献多少,人负责
- **独立提出者:提交即声明**(来源: [[2025-09-15-your-code-is-your-responsibility]],[[senko-rasic|Senko]],2025-09-15):四字段契约的**最小声明版**——按 Create PR = attest ①完全理解代码在做什么 ②有合法权利提交(不是偷);与 Osmani 版互补,补三样:①**合法权利字段**(版权/许可证:SO 复制、AI 输出许可问题的入口)②**披露义务**(隐藏 AI/Stack Overflow/Upwork 使用 = "严重且不可接受的职业操守违规"——未披露比使用本身更糟)③**例外区间**(spike/原型/throwaway/低影响内部工具免于完整理解义务,vibe mockup 无罪——质量要求由场景决定不由工具);"The AI wrote it = 狗吃了我的作业" ↔ 人类问责底线同构(独立表述)

**适用分野**:solo(测试自动化兜底 + 关键部分人工复审)与团队(评审聚焦上下文/合规/路线图)都适用;团队场景另需管理体量——拆小 PR 防评审限速(产出 > 验证容量时评审成为限速器,OCaml 13k 行 PR 被拒即案例)

**契约的隐性前提与边界**(来源: [[2026-03-14-comprehension-debt]]):契约假设"评审 = 理解",但**"被评审的代码 = 被理解的代码"已不再成立**——填满四字段 ≠ 真正理解;速度不对称(初级生成快过资深审计)使"Proof it works"不足以替代理解;证据义务是必要非充分(见 [[comprehension-debt]])

**契约的校准功能**(来源: [[2026-05-05-cognitive-surrender]]):填契约强制"形成独立观点"——正是对抗 [[cognitive-surrender|认知投降]]的动作;配套启发式:读输出前先构建期望、把 diff 当成 AI 没写过(假装初级工程师提交)、让模型反驳自己、察觉疲劳、盯住信心来源;Proof 字段 = 验证硬退出标准("这是它工作的证据"而非"看起来完成")

**PR packet = 契约的操作化**(来源: [[2026-01-08-coding-agents-manager]],Osmani):结构化 PR 附包——变更摘要/为何此法/触碰文件/测试计划+结果/风险与后续——要求代理在最终消息里附上测试套件输出、lint+typecheck 结果、行为变更的测试修改;四字段(意图/证据/风险/评审重点)从"人类评审义务"扩展为"代理交付物格式";配套委派三档(delegate/review/own,见 [[agent-management]])

> [!warning] 阵营分歧:OpenAI 实验(2026-02-11)把评审几乎全部转为智能体对智能体、人类可审但不必须、减少阻塞门、偶发失败重跑——"纠错成本低、等待成本高";与本契约的人类签字立场(评审即知识转移、人工审查是安全系统)直接矛盾;适用边界疑似:内部 beta 工具 vs 生产系统、团队规模、知识转移需求(见 [[2026-02-11-codex-agent-first-engineering]])

> [!note] OpenAI 官方指南立场(来源: [[2026-08-02-building-ai-native-engineering-team]]):OpenAI 对外指南明确"工程师委派首轮评审给 agent,但 **own 最终评审与合并**"——官方建议与人类签字阵营一致,与自家内部实验(评审代理化)构成**同公司两种声音**;解读:指南 = 对外生产建议(客户采用),实验 = 内部零人工探索——"对外建议保守、内部实验激进"是阵营分歧的厂商内部镜像;也呼应"AI 评审不必然加速但防缺陷"(与 441% 时长是同一事实的两面)

## 与其他页面的关系

- 是 [[agent-verification]] 的人类侧闭环("要求证据而非断言"的形式化);与 [[conformance-testing]](自动化对错)分工:契约管"提交前的人证",一致性测试管"机器证"
- AI 侧评审见 [[llm-as-a-judge]];验证瓶颈的背景见 [[factory-model]]
- 倡导者: [[addy-osmani]];引 [[simon-willison]]("交付你证明过能工作的代码")
