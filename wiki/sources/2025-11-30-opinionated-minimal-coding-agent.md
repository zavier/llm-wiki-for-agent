---
type: source
tags: [ai-agents, harness, minimalism]
topic: ai-agents
created: 2026-08-08
updated: 2026-08-08
status: active
---

# What I learned building an opinionated and minimal coding agent (2025-11-30)

- 原文: `raw/What I learned building an opinionated and minimal coding agent.md`
- 类型: 博客文章
- 作者: [[mario-zechner]](badlogic,libGDX 创始人;Sitegeist 作者)
- 原文: <https://mariozechner.at/posts/2025-11-30-pi-coding-agent/>

## 摘要

Mario Zechner 厌倦 Claude Code 的"宇宙飞船化"(80% 功能无用、每次发布改 system prompt/工具、闪屏、子代理黑箱),从零自建极简编码代理 **pi** 的完整复盘:四包架构(pi-ai 统一 LLM API / pi-agent-core 代理循环 / pi-tui 终端 UI / pi-coding-agent CLI)。核心哲学:"**如果我用不到,它就不会被构建**"——系统提示+工具 <1000 tokens、YOLO 默认、反 MCP/to-do/plan mode/后台 bash/子代理,状态全部落在文件里。Terminal-Bench 2.0 五轮跑分上榜 + Terminal-Bench 团队自己的 Terminus 2(纯 tmux)名列前茅,双重佐证"极简可行"。最尖锐的实证:模型不擅长找全上下文("被训练成只读文件片段")——pi-mono 的 PR 大量因代理没 grasp 全貌被返工,"我们太信任代理了"。

## 关键主张

1. **极简系统提示 + 四工具(read/write/edit/bash)就够**——前沿模型已 RL 训练成"天生理解编码代理",不需要 10k token 提示;与 [[curse-of-instructions]]、[[2026-02-12-evaluating-agents-md|ETH agentfile 反证]]("短而精")一致;与富 harness 学派([[harness-engineering]])张力
2. **上下文工程 = 一切,但没有任何 harness 真的让你做它**——主流工具背后注入内容且不在 UI 暴露;pi 的卖点 = 完全控制进模型的每个 token + 完全可观测(能看到代理读了哪些源、漏了哪些)(见 [[context-engineering]])
3. **反 MCP**:工具描述全量进上下文是"上下文税"(Playwright MCP 21 工具 13.7k tokens、Chrome DevTools MCP 26 工具 18k tokens = 会话开始前 7-9% 窗口);替代 = CLI 工具 + README 按需读(渐进披露的 CLI 形态),必要场景用 mcporter 把 MCP 包成 CLI(见 [[model-context-protocol]])
4. **反内建 to-do/plan mode**:列表给模型加"跟踪与更新状态"负担,出错机会更多;状态放 TODO.md/PLAN.md——跨会话、可版本化、可控;只读探索用 `--tools read,grep,find,ls`(见 [[long-running-agents]] 的 to-do 张力、[[plan-mode]] 反论)
5. **反后台 bash**(用 tmux:可观测、可人机协同调试 LLDB/日志)、**反子代理**(黑箱中的黑箱;要上下文隔离 = 独立会话先收集上下文、产出工件、干净会话复用;并行子代理实现功能 = 反模式)(见 [[subagents]]、[[parallel-agents]])
6. **YOLO 默认**:权限弹窗 = security theater;能力三元组(读数据/执行代码/联网)无解,引用 [[simon-willison]] 的 dual-LLM 模式自认"pretty bad";介意就跑容器(见 [[three-tier-boundaries]] 张力)
7. **实证:模型不擅长找全上下文**——训练使模型只读文件片段、不愿读全文 → 漏关键上下文 → pi-mono issue/PR 大量被关或返工;"我们太信任代理了"
8. **基准方法学**:五轮/任务(可提交 leaderboard);发现错误率在 PST 上线后变差 → 第二跑仅限 CET——基准结果受时区/负载影响
9. **无 compaction 单会话数百轮**——个人不需要压缩(对照 [[context-anxiety]]);未来功能:compaction(issue #92)、工具结果流式(#44)

## 与现有 wiki 的关系

- 新增实体: [[mario-zechner]]、[[pi-coding-agent]];新建综合页 [[minimal-vs-rich-harness]](极简 vs 富 harness 两派全景对比)
- 更新: [[plan-mode]](PLAN.md 文件化反论)、[[model-context-protocol]](上下文税反论)、[[subagents]](黑箱批判 + 独立会话替代)、[[long-running-agents]](to-do 张力)、[[progressive-disclosure]](CLI-README 形态)、[[agent-computer-interface]](工具结果双通道 + 流式解析)、[[context-engineering]](完全控制论)、[[harness-engineering]](极简证据 + Terminal Bench 数据点)、[[parallel-agents]](并行子代理 = 反模式)
- 矛盾处理: 与 Anthropic/Osmani 富 harness 学派的正面分歧属**学派分歧而非事实错误**,已在上述页面以 callout 标注,未改写旧页历史;现有支持面(curse-of-instructions、ETH agentfile、"从简单开始"清单、56% 未触发反证)部分站在极简派一侧
- 元观察: 本 wiki 的运行环境即 pi(当前会话的系统提示与四工具与文章逐字吻合)——本 wiki 的 AGENTS.md 契约/lint.sh/文件即状态实践,本身就是极简派的活证据

## 待办 / 后续

- Terminal-Bench 2.0 榜单核对 pi 最终名次(文章仅有 2025-12-02 快照;gist f45e8f6e481e5ab7d3a50659da84edaa)
- Terminus 2 详情(laude-institute/terminal-bench 的 `agents/terminus_2`):纯 tmux 交互、零工具,跨模型名列前茅
- Armin Ronacher《Agents are hard》(lucumr.pocoo.org/2025/11/21/agents-are-hard/)——pi 不依赖 Vercel AI SDK 的动机参照
- mcporter(Steinberger)MCP-as-CLI 包装器的落地情况
- 时区/负载对基准结果影响的后续观察
- 极简 vs 富 harness 的同模型同任务 A/B(开放问题,见 [[minimal-vs-rich-harness]])
