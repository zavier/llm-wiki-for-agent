---
type: concept
tags: [ai-agents, management, delegation, orchestration, workflow]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [conductor-orchestrator, pr-contract, factory-model, parallel-agents, agent-verification, simon-willison, addy-osmani, agents-md]
sources: [2026-01-08-coding-agents-manager]
status: active
---

# Agent management

代理管理:把管理技能(清晰度、委派、验证循环、异步沟通)直接迁移到 AI 编码——"一旦并行跑多个代理,你不再调试上下文,而是在管理一个团队";AI 编码规模化之后不再是 prompt 问题,是管理问题;**"像管理一样对待编排,而不是像魔法"**。

## 关键信息

**双模式**(来源: [[2026-01-08-coding-agents-manager]],Osmani):①本地高触达 human-in-the-loop 会话——架构/棘手重构/产品细微/模糊需求/品味判断主导;②云端/后台异步会话——聚焦有界任务(直白功能/模式清晰迁移/测试生成/文档/依赖升级/小 bug);触发后切走,回来评审;工具侧:**Agent HQ**(GitHub 预览的控制平面,同一任务并行多代理比较输出)

**四项技能**:

1. **写 brief,不是 vibe**(七字段):outcome / context(位置+既有模式)/ constraints(性能/安全/API 形态/依赖/风格)/ non-goals / acceptance criteria / integration notes(禁碰文件+接缝)/ verification plan;战术:指向既有模式(锚定真实约定)、持久规则进 AGENTS.md(入职类比:"先给地图、约定与 done 定义再开始写")
2. **委派三档(delegate / review / own,OpenAI 三分法)**:全委派(规格清晰的机械实现/样板/测试生成/低风险维护);委派+检查点(共享接口/易冲突/棘手边界情况/数据迁移);不委派或只探索(系统架构/需品味的跨切重构/产品决策"该不该建"/安全隐私关键设计)——工程师保留最终决策与签字
3. **SDLC 全流程官方版三分法**(来源: [[2026-08-02-building-ai-native-engineering-team]],OpenAI 官方指南):六阶段每阶段 Delegate/Review/Own——Plan(agent 首轮可行性/架构分析,人验准确性+估风险,**Own 优先级/方向/权衡**)/ Design(agent 脚手架/转码,人评约定与无障碍,**Own 设计系统与 UX 方向**)/ Build(agent 一审实现,人评设计选择/性能/安全/迁移,**Own 新抽象/跨切架构/模糊需求**)/ Test(agent 首轮测试生成独立会话,人防 stub 测试,**Own 覆盖对齐与对抗思维**)/ Review(agent 首轮评审,人**Own 最终评审与合并**)/ Document(agent 草稿,人评关键文档,**Own 策略/标准/对外**)/ Deploy&maintain(agent 日志解析/triage/hotfix 提议,人验诊断,**Own 新发事故/敏感变更/低置信**);Own 侧 = 所有权/方向/战略判断,Review 侧 = 验证与校正,Delegate 侧 = 机械多步——"agent = 一审实现者,工程师 = 评审者/编辑者/方向来源":全委派(规格清晰的机械实现/样板/测试生成/低风险维护);委派+检查点(共享接口/易冲突/棘手边界情况/数据迁移);不委派或只探索(系统架构/需品味的跨切重构/产品决策"该不该建"/安全隐私关键设计)——工程师保留最终决策与签字
3. **验证循环**:要求跑测试套件(或子集)并把输出放进最终消息;lint+typecheck;行为变更必改测试;结构化 **PR packet**(变更摘要/为何此法/触碰文件/测试计划+结果/风险与后续);双代理模式(一个写、另一个评,见 [[agent-verification]])
4. **异步查岗**:查岗节奏("15 分钟无显著进展就停下报阻塞");固定状态格式(What changed? / What's next? / Risks or blockers? / What do you need from me?)——管理跨时区分布式团队的剧本

**边界规则**:一代理一 PR、**禁止多代理 mega-PR**;两代理可能碰同一文件就重设计任务切分;共享接口放第一个 PR(人主导),代理在接缝上建造;git worktrees 隔离(见 [[parallel-agents]]);合并冲突是**边界失败不是工具失败**

**判断瓶颈**:"AI 不消除对判断的需求,它抬高判断的价值"——Should we? 比 Can we? 重要;操作化:**WIP 上限**(别淹没在评审里——Willison 瓶颈)+ **kill criteria**(动工前定义放弃条件)

**六步操作系统**(工厂流水线的个人版,见 [[factory-model]]):Plan like a manager(brief)→ Spawn like an orchestrator(并行+显式边界)→ Monitor async(轻量查岗/快速解锁/避免中途折腾)→ Verify aggressively(测试/lint/PR packet/第二代理评审)→ Integrate carefully(刻意顺序/盯边界违规)→ Retro(更新 AGENTS.md 与清单);甜点区:一把后台代理(低-中复杂度)+ 架构/产品细微留 human-in-the-loop

## 与其他页面的关系

- 角色: [[conductor-orchestrator]](光谱)↔ 本页(操作手册);规模化: [[agent-teams]]、[[parallel-agents]]
- 契约: [[pr-contract]](PR packet 是四字段契约的操作化);流程: [[factory-model]]、[[ralph-loop]](kill criteria 同族)
- 外部锚点: [[simon-willison]](评审瓶颈论);倡导者: [[addy-osmani]]
