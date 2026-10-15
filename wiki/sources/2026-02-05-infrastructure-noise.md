---
type: source
tags: [agent-evals, benchmarking, infrastructure, swe-bench]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# Quantifying infrastructure noise in agentic coding evals (2026-02-05)

- 原文: `raw/Quantifying infrastructure noise in agentic coding evals.md`
- 类型: Anthropic 工程博客(作者 Gian Segato;anthropic.com/engineering/infrastructure-noise)

## 摘要

agentic coding benchmark 的分数常被当作能力的精确度量,但基础设施配置本身就能造成超过头部模型 leaderboard 差距的偏差。作者在 Terminal-Bench 2.0 上跨六种资源配置做实验,发现成功率随资源余量上升:3x 之前主要是在修基础设施可靠性(瞬时资源尖峰),3x 之后额外资源开始主动帮 agent 解出原本解不了的题,说明限制会改变 eval 实际测什么。建议把资源配置当一等实验变量,同时规定保证配额与硬性 kill 阈值两个参数。

## 关键主张

- **基础设施能摆动分数**: agentic coding benchmarks(如 SWE-bench 和 Terminal-Bench)常被当作模型能力的精确度量,但内部实验中 Terminal-Bench 2.0 上资源最富与最贫的差距达 **6 percentage points(p < 0.01)**——有时超过头部模型之间的 leaderboard 差距
- **agentic eval ≠ static benchmark**: static benchmark 直接给模型输出打分,runtime 不影响结果;agentic eval 给模型完整环境(写程序、跑测试、装依赖、多轮迭代),runtime 不再是 passive container 而是解题过程的组成部分;**资源预算和时间限制不同的两个 agent 不是在考同一张卷**
- **发现过程**: 在 Google Kubernetes Engine 上跑 Terminal-Bench 2.0,校准时发现分数与官方 leaderboard 不符,infra error rate 高得反常——**多达 6% 的任务因 pod 错误失败**,且多数与模型能力无关
- **floor=ceiling 是根因**: K8s 实现把 per-task 资源规格同时当作保底和硬上限,容器一旦超过就被杀;容器 runtime 其实通过两个参数管资源(保证配额 + 硬性 kill 阈值),二者相等时**没有任何余量**吸收瞬时尖峰,一次内存抖动就能 OOM kill 掉本可成功的容器;Terminal-Bench leaderboard 用的是更宽松的 sandbox provider,允许临时超额分配
- **实验设计**: 在 Terminal-Bench 2.0 上跑**六种资源配置**,从严格按 per-task 规格(1x,floor 与 ceiling 相等)到完全 uncapped;其余变量固定(同一 Claude 模型、同一 harness、同一任务集)
- **infra error 单调下降**: 成功率随资源余量上升,主因是 infra error rate 逐步下降——**从 strict 的 5.8% 到 uncapped 的 0.5%**;strict 到 3x 余量的下降(**5.8% → 2.1%,p < 0.001**)显著
- **1x–3x 分数在噪声内**: 从 1x 到 3x 成功率**在噪声边界内波动(p=0.40)**;1x 时崩溃的多数任务本来也会失败——agent 探索、撞资源墙、被抢占,但它从不在通往正确解的路上
- **约 3x 之后趋势反转**: success rates 攀升快于 infra errors 下降;**3x 到 uncapped,infra errors 再降 1.6 percentage points,success 跳升近 4 percentage points**;更多资源让 agent 尝试只在宽松配额下可行的路径(拉大依赖、起昂贵子进程、跑内存密集测试);**uncapped 相对 1x 的总提升为 +6 percentage points(p < 0.01)**;`rstan-to-pystan` 和 `compile-compcert` 在内存余量下显著改善
- **3x 是分界**: 到约 3x 前,额外资源只修基础设施可靠性(瞬时资源尖峰)——Terminal-Bench 维护者用的 provider 隐式在做这件事,eval 更稳而不更易;越过 3x 后额外资源开始**主动帮 agent 解决原本解不了的问题**,说明限制会改变 eval 实际测什么:紧限制奖励极高效策略,宽限制奖励能榨干所有资源的 agent,两者都是合法测试但塌缩成单一分数就难解释
- **`bn-fit-modify` 例**: 有些模型第一步就装标准 Python 数据科学栈(pandas、networkx、scikit-learn),宽松限制下可行,紧限制下 pod 在安装阶段、agent 还没写一行解法代码时就 OOM;存在更精简的策略(只用标准库从零实现数学),有些模型默认就用,有些不用——**不同模型的默认策略不同,而资源配置决定哪种策略恰好能成功**
- **跨模型与 SWE-bench 复现**: 方向一致、幅度随模型变化;在非 Claude 模型上趋势似乎成立但**未严格测试**;SWE-bench 交叉实验把总 RAM 提到 baseline 的 **5x**,跨 **227 problems、每个 10 samples**——同样单调上升,但幅度更小,**5x 只比 1x 高 1.54 percentage points**(SWE-bench 任务更不吃资源,小效应在预期内,但仍说明资源分配并非中性)
- **其他方差来源**: 时间限制也会起作用;eval 的每个元素都可能影响最终分——集群健康、硬件规格、并发度、甚至 egress 带宽;agentic eval 本质是端到端系统测试,任何组件都能当 confounder;观察到一个 anecdote:通过率随时段波动(API 延迟随流量/事故变化),**未正式量化**;模型提供方可专用硬件屏蔽但外部评测者难以做到;公开评测建议在多个时间、多天运行以平均噪声
- **建议**: 最理想是评测跑在与生产完全相同的硬件条件(scaffold + inference stack)下;务实做法是每个任务同时指定**保证配额**和**硬性 kill 阈值**两个参数而非单一 pinned 值;两者之间的 band 应校准到 floor/ceiling 分数落在噪声内——Terminal-Bench 2.0 的 **3x ceiling 把 infra error 降约 two-thirds(5.8% → 2.1%,p < 0.001),同时分数提升适度、落在噪声内(p=0.40)**,是合算的取舍;具体倍数因 benchmark/task 分布而异、应被报告,但经验校准原则通用
- **对使用者的结论**: 资源配置应被当作一等实验变量,像 prompt 格式或采样温度一样记录与控制;benchmark 维护者应发布推荐资源规格+强制方法;**leaderboard 差距低于 3 percentage points 就值得怀疑**,直到 eval 配置被记录与对齐——中等配置范围里的实测 spread 略低于 2 percentage points,极端达 6;朴素 binomial 置信区间本就有 1-2 percentage points,infra confounder 是叠加而非落在其内;"几分的领先可能真代表能力差距,也可能只是更大的 VM"

## 与现有 wiki 的关系

- 更新 [[agent-evals]]:把 eval 基础设施/资源配置提升为一等变量;与 [[2026-01-09-demystifying-evals-for-ai-agents]] 的"环境隔离 / stable environment"互补
- 更新 [[swe-bench]]:SWE-bench 227 题 RAM 交叉实验,同页的 SWE-bench 分数叙事需连带读
- [[harness-engineering]]:scaffold 与资源规格都是 harness 的一部分
- [[minimal-vs-rich-harness]]:资源预算改变"哪种 agent 策略获胜",是 harness 对比的隐藏变量
- [[tool-evaluation]]:评测驱动的开发循环必须控制 infra confounder
- [[anthropic]]:官方对 leaderboard 可信度的自我限定

## 待办 / 后续

- 原文自认:时段/API 延迟效应只有 anecdote、**未正式量化**
- 具体 multiplier 因 benchmark 而异,需逐 benchmark 校准并在报告中披露
- 与 CORE-Bench 评分 bug([[2026-01-09-demystifying-evals-for-ai-agents]])一起构成"eval 结果不可全信"的证据链
