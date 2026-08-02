---
type: concept
tags: [ai-agents, loop, automation, architecture, harness]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [harness-engineering, factory-model, long-running-agents, agent-verification, subagents, skills, agents-md, intent-debt, cognitive-surrender, comprehension-debt, addy-osmani]
sources: [2026-06-07-loop-engineering]
status: active
---

# Loop engineering

循环工程:取代"人来提示代理"——设计一个替你做提示的系统;循环 = 递归目标(定义 purpose,AI 迭代到完成);站在 [[harness-engineering|harness]] 上一楼层——"跑在定时器上的 harness,孵化小助手,自我喂食"。

## 关键信息

**层级定位**(来源: [[2026-06-07-loop-engineering]],Osmani):harness = 单代理运行的环境;工厂模型 = 建软件的系统;循环 = 自动化的那一层(找活、派活、检查、记录、决定下一步)。引 Peter Steinberger("别提示代理了,设计循环来提示你的代理")与 Boris Cherny(Claude Code 负责人,"我的工作就是写循环")——二手,待核;作者自评:仍早期、需怀疑、**警惕 token 成本**(token 富/贫用户模式差异极大)

**五件套 + 记忆**:

1. **Automations(心跳)**:定时自动发现 + triage;有发现的进 Triage inbox,没发现的自动归档;可调 skill(`$skill-name` 而非往调度里贴没人更新的指令墙);载体:Codex Automations tab / Claude Code 定时任务+cron+hooks+GitHub Actions
2. **Worktrees**:并行隔离——"一个代理的编辑物理上碰不到另一个的 checkout";但**人仍是天花板**(评审带宽决定能跑多少代理,见 [[parallel-agents]])
3. **Skills**:固化项目知识,"像金鱼一样重新解释"的终结;**触发描述要平实具体**(tight boring description beats a clever one);= 意图的书面外化(见 [[intent-debt]]):没有 skills 循环每轮从零推导项目,有了则复利
4. **Plugins/connectors**:经 MCP 接 issue 跟踪/数据库/staging API/Slack;区别是"代理说'这是修复'"vs"循环自己开 PR、链 ticket、CI 绿了 ping 频道"
5. **Sub-agents**:写的人与检查的人分开——"写码的模型给自己的作业打分太 nice 了";常见三分:探索/实现/验证(见 [[subagents]])
6. **State(记忆,第六件)**:markdown 或 Linear,活在会话之外,记录 done 与 next;**"代理会忘,仓库不会"**——状态文件是循环的脊柱,明早接着今晚停下的地方跑(见 [[long-running-agents]]、[[file-as-memory]])

**/goal 原语**:跑到你写的条件为真——**每轮后由单独的模型检查是否完成**(maker/checker 分裂应用到停止条件本身);例:"test/auth 下所有测试通过且 lint 干净"然后走开;Codex 与 Claude Code 都有(/loop = 按节奏重跑,/goal = 跑到条件成立)

**循环的形状**(一个实例):早上 automation → triage skill(读昨天 CI 失败/issue/commit → 写 findings)→ 每个值得做的开 worktree 派子代理起草 + 第二个子代理对照 skills/测试审查 → connector 开 PR 更新 ticket → 处理不了的进 triage inbox → 状态文件续接;"你只设计了一次,没提示任何一步"

**循环不替你做的三件事(随循环变好而更尖锐)**:

1. **验证仍在你肩上**:无人值守的循环 = 无人值守地犯错;"done 是主张,不是证明"
2. **理解仍会腐烂**:循环越快交付你没写的代码,理解沟越大(见 [[comprehension-debt]]);流畅的循环只是让它长得更快,除非你读产出
3. **舒适姿势最危险**:循环自己跑时容易停止持有观点(见 [[cognitive-surrender]]);"设计循环带着判断力是解药,用它逃避思考是加速剂——同一个动作,相反的结果"

**关键性质**:不是工具问题(五件套已随产品内置,Codex 与 Claude Code 形状一致——争论工具无意义);**同构循环异果**——两个人建同一个循环得到相反结果(一个加速深懂的工作,一个逃避理解),"循环不知道区别,你知道";循环设计比 prompt 工程更难——"Cherny 的意思不是工作变容易了,是**杠杆点移动了**";"以打算继续当工程师的方式建循环,而不是只按开始键"

## 与其他页面的关系

- 层级:harness([[harness-engineering]])→ 工厂([[factory-model]])→ **循环(本页)**
- 原语落地: [[long-running-agents]](跨会话 harness 与状态文件)、[[agent-verification]](停止条件验证/回压)、[[subagents]](maker/checker 分裂)、[[skills]](知识外化)、[[agents-md]](状态文件的 AGENTS.md 形态)
- 人侧: [[cognitive-surrender]](循环是投降加速剂也是解药)、[[comprehension-debt]]、[[intent-debt]](skill 是意图外化的机制)
- 倡导者: [[addy-osmani]];来源: [[2026-06-07-loop-engineering]]
