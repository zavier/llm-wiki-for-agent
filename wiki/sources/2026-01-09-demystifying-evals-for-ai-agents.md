---
type: source
tags: [ai-agents, evals, agentic-systems, evaluation]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# Demystifying evals for AI agents (2026-01-09)

- 原文: `raw/Demystifying evals for AI agents.md`
- 类型: Anthropic 工程博客(作者 Mikaela Grace、Jeremy Hadfield、Rodrigo Olivares、Jiri De Jonghe;anthropic.com/engineering/demystifying-evals-for-ai-agents)
- 备注: 原文含 5 张示意图(简单/多轮 eval、agent eval 组件、pass@k 与 pass^k 分叉、有效 eval 创建流程、Swiss Cheese Model);正文文本已覆盖其内容

## 摘要

系统梳理 AI agent 评测:为什么需要 eval、agent eval 的组件(任务/试跑/评分器/轨迹/终态/评测 harness)、三类 grader(code/model/human)与 capability vs regression 之分;为 coding、conversational、research、computer-use 四类 agent 给出可复用评测手法;以"零到一"路线图(采集任务→设计 harness 与 grader→长期维护)和 pass@k vs pass^k、eval 饱和等度量概念收束。核心立场:评测价值会复利,但要把 eval 当核心组件而非事后附加。

## 关键主张

- **eval 定义**:给 AI 一个输入、对其输出施加评分逻辑来衡量成功;本文聚焦开发期无需真实用户即可运行的 **automated evals**;从 single-turn、non-agentic 演进到 multi-turn,再到 **agent evaluations**(多轮工具调用、改环境状态、错误传播复合)
- **静态 eval 会被聪明模型绕过**:Opus 4.5 在 𝜏2-bench 的机票预订题里发现政策漏洞,按题面判"失败",实为对用户更优的解——说明 frontier models 会找到超出静态 eval 限制的解法
- **术语栈**:task(=problem/test case,单次测试)、trial(每次尝试;输出有随机性需多次)、grader(评分逻辑,含多个 assertion/check)、transcript(=trace/trajectory,含 outputs/tool calls/reasoning 的完整记录,Anthropic API 中即 messages array)、outcome(环境最终状态——机票代理说"已订票",outcome 是 SQL 库里是否真有 reservation)、evaluation harness(端到端跑 eval 的基础设施)、agent harness=scaffold(让模型作为代理行动的系统;**评测"一个 agent"时评的是 harness 与 model 一起工作**)、eval suite(任务集合)
- **三类 grader**:code-based(快/便宜/客观/可复现/易调试,但 brittle、缺 nuance)、model-based(flexible/scalable/抓 nuance,但 non-deterministic、更贵、需与人类 grader 校准)、human(gold standard,但贵/慢/需专家);按题可 weighted / binary / hybrid
- **capability vs regression**:capability/quality evals 问"这个 agent 能做好什么",应**低通过率**、给团队一座要爬的山;regression evals 问"它是否还能处理以前的全部任务",应接近 **100% 通过率**;高通过率的 capability eval 可"毕业"为持续回归套件
- **起点比想象低**:团队常因以为要几百题而拖延;实际 **20-50 道来自真实失败的简单任务**就是很好的起点;mature agent 才需要更大更难的 eval 来测小效应;越晚建越难——早期产品需求自然翻译成测试用例
- **task 设计**:好 task 是两位领域专家独立得出**相同** pass/fail 判定;含歧义的 spec 会变成 metric 里的 noise;frontier models 上跨多次 trial 的 **0% pass@100** 多半是 task 坏了而非 agent 无能;同时要测"该发生"与"不该发生"两个方向(balanced,避免 class-imbalanced)——只测"该搜就搜"会得到几乎逢事就搜的 agent,Claude.ai 网络搜索 eval 因此同时覆盖该搜(天气)与不该搜(谁创立了 Apple)
- **环境隔离**:每次 trial 从 clean environment 开始;shared state(leftover 文件、缓存、资源耗尽)会造成相关失败或人为抬高分数;内部 eval 中曾观察到 Claude 通过查看前几次 trial 的 git history 获得不公平优势
- **grade 产出而非路径**:只按特定顺序检查 tool call 序列太僵硬、brittle;agent 常找到设计者没预料到的合法路径,应评它**产出了什么**;多组件任务要给 partial credit(识别问题+验证客户但没退款,明显好过一上来就失败)
- **LLM-as-judge 校准**:与人类专家紧密校准、给 LLM 一条 "Unknown" 的出路以防幻觉、按维度拆成多个独立 judge 而非一个 judge 评所有维度;系统稳健后人类评审可只偶尔做
- **评分 bug 会伪装成能力不足**:Opus 4.5 在 CORE-Bench 初始 **42%**,因 rigid grading(期望 "96.124991…" 却把 "96.12" 判错)、歧义 spec、无法精确复现的 stochastic 任务;修 bug 并换更宽松 scaffold 后分数跳到 **95%**;METR 也发现 time horizon benchmark 有 misconfigured tasks(要求"达到"阈值而评分要求"超过")
- **pass@k vs pass^k**:pass@k 量"k 次尝试里至少 1 次成功",随 k 上升;pass^k 量"全部 k 次都成功",随 k 下降;每 trial 75% 成功率、跑 3 次,全过概率为 (0.75)³ ≈ **42%**;工具类用 pass@k,一致性关键的面向用户 agent 用 pass^k
- **benchmark 与饱和**:SWE-bench Verified 给 agent 流行 Python 仓库的 GitHub issue、以 test suite 判分,LLM **一年内从 40% 到 >80%**;Terminal-Bench 测端到端技术任务(从源码编 Linux 内核、训练 ML 模型);eval **饱和**指 agent 通过全部可解任务、只剩回归信号——SWE-Bench Verified 今年从 **30%** 起步、frontier models 现已接近 **>80%** 饱和,进步放缓会让大幅能力提升只体现为小分数增长(Qodo 曾因 one-shot coding eval 看不出 Opus 4.5 的长任务收益而另建 agentic eval framework)
- **eval-driven development 与归属**:把 eval 当 unit test 一样例行维护;最有效的是专门 evals 团队拥有核心基础设施、领域专家与产品团队贡献并运行任务;离产品需求最近的人(PM/CS/sales)可用 Claude Code **以 PR 形式**提交 eval task;六个理解 agent 性能的方法(automated evals/生产监控/A-B/用户反馈/人工读 transcript/系统化人类研究)如 Swiss Cheese Model 分层互补,automated evals 尤其适合 pre-launch 与 CI/CD

## 与现有 wiki 的关系

- 新建 [[agent-evals]](本页是其领域定义级来源:术语栈、三类 grader、capability vs regression、pass@k/pass^k、饱和)
- 深化 [[llm-as-a-judge]](与人类专家校准、"Unknown" 出路、按维度隔离 judge)
- 更新 [[swe-bench]](SWE-bench Verified 40%→>80%、饱和信号)、[[tool-evaluation]](评测驱动循环的通用化)
- 区分 [[harness-engineering]] 里易混的两个 harness:evaluation harness(跑 eval 的基础设施)vs agent harness/scaffold(让模型作为代理行动的系统)
- 与 [[long-running-agents]] 呼应:Claude Code 作为灵活 agent harness,官方用 Agent SDK 搭 long-running agent harness
- 与 [[agent-verification]] 互补:verification 是给代理可运行的检查,evals 是给团队可运行的检查
- [[multi-agent-systems]]、[[claude-code]]、[[anthropic]]:Claude Code 的 eval 演进、多代理 eval 挑战、官方评测方法论
- [[pr-contract]]:把 eval task 当 PR 贡献,是评审契约的评测形态

## 待办 / 后续

- 原文自认:AI agent evaluation 仍是 nascent、fast-evolving field;随 agent 任务更长、进入多代理系统、处理更主观工作,技术需继续适配
- CORE-Bench 42%→95% 的评分 bug 细节值得单列成案例
- 附录列出 Harbor / Braintrust / LangSmith / Langfuse / Arize-Phoenix 等框架,可对照 [[tool-evaluation]] 落成选型页
