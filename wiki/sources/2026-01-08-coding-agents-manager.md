---
type: source
tags: [ai-agents, management, orchestration, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Your AI coding agents need a manager (2026-01-08)

- 原文: `raw/Your AI coding agents need a manager.md`
- 类型: 技术博客([[addy-osmani]],发布于 **2026-01-08**,frontmatter 已标注)
- 备注: 本 wiki 第二十七篇源文档;管理技能迁移论——"AI 编码规模化之后不再是 prompt 问题,是管理问题";工厂六步流水线(Plan/Spawn/Monitor/Verify/Integrate/Retro)在此以"编排操作系统"形态首次出现(2026-03 演讲的六步即其推广版);引 Boris Cherny 与 [[simon-willison]] 两条外部视角

## 摘要

让一个人成为优秀 tech lead/工程经理的技能直接迁移到 AI 编码——一旦并行跑多个代理,你不再调试上下文,而是在管理一个团队(清晰度、委派、验证循环、异步沟通)。最高杠杆开发者 = **async-first manager**,运营一小支并行 AI 编码代理舰队;瓶颈不再是"代理能不能写代码",而是"**我们该不该建这个?**"与"我能不能有效管理多个代理做这件事"。心态转变:**你不再与单个代理配对,你在运营一个小团队**——"像管理一样对待编排,而不是像魔法"。

## 关键主张

**外部视角**:Boris Cherny(Claude Code 创造者,注:[[2026-06-07-loop-engineering|Loop Engineering]] 中称其为 Claude Code 负责人,头衔表述不一)的爆款推文——本地终端标签页 5 个会话 + 浏览器 5-10 个 + 手机起会话稍后查看;[[simon-willison]] 的怀疑视角(2025-10-05 parallel-coding-agents 文,外部引用):**自然瓶颈不是生成代码,是评审它**;并行任务有价值,前提是对自己的注意力带宽诚实、选不超载大脑的任务

**双模式心智模型**(并行运行):①本地高触达会话(human-in-the-loop)——架构决策/棘手重构/产品细微差别/模糊需求/品味与判断主导的事 ②云端/后台异步会话——聚焦有界任务(直白功能/模式清晰的迁移/测试生成/文档更新/依赖升级/小 bug 修复/定向重构);触发后切走,回来评审;工具侧:GitHub 预览了 **"Agent HQ"**——多第三方代理的控制平面,可在同一任务上并行跑多个代理比较输出("任务控制"仪表盘趋势)

**四项迁移技能**:

1. **清晰任务范围:写 brief,不是 vibe**——代理 brief 七字段:**outcome**(完成时应为真的事)/**context**(代码库位置与既有模式)/**constraints**(性能/安全/API 形态/依赖规则/风格)/**non-goals**(明确不做什么)/**acceptance criteria**(具体检查)/**integration notes**(禁碰文件与接缝)/**verification plan**(怎么知道它工作);Anthropic 最佳实践:"前期具体性实质性地提升成功率、减少返工"(经理语言);两个战术:指向既有模式(明确让代理跟随/更新的文件,锚定真实约定而非发明自己的);持久规则放 AGENTS.md(Codex 文档;入职类比——"先给地图、约定与 done 定义再开始写")
2. **委派:什么全交、什么留判断**——过度委派陷阱:把产品意图/API 设计权衡/架构边界/长期维护决策交给代理;OpenAI "AI-native engineering team" 指南的 **delegate / review / own 三分法**:即使最乐观视角,工程师也保留最终决策与签字的 ownership(尤其模糊问题);三档:**全委派**(规格清晰的机械实现/样板重构/强评审下的测试生成/文档/低风险维护)、**委派+检查点**(共享接口/易冲突/棘手产品边界情况/数据迁移)、**不委派或只探索**(系统架构与新抽象/需品味的跨切重构/产品决策与"该不该建"/安全与隐私关键设计)——与管人同一个肌肉:谁拥有什么、多大自主权安全、哪里要检查点
3. **验证循环**——尽早反馈循环与质量门(代理能以高速生成低质工作);Anthropic 明确建议**双代理模式**(一个写、另一个用评审+测试验证,关注点分离);Codex:跑命令、跑测试、迭代到通过状态再提 PR;实践:要求代理跑测试套件(或作用域子集)并把输出放进最终消息;要求 lint+typecheck 通过;行为变更要求加/改测试;结尾要结构化 **"PR packet"**(变更摘要/为何此法/触碰文件/测试计划+结果/风险与后续);进阶:Agent A 实现 → Agent B 评审(正确性/风格/边界情况/漏测)→ A 或新 C 应用反馈并重跑验证——\"Anthropic 字面推荐的工作流升级\"
4. **异步查岗:把代理当下属**——查岗节奏(\"15 分钟没有显著进展就停下报告阻塞\");固定状态格式:**What changed? What's next? What are the risks or blockers? What do you need from me?**;管理并行代理 = 管理跨时区分布式团队:前载清晰度、依赖书面更新、把实时注意力留给决策与解锁

**硬问题(都是管理问题)**:

- **合并冲突乘法式增长**:并行代理碰相邻代码 = 五个工程师没协调就进同一文件;**不是工具失败,是边界失败**;修法同人类团队:有意的任务边界、隔离工作、定义接口;git worktrees(Claude Code 文档推荐 + \"每 worktree 一个终端标签页\"操作模式);**边界规则**:一代理一 PR、禁止多代理 mega-PR;两个代理可能碰同一文件就重设计任务切分;共享接口放第一个 PR(人主导),代理在接缝之上建造
- **品味与\"该不该建\"成为真瓶颈**:建造变便宜 → 什么都建 → 产品变杂物抽屉;\"AI 不消除对判断的需求,它抬高判断的价值\";\"Should we?\" 开始比 \"Can we?\" 重要;经理技能伪装:优先级、说不、定义成功、小实验、快速杀掉坏想法;操作化:**WIP 上限**(限制同时活跃的代理流,别淹没在评审里——Willison 指出的同一瓶颈)+ **kill criteria**(动工前定义什么情况会让你停止)

**作者的实践**:4-5 个后台代理处理低-中复杂度工作,同时本地 3-5 个 human-in-the-loop 会话做架构与产品细微工作;移动端委派把创意循环从\"为以后记 issue\"变成\"现在就开工\"——\"idea → 实现草稿 → 评审 → 迭代\";但只有质量杆与流程在场时它才持续令人满足;诚实对待多任务/上下文切换带宽——Cherny 的 10-15 会话是展示可能性的极端,不是要求

**编排的简单操作系统(六步)**:Plan like a manager(brief:outcome/constraints/acceptance criteria)→ Spawn like an orchestrator(并行代理+显式边界)→ Monitor async(轻量查岗、快速解锁、避免中途折腾)→ Verify aggressively(测试/lint/结构化 PR packet/第二代理评审)→ Integrate carefully(刻意合并顺序、盯边界违规)→ Retro(更新 AGENTS.md 与清单,下次运行更聪明);甜点区:一把后台代理 + 架构/产品细微留 human-in-the-loop

## 与现有 wiki 的关系

- 新建概念: [[agent-management]](管理技能迁移的操作手册)
- 更新了 [[pr-contract]](PR packet = 四字段契约的操作化)、[[conductor-orchestrator]](实用对应)、[[simon-willison]](parallel 视角)、[[factory-model]](六步流水线谱系)、[[ai-feature-implementation-loop]]
- 关键互证:双模式 ↔ [[conductor-orchestrator]](光谱的实践切分);delegate/review/own ↔ [[pr-contract]] 的\"人类签字\"立场与 OpenAI \"智能体对智能体\"立场的折中表述(工程师保留最终决策与签字);PR packet ↔ [[pr-contract]] 四字段(意图/证据/风险/评审重点);六步操作系统 ↔ [[factory-model]] 流水线(1 月原始版 → 3 月演讲版);验证循环 ↔ [[agent-verification]]/回压;边界规则(一代理一 PR)↔ [[parallel-agents]] 的\"一文件一主人\";WIP/kill criteria ↔ [[ralph-loop]] 的 3+ 卡死杀与 [[agent-teams]] 的预算;Agent HQ ↔ 2026 工具谱系的控制平面趋势([[2026-03-26-code-agent-orchestra]])

## 待办 / 后续

- Agent HQ 正式发布与能力;Cherny 头衔核实(创造者 vs 负责人);Willison parallel-coding-agents 原文(2025-10-05,外部引用);OpenAI \"AI-native engineering team\" 指南原文
- delegate/review/own 在实践中的分布数据;PR packet 的采用率
