---
type: source
tags: [ai-agents, loop-engineering, automation, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Loop Engineering (2026-06-07)

- 原文: `raw/Loop Engineering.md`
- 类型: 技术博客([[addy-osmani]],发布于 **2026-06-07**,frontmatter 已标注;原文含 X 推文引用,均已标注二手)
- 备注: 本 wiki 第二十三篇源文档;把"harness 工程 → 工厂模型"推进到**第三层:循环工程**(harness 加个定时器、会孵化小助手、会自我喂食);引 Peter Steinberger("别提示代理了,设计循环来提示你的代理")与 Boris Cherny(Claude Code 负责人:"我的工作就是写循环")两条推文(二手,待核)

## 摘要

循环工程 = **取代"你来提示代理"的那个人**:你设计替你做提示的系统。循环 = 递归目标(定义 purpose,AI 迭代到完成)。作者认为这是编码代理工作方式的未来,但**仍在早期、保持怀疑、必须警惕 token 成本**(token 富/贫用户的使用模式差异极大)。两年来的"人握代理、一轮轮喂提示"模式"某种程度上结束了":现在你建一个小系统——找活、派活、检查、记下已完成、决定下一步——让系统戳代理而不是你戳。**循环工程站在 harness 上一楼层**:harness 是单代理运行的环境、工厂模型是建软件的系统,循环是"跑在定时器上的 harness,孵化小助手,自我喂食"。出人意料的是这不再是工具问题——一年前要写一堆 bash 自己维护,现在**五件套已随产品内置**,Codex app 与 Claude Code 的形状几乎一一对应;看清形状相同后,争论工具没意义,设计一个无论坐在哪个工具里都能跑的循环。

## 关键主张

**五件套 + 记忆(第六件)**(引 reach_vb 推文,二手)

| 原语 | 在循环中的职责 | Codex app | Claude Code |
|---|---|---|---|
| Automations | 定时自动发现 + triage | Automations tab(项目/prompt/节奏/环境;结果进 Triage inbox;空跑自动归档) | 定时任务/cron、`/loop`、`/goal`、hooks、GitHub Actions |
| Worktrees | 并行隔离 | 每线程内置 worktree | `git worktree`、`--worktree`、子代理 `isolation: worktree` |
| Skills | 固化项目知识 | Agent Skills(SKILL.md),`$name` 或隐式触发 | Agent Skills(SKILL.md) |
| Plugins/connectors | 接入已有工具 | Connectors(MCP)+ plugins | MCP servers + plugins |
| Sub-agents | 一个出主意、另一个检查 | `.codex/agents/` TOML(name/description/instructions/model/reasoning effort) | `.claude/agents/` + agent teams |
| **State(记忆)** | 追踪进度 | Markdown 或经 connector 的 Linear | Markdown(AGENTS.md、progress 文件)或经 MCP 的 Linear |

**Automations = 心跳**:Codex 的 Automations tab(选项目/prompt/频率/本地还是后台 worktree 跑;有发现的进 Triage inbox,没发现的自己归档);OpenAI 内部用途:每日 issue triage、汇总 CI 失败、写 commit 简报、抓上周混进来的 bug;automation 可调 skill(用 `$skill-name` 而不是把一大墙指令贴进没人会更新的调度);Claude Code 走调度 + hooks(`/loop` 按间隔跑 prompt/命令、cron、hooks 在生命周期点触发 shell 命令、GitHub Actions 关盖电脑后继续跑)

**会话内原语**:`/loop` 按节奏重跑;`/goal` 一直跑到你写的条件为真——**每轮后由单独的模型检查是否完成**(写码的代理不给自己的作业打分),如"test/auth 下所有测试通过且 lint 干净"然后走开;Codex 也有 `/goal`(跨轮直到可验证停止条件,pause/resume/clear)

**Worktrees**:两个代理写同一文件 = 两个工程师没打招呼改同一行;git worktree = 独立工作目录、独立分支、共享历史,"一个代理的编辑物理上碰不到另一个的 checkout";Codex 内建;Claude Code 用 `git worktree`/`--worktree`/子代理 `isolation: worktree`(用完自清理);但**人仍是天花板**:orchestration tax 里 worktree 只消除机械碰撞,你的评审带宽决定能跑多少代理

**Skills**:停止每次会话像金鱼一样重新解释项目;"tight boring description beats a clever one"(触发靠描述匹配——与 56% 触发率问题直接相关);**skill 是意图的书面外化**(与意图债互证):"没有 skills,循环每轮从零重新推导整个项目;有了 skills,它开始复利";**skill 是创作格式,plugin 是分发方式**

**Plugins/connectors**:connector 基于 MCP(issue 跟踪/数据库/staging API/Slack);两边都讲 MCP,为一个工具写的 connector 通常另一个也能用;区别是"代理说'这是修复'"vs"循环自己开 PR、链 Linear ticket、CI 绿了自动 ping 频道"

**Sub-agents = 最有用的结构性部件**:写的人与检查的人分开——"写码的模型给自己的作业打分时太nice了";Codex 的 TOML 子代理可指定 model + reasoning effort(安全审查员 = 强模型高 effort;探索者 = 快速只读);常见三分:一个探索、一个实现、一个对照 spec 验证;**在循环里尤其重要**:循环在你没看着的时候跑,可信的验证器是你能走开的唯一理由;`/goal` 内部就是这么干的——新模型决定循环是否结束(maker/checker 分裂应用到停止条件本身);子代理烧更多 token,"花在值得为第二意见付钱的地方"

**一个循环的形状**(作者常用):每天早上 automation 跑 → prompt 调 triage skill(读昨天 CI 失败/开放 issue/最近 commit,写进 markdown/Linear)→ 每个值得做的发现开隔离 worktree,发子代理起草修复,第二个子代理对照项目 skills 与既有测试审查 → connector 开 PR 更新 ticket → 处理不了的落进 triage inbox → 状态文件是脊柱(试过什么/过了什么/还开着什么),明天早上接着今天停下的地方跑;"你只设计了一次,没提示任何一步"

**循环不替你做的三件事(随循环变好而更尖锐)**:

1. **验证仍在你肩上**:无人值守的循环 = 无人值守地犯错;即使有验证子代理,"done"是主张不是证明;"你的工作是交付你确认能工作的代码"
2. **理解仍会腐烂**:循环越快交付你没写的代码,存在与理解之间的沟越大(comprehension debt);流畅的循环只是让它长得更快,除非你读循环产出的东西
3. **舒适的姿势最危险**:循环自己跑时很容易停止持有观点(认知投降);"设计循环带着判断力是解药,用它逃避思考是加速剂——同一个动作,相反的结果"

**收尾**:预览了工作演化方向;但"如果我不自己审代码、完全依赖自动循环修,我的产品质量会受损,大概率陷入不断挖坑的下旋";直接提示仍然有效,要找到平衡;**两个人建同一个循环可能得到完全相反的结果**——一个用它加速自己深懂的工作,另一个用它逃避理解;"循环不知道区别,你知道";循环设计比 prompt 工程更难——Cherny 的意思不是工作变容易了,**是杠杆点移动了**;结语:"建循环。但要以'打算继续当工程师,而不只是按开始键的人'的方式建。"

## 引用的外部文章(Osmani 关联文,未入库的注明)

- 已入库:agent-harness-engineering([[2026-04-19-agent-harness-engineering]])、factory-model([[2026-02-25-factory-model-coding-agents]])、long-running-agents([[2026-08-02-effective-harnesses-for-long-running-agents]] 为 Anthropic 版;Osmani 同名文未入库)、intent-debt([[2026-06-05-intent-debt]])、code-review-ai([[2026-01-07-ai-code-review]])、comprehension-debt([[2026-03-14-comprehension-debt]])、cognitive-surrender([[2026-05-05-cognitive-surrender]])
- 未入库(可作后续 raw 源):orchestration-tax、agent-skills(Osmani 版)、code-agent-orchestra、adversarial-code-review

## 与现有 wiki 的关系

- 新建概念: [[loop-engineering]](harness 之上第三层)
- 更新了 [[harness-engineering]](层级定位)、[[agent-verification]](/goal 停止条件 = maker/checker 应用到停止条件;done 是主张不是证明)、[[long-running-agents]](/loop//goal 原语 + 状态文件脊柱)、[[subagents]](Codex TOML 配置 + 循环内验证者)、[[skills]](创作格式 vs 分发 + 触发描述)、[[cognitive-surrender]](循环 = 投降加速剂)、[[comprehension-debt]](循环加速债务)、[[ai-feature-implementation-loop]](循环工程层)
- 关键互证:"循环 = 跑在定时器上的 harness" ↔ [[harness-engineering]];"state 文件是脊柱" ↔ [[long-running-agents]] 的 claude-progress.txt 与 [[file-as-memory]];"skill 是意图外化" ↔ [[intent-debt]];"验证仍在你肩上" 与 "done 是主张不是证明" 站队人类签字阵营([[pr-contract]],与 OpenAI 合并哲学反转的既有分歧,无新矛盾,只是循环语境下的重述);"两个人建同一循环结果相反" ↔ [[cognitive-surrender]] 的个人姿态;"子代理烧 token 花在值得第二意见的地方" ↔ 20 倍成本实证
- 引用的第三方案例:Steinberger/Cherny 推文(二手)、OpenAI 内部 automations 用途(二手)、Wes Winder token 成本警告(二手)

## 待办 / 后续

- 核实 Steinberger/Cherny 推文与 Codex app 功能映射;OpenAI 内部 automations 用例
- 循环的 token 成本模型(token 富/贫差异);无监督循环的失败模式数据;状态文件腐烂的长期实证;triage 误过滤(值得做的发现被归档)的案例
