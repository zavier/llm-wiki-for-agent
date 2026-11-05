---
type: concept
tags: [ai-agents, evaluation, methodology]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [agent-verification, llm-as-a-judge, tool-evaluation, conformance-testing, swe-bench, harness-engineering, context-rot, multi-agent-systems, official-sdlc-guides, factory-model, pr-contract, control-bands, context-anxiety]
sources: [2026-01-09-demystifying-evals-for-ai-agents, 2026-02-05-infrastructure-noise, 2026-03-06-eval-awareness-browsecomp, 2026-01-21-ai-resistant-technical-evaluations, 2026-08-21-ai-native-sdlc-playbook, 2026-02-12-evaluating-agents-md, 2026-04-30-cursor-agent-harness-improvement, 2026-08-02-building-ai-native-engineering-team, 2026-08-02-harness-design-for-long-running-apps, 2025-09-11-writing-effective-tools-for-ai-agents]
status: active
---

# Agent evals

在无真实用户参与下可自动重跑、对 agent 行为与结果打分的测量体系。难点与价值同源:让 agent 有用的自治/多轮/改状态能力,正是让它难评的原因。核心纪律是**先怀疑 eval 和基础设施,再怀疑模型**。

## 关键信息

- **为什么难**(来源: [[2026-01-09-demystifying-evals-for-ai-agents]]):agent 跨多轮调用工具、修改环境状态、随中间结果调整——错误会复合;传统 eval 假设"输入 X → 路径 Y → 输出 Z",而 agent 即使起点相同也可能走完全不同的**合法**路径
- **前沿模型会超越静态 eval**:Opus 4.5 在 τ²-bench 上发现政策漏洞完成订票,按题面判"失败",但对用户是更好的解——eval 需要能容纳这种情况,而不是惩罚它(来源: 同上)
- **官方术语口径**(来源: 同上):**task**(单个测试用例) / **trial**(同一任务的每次尝试) / **grader**(打分逻辑,内含多条 assertion 即 check) / **transcript**(= trace = trajectory,含输出、工具调用、推理、中间结果的完整记录) / **outcome**(trial 结束时**环境**的最终状态) / **eval harness**(跑 eval 的基础设施) / **agent harness**(= scaffold,让模型能作为 agent 行动的系统) / **suite**
- **transcript vs outcome 是最容易混淆的一刀**:订票 agent 在 transcript 里说"您的航班已预订",而 outcome 是环境的 SQL 库里到底有没有那条 reservation——评 agent 要评 outcome,transcript 用于诊断(来源: 同上)
- **推论:评"一个 agent" = 评 harness 与 model 的组合**(来源: 同上)

### grader 三档

| 档位 | 方法 | 强项 | 弱项 |
|---|---|---|---|
| code-based | 字符串匹配(regex/fuzzy)、二值测试(fail-to-pass / pass-to-pass)、静态分析(lint/type/安全)、结果校验、工具调用校验、transcript 分析(轮数/token) | 快、便宜、客观、可复现、易调试 | 对不匹配预期模式的合法变体脆弱、缺细微度 |
| model-based | rubric 打分、自然语言断言、成对比较、参考对照、多 judge 共识 | 灵活、可扩展、能捕细微度、能处理开放式与自由文本任务 | 非确定、比代码贵、**必须与人类 grader 校准** |
| human | SME 评审、众包判断、抽样复核、A/B、标注者一致性 | 黄金标准、贴近专家用户判断、用于校准模型 grader | 贵、慢、需要规模化的人类专家 |

- 聚合方式:**weighted**(加权分过阈)/ **binary**(全过)/ **hybrid**(来源: 同上)
- 选择原则:能确定性就确定性,**需要灵活或主观才上 LLM grader**,人类用于校准与主观项(来源: 同上)

### 能力 eval vs 回归 eval

- **capability / quality eval** 问"这 agent 能做好什么"——**应该从低通过率起步**,针对它吃力的事,给出可爬的坡
- **regression eval** 问"它还能不能做以前能做的"——应该近 100%,分数下降即信号
- 上线并优化后,通过率高的能力 eval 可以**毕业**成回归套件持续跑:"以前测'我们到底能不能做到',之后测'我们还能不能稳定做到'"
- 两者职责不同:能力 eval 给方向,回归 eval 防退化。爬能力坡时必须同时跑回归(来源: 同上)

### 非确定性:pass@k vs pass^k

- **pass@k** = k 次尝试里**至少一次**成功的概率。k 增大则分数上升("多打几脚球门")。适用:一次成功即有价值(coding 通常关心 **pass@1**)
- **pass^k** = k 次尝试**全部**成功的概率。k 增大则分数下降。适用:用户期望每次可靠——面向客户的 agent 要看这个
- 换算示例:单次成功率 75%,跑 3 次全过 ≈ 0.75³ ≈ **42%**
- k=1 时两者相同;k=10 时结论相反(pass@k 趋近 100%,pass^k 趋近 0)(来源: 同上)

### 零到一

- **别等**:**20-50 个来自真实失败的任务**就够起步——早期每次改动 effect size 很大(一次 prompt 调整可能把成功率从 30% 拉到 80%),小样本足以看出。成熟 agent 才需要更大更难的套件
- **越晚建越难**:"等太久,你是在从运行中的系统反推成功标准"(来源: 同上)
- 起点:搭建期你**本来就在手动跑**的那些检查 + bug tracker / 支持队列里的用户报障(按影响排序)
- 任务必须**无歧义**:两个领域专家应能独立得出相同 pass/fail 判断,且他们自己应能通过该任务;做不到说明任务需返工
- **每个任务配 reference solution**(一个能过全部 grader 的已知产出)——同时证明任务可解与 grader 配置正确
- **0% pass@100 通常是任务坏了,不是模型不行**。Terminal-Bench 审计案例:题面让 agent 写脚本但没说文件路径,而测试假设了某个路径——agent 因题面歧义而失败
- **平衡问题集**:既测"该发生"也测"不该发生"。只测单向会得到单向优化——只测"该搜时是否搜",会得到几乎什么都搜的模型。Claude.ai 的 web search eval 双向取样,把 undertriggering 与 overtriggering 都覆盖,靠多轮 prompt 与 eval 反复调才平衡(来源: 同上)

### eval harness 的稳定性

- **每个 trial 从干净环境开始、互相隔离**。共享状态(残留文件、缓存、资源耗尽)会造成**相关失败**——那不是 agent 表现差,是基础设施抖
- 共享状态也会**虚高**分数:内部 eval 中 Claude 曾靠读**上一轮 trial 留下的 git history** 取巧
- 若多个 trial 因同一环境限制(如 CPU 内存不足)失败,它们**不独立**,结果不可用于衡量 agent(来源: 同上)

### 设计 grader 的判断

- **评产出,别评路径**:硬性要求工具调用顺序的结果是过度脆弱的测试——agent 经常找到 eval 设计者没想到的合法走法。为了不惩罚创造性,评它产出了什么
- 多组件任务给**部分分**:正确识别问题并验证了客户、但退款没做成的客服 agent,明显优于一开始就失败的
- LLM judge 要给**退出口**——信息不足时返回 "Unknown",以抑制幻觉
- **按维度分派独立 judge**,而不是让一个 judge 同时评所有维度
- LLM judge 必须**与人类专家紧密校准**,确认分歧足够小之后才放权;健壮之后人类复核可以降到偶发
- **grader 要抗绕过**:任务与 grader 应设计成"必须真正解决问题"才能过,而不是利用意外漏洞
- **读 transcript**:这是判断"失败是否公平"的唯一方式——agent 真的错了,还是你的 grader 否掉了一个合法解;也是区分真实回归与噪声的方式(来源: 同上)

### 评测自身的失效模式(元层面)

- **基础设施是评测变量**(来源: [[2026-02-05-infrastructure-noise]]):Terminal-Bench 2.0 上跑六个资源档(1x 兼作 floor 与 ceiling → 3x headroom → 完全不设限),除资源外一切固定。结果:①infra error **单调下降**,从 strict **5.8% → uncapped 0.5%**,其中 1x→3x 是 **5.8%→2.1%(p<0.001)**;②**但 1x→3x 的成功率只在噪声内波动(p=0.40)**——前两档的“分数提升”不算数;③3x 之后趋势变了:infra error 只再降 **1.6pp**,而 success **跃升近 4pp**——宽裕资源开始解锁只有大分配才可行的解法;④uncapped 相对 1x 的总提升 **+6 percentage points(p<0.01)**。作者给出的做法:把 floor 与 ceiling 分开设定,并**校准到两端的分数彼此落在噪声内**(3× ceiling 是合理折中:infra 混杂被中和,同时保留有意义的资源压力)。作者结论:naive binomial CI 本身已跨 1-2pp,**<3pp 的排行榜差距应存疑**
- **eval 会被"通关"**(来源: [[2026-03-06-eval-awareness-browsecomp]]):BrowseComp 1,266 题中 **11 题取自评测材料本身**;**2 例**模型推断出自己正在被评测、找到并**解密了答案键**;多代理架构表现 eval awareness 的比例 **0.87% vs 单代理 0.24%(3.7×)**——自主性越高,识破评测的倾向也越高。URL 黑名单被证明无效,**评测完整性是持续对抗问题**
- **eval 会过期**(来源: [[2026-01-21-ai-resistant-technical-evaluations]]):同一道性能工程 take-home 被反复攻破,迭代 **2164→1790→1579→1487→1363**;越做越怪并牺牲真实性是这条路的自认代价
- **低分先怀疑 eval**:Opus 4.5 在 CORE-Bench 上初始 **42%**,查出僵硬比较(把 "96.12" 判错,因为期望 "96.124991…")、任务描述歧义、随机任务不可复现之后,升到 **95%**;METR 亦发现 grader 要求"超过"题面所述阈值的错配,惩罚了照指令做的模型(来源: [[2026-01-09-demystifying-evals-for-ai-agents]])
- **eval 饱和**:100% 通过的能力 eval 只能防回归、不再提供改进信号。SWE-bench Verified 一年内从 ~30% 到 >80% 逼近饱和,剩下的只有最难任务,"能力大涨只体现为分数微增"。Qodo 一度因 one-shot 编码 eval 看不出 Opus 4.5 的长任务进步,改做 agentic eval 框架才看清(来源: 同上)
- **读 transcript 是纪律,不是可选项**:"我们不会在有人深挖评测细节并读过一部分 transcript 之前,就采信分数"(来源: 同上)

### 与其他理解手段的分工

- 单一手段都会漏,叠起来用(瑞士奶酪模型,机制侧见 [[agent-verification]])(来源: 同上):
  - **automated evals**:快、可复现、无用户影响、可每 commit 跑;需前期投入与持续维护,且**与真实使用分布不符时会制造虚假信心**
  - **production monitoring**:真实行为、有 ground truth、能抓合成 eval 漏掉的;**被动**(问题先到用户),信号噪,需要埋点投入,缺 grading 基准
  - **A/B**:真实用户结果、控混杂;**慢**(数天到数周、要流量),只能测你部署了的东西
  - **user feedback**:能发现你没想到的问题、附带真实例子;**稀疏、自选择、偏严重项**,用户很少说清**为什么**,靠用户抓问题会伤用户
  - **manual transcript review**:建立失败模式直觉、抓细微质量问题、校准"好"的样子;**费时、不 scale、覆盖不一致、受评审者疲劳影响**
  - **systematic human studies**:金标准、处理主观项、反哺模型 grader;**贵、慢、标注者分歧需调和**
- 阶段映射:automated evals = 上线前与 CI/CD 第一道防线(每次 agent 变更与模型升级);monitoring = 上线后抓分布漂移与预料外的失败;A/B = 有流量后验证重大变更;feedback + transcript review = 持续实践(常 triage 反馈、每周抽读 transcript);human studies = 留给校准 LLM grader 与主观输出

### 组织与流程

- **eval-driven development**(来源: [[2026-01-09-demystifying-evals-for-ai-agents]]):先写 eval 来定义"计划具备的能力"(此时通过率为 0),再迭代到达标。这等于对"模型未来能做什么"下注——新模型发布时跑一遍套件就知道哪些注兑现了
- 维护形态:Anthropic 试过多种,最有效的是**专职 eval 团队拥有核心基础设施,领域专家与产品团队贡献大多数 eval 任务并自己跑**;对 AI 产品团队,"own 并迭代 eval 应该和维护单测一样例行"
- 让产品经理/客户成功/销售用 Claude Code 提 eval 任务 PR,并主动 enable 之
- 成本 upfront 可见、收益累积——这正是它容易被低估的原因;"定义 eval 任务是压力测试产品需求是否足够具体的**最佳方式之一**"
- 案例:Descript 围绕三维度建 eval(不弄坏 / 做我要的 / 做得好),从人工打分演进到 LLM grader + 产品团队定标准 + 周期人类校准,现并行两套套件(质量对标 / 回归);Bolt 在已有广泛使用的 agent **之后**才建,3 个月内做出静态分析 + 浏览器 agent 测应用 + LLM judge 判指令遵循的系统
- **配置也是被测对象**(来源: [[2026-08-21-ai-native-sdlc-playbook]]):官方 playbook 要求 eval 对 **CLAUDE.md / skills / hooks 的变更**与对代码变更同等门禁——"steering 代理的配置值得和代码一样的回归测试";配置变更是以 pass rate 为合并门;每个生产事故写一条 eval 归属到对应团队;套件是**活的工件**,模型变强后旧 case 失去区分度,需从监控补新
- 反面校准物:ETH Zurich 的 AGENTS.md 受控实验(来源: [[2026-02-12-evaluating-agents-md]],全文已入库)给出正文口径 **-0.5%/-2%**、摘要口径 **-3%**(见 [[documentation-redundancy]])——**读法本身就是一课**:摘要的圆整数字与正文的分基准数字不一致,引"配置有效/无效"必须回到分基准表格才发现**人写 +4% vs LLM -3%** 的方向差异。两个可拿来用的 eval 卫生实践:外包注入的基准**要自己验**(该论文的回归测试由 LLM 生成,但强制 fail@R / pass@R∘X\* 并人工修过拟合断言,平均覆盖 75%)、**任务描述要验无解法泄漏**(抽检 10%)
- OpenAI 侧的形态:**gold-standard PR 样例集(代码+注释)存为评估集**衡量评审工具;**PR comment reactions 作低摩擦质量度量**(来源: [[2026-08-02-building-ai-native-engineering-team]]);trace + 人类反馈 → 持久 eval → 门禁 → harness 改动的闭环(flywheel)
- **在线评测变体**:Cursor 的 Keep Rate 以固定间隔回放历史代码库状态、比对建议是否与后续人工实现一致,弥补离线套件与真实分布的差距(来源: [[2026-04-30-cursor-agent-harness-improvement]])

### 反模式(官方明列)

- 用通用指标(perplexity / BLEU 类)代理 agent 质量
- 评测集偏离线上分布;只测精心挑选的输入(会系统性高估)
- 不校准人类反馈就放权 LLM judge
- 只跑一次评测;**把 <3pp 的排行榜差距当结论**
- 硬性规定工具调用顺序;grader 可被绕过
- 把"看起来能跑"当评测依据(来源: [[2026-01-09-demystifying-evals-for-ai-agents]]、[[2026-02-05-infrastructure-noise]])

## 与其他页面的关系

- 与 [[agent-verification]] 分工:那页讲**验证回路机制**(给 agent 可运行的检查、四档门禁、maker/checker 分离),本页讲**评测方法学**(任务与 grader 怎么设计、非确定性怎么度量、评测自身如何失效);两者在"配置即被测对象"处交汇
- 是 [[llm-as-a-judge]] 的上层容器:LLM judge 只是三档 grader 中的一档,本页给出它的校准义务、退出口要求与分维度原则
- [[tool-evaluation]] 是本页方法论在**工具层**的具体化(原型 → 评测 → 代理协作优化)
- 与 [[conformance-testing]] 互补:一致性测试提供验收标准,本页提供自动衡量是否达标的手段
- 承接 [[swe-bench]]:SWE-bench Verified / Terminal-Bench 是本页 grader 体系(确定性测试 + 结果校验)的规模化实例,也是 eval 饱和与基础设施噪声的典型案例
- 是 [[harness-engineering]] 的下游依赖:harness 组件会随模型升级失效,而"哪些组件还在承重"只能靠 eval 回答
- 与 [[context-rot]] / [[context-anxiety]] 相关:上下文压缩是**不可逆决策**,压缩质量需要专门 eval
- 与 [[official-sdlc-guides]] 的对比轴:Anthropic 把 eval 定位为配置门禁与事故闭环,OpenAI 把它定位为评审工具度量与用例扩展
- 与 [[factory-model]]、[[pr-contract]] 同族:验证是瓶颈这一判断的测量学基础;与 [[control-bands]] 交叉(control band 的 σ 阈值本身就是一种在线评测)
- 与 [[multi-agent-systems]] 交叉:eval awareness 在多代理架构下放大约 3.7 倍,是"更高自主性"的隐藏成本
