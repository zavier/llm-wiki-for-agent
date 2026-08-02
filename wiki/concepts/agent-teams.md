---
type: concept
tags: [ai-agents, multi-agent, coordination, agent-teams, architecture]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [multi-agent-systems, subagents, parallel-agents, agent-verification, self-reflection, claude-code, addy-osmani]
sources: [2026-03-26-code-agent-orchestra, 2026-01-31-self-improving-agents]
status: active
---

# Agent Teams

代理团队:给多代理补上协调原语的模式——共享任务列表(带依赖跟踪与文件锁)+ 对等消息直连;子代理只解决"并行执行 + 手动协调",协调成为瓶颈时升级到 Agent Teams;Claude Code 实验特性(`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`),机制可泛化到任何编排器。

## 关键信息

**三层架构**(来源: [[2026-03-26-code-agent-orchestra]],Osmani)

1. **Team Lead**(顶层):分解工作、创建任务列表、综合结果
2. **共享任务列表**(中层):任务状态 pending/in_progress/completed/blocked、**依赖跟踪**、**文件锁**——完成时自动解锁阻塞任务(如 Test 任务等 Backend 完成才解锁);Ctrl+T 可视化覆盖层
3. **Teammates**(底层):独立 Claude Code 实例(tmux split panes),**自认领任务**、**对等消息直连不经 lead**(Backend 直接把 API 契约发给 Frontend;队友闲置自动通知 lead)——防止 lead 成为协调瓶颈

**关键特性与数字**

- **3-5 队友是甜点区**;token 成本随规模线性;"三个专注队友胜过五个散漫的"
- **计划审批**:写码前先写计划,lead 审批准/拒绝——"修坏计划比修坏代码便宜得多",架构问题在代码存在前被抓
- **循环护栏 + 强制反思**:硬 `MAX_ITERATIONS=8`;每次重试前强制反思("什么失败了?什么具体改动能修?我在重复同一方法吗?")——大幅减少卡死代理(无护栏则无限循环同一错误方法)(见 [[self-reflection]])
- **专职 @reviewer 队友**:Claude Opus 4.6(只读)+ 仅 lint/test/security-scan 工具 + 每次 TaskCompleted 自动触发 + 1:3-4 构建者比例——lead 只见绿评过的代码("内置的永久 CI 质量门")(见 [[agent-verification]])
- hooks 强化:TeammateIdle 验证测试全过才让停;TaskCompleted 跑 lint+测试,不过就继续干

**层级子代理(teams of teams)**:父只派生 feature lead,各自再派生 2-3 个专家——分解深度 3× 而不炸父上下文(模拟真实组织:VP → tech leads → 工程师);父代理上下文保持干净,只见两个直接下属

**定位**:子代理 = 并行执行 + 手动依赖图(简单分解够用,成本中性 ~220k tokens);Agent Teams = 真并行 + 自动协调;再往上 = Tier 2 本地编排器(3-10 代理,仪表盘/diff 审查:Conductor、Vibe Kanban 等)与 Tier 3 云端异步(派活走人收 PR:Claude Code Web、Copilot Coding Agent、Jules、Codex Web)(见 [[multi-agent-systems]])

**规模化实验数据点**(来源: [[2026-01-31-self-improving-agents]],转述 Cursor scaling-agents 实验,Wilson Lin,外部引用待核):数百代理一周内写出百万行代码/1000+ 文件(建浏览器);**失败模式:共享文件锁 → 代理卡死/互相等待;换掉锁后暴露更深问题——代理变风险厌恶**(各自只做微小安全改动、避开大而复杂的任务——自由混战中没人觉得"负责"难的部分);**Planner-Worker-Judge 模型更成功**(Planner 项目经理式拆任务递归、Worker 实现不管大局、Judge 评估目标是否达成)——消除无目的游荡、吞吐量级提升;与 maker/checker 分裂、[[multi-agent-systems]] 层级委派同族;教训:自由混战(无层级无责任制)是多代理的深层失败模式,锁只是表面问题

## 与其他页面的关系

- 谱系: [[subagents]](手动协调)→ 本页(自动协调)→ [[multi-agent-systems]](编排全景)
- 质量: [[agent-verification]](reviewer 队友 = 回压的团队形态)、[[self-reflection]](强制反思护栏)
- 工具: [[claude-code]](实验特性);倡导者: [[addy-osmani]];来源: [[2026-03-26-code-agent-orchestra]]
