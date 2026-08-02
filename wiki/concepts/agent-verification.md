---
type: concept
tags: [ai-agents, verification, quality]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, conformance-testing, llm-as-a-judge, ai-agent-spec, agentic-systems, long-running-agents, context-anxiety, factory-model, pr-contract, comprehension-debt, openai, humanlayer, loop-engineering, cognitive-surrender, intent-debt, agent-management]
sources: [2026-08-02-best-practices-claude-code, 2026-08-02-building-effective-ai-agents, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-02-25-factory-model-coding-agents, 2026-01-07-ai-code-review, 2026-03-14-comprehension-debt, 2026-02-11-codex-agent-first-engineering, 2026-03-12-skill-issue-harness-engineering, 2026-06-07-loop-engineering, 2026-06-15-agentic-code-review, 2026-08-02-building-ai-native-engineering-team]
status: active
---

# Agent verification

给代理一个能运行的检查(测试/构建/截图/差异脚本),把"看起来完成了"变成可判定的 pass/fail;让验证回路自己闭合,而不是靠人盯。

## 关键信息

- 核心动机:没有可运行的检查,"看起来完成"是唯一信号,你本人就成了验证回路——每个错误都在等你发现(来源: [[2026-08-02-best-practices-claude-code]])
- 检查的形态:测试套件、构建退出码、linter、diff 固定输出的脚本、浏览器截图对照设计图
- 门禁强度四档(每档用注意力换自动化):
  1. **同 prompt 内**:写完即跑测试并迭代(任何任务都能用)
  2. **会话级**:`/goal` 条件——独立评估器每轮复查,不满足就继续干
  3. **确定性门禁**:Stop hook 以脚本运行检查,不通过则拦截回合结束(连续 8 次拦截后强制放行)
  4. **第二意见**:验证子代理/动态工作流,用新模型尝试反驳结果——**干活的不给自己打分**
- 要求**证据而非断言**:贴测试输出、跑过的命令及其返回、结果截图——审查证据比重跑验证更快,也适用于你没盯着的会话
- "信任-验证鸿沟":看似合理的实现不处理边界情况;规则是"无法验证就别上线"
- 代理学视角(来源: [[2026-08-02-building-effective-ai-agents]]):agents 每步从环境获取 **ground truth**(工具调用结果/代码执行)评估进展——验证检查正是 ground truth 的来源;代理可在检查点暂停等人类反馈;错误复合(compounding errors)是自主运行的主要风险,验证门禁是主要对冲(见 [[agentic-systems]])
- 与 [[2026-01-13-good-spec-for-ai-agents|Osmani 指南]] 的自验证/一致性测试主张同源
- **长时任务验证**(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]]):Anthropic 发现的最大失败模式是"**未测试就标完成**"——Claude 会改代码、跑单测/curl,但识别不出端到端不工作;解法:显式提示 + 浏览器自动化(Puppeteer MCP)验证,"像人类用户一样测试",配合 feature list 的 passes 门禁(自验证后才允许翻转);注意验证器自身的盲区(浏览器自动化看不到原生 alert 模态框,该类特征更易出 bug)(见 [[long-running-agents]])
- **硬阈值评估器**(来源: [[2026-08-02-harness-design-for-long-running-apps]]):三代理 harness 的 QA 代理用 Playwright 点遍运行中应用,按多条标准(产品深度/功能/视觉设计/代码质量)打分,**每条硬阈值、任一不达标 sprint 即失败**并回详细反馈;反馈具体到行号与根因(FastAPI 路由顺序 422、handler 条件错误)
- **Sprint contract**:写码前由生成器提案 + 评估器审查,协商"完成"定义与验证方式——验收标准在写码前就谈判锁定(与 [[conformance-testing]] 同源,见 [[long-running-agents]])
- **验证器盲区是模态限制**:"Claude 听不见"(DAW 音乐品味无法评)+ 看不到原生 alert 模态框——验证器感知被模型输入模态框住;且开箱即用的 LLM 是差劲 QA(见 [[llm-as-a-judge]])
- **验证是瓶颈,不是生成**(来源: [[2026-02-25-factory-model-coding-agents]]):舰队规模下验证比生成更难——改动前通过的测试不保证抓回归;代理写"技术上有效但漏关键用例"的测试;UI 验证脆弱;上下文窗口外约束被漏;环境抖动在并行规模下从烦扰变系统阻塞(40 代理撞同一 flaky 测试);所需基础设施(自动回归检测、工件级验证、快速环境供应、并行护栏)全是未解投资——**在验证追上生成之前,人工审查不是可选开销,是安全系统**(见 [[factory-model]])
- **评审经济学(2026 数据,来源: [[2026-06-15-agentic-code-review]],Osmani 汇总四个独立数据集)**:Faros AI(2026-03,22k 开发者/4k 团队,厂商有立场但跨源一致)——churn **+861%**、incidents/PR **+242.7%**、人均缺陷率 **9%→54%**、评审中位时长 **+441.5%**、**零评审合并 +31.3%**("没人决定停止评审,评审者跟不上量,未读合并变常态")、**成熟纪律团队被击穿一样狠**(好流程保护不了——量来得比流程设计能吸收的快)、agent PRs 平均大 51%;CodeRabbit(2025-12,470 开源 PR)——AI 变更 ~**1.7x 问题**(逻辑/正确性 +75%、安全 1.5-2x、可读性 3x+),"可预测可定位" → 评审可直瞄;GitClear(2022-2025)——**4x 原始产出 vs ~12% 真实增益**(含选择偏差),"4x 代码换十分之一价值,人还得全审" = 验证缺口一行式;GitHub——Copilot review 60M+ 次/一年 10x,平台 >1/5 评审涉代理;含义:**验证(而非生成)是当前瓶颈**,QA/评审工作量随产出上升——"AI 让我们更快"就裁人危险(见 [[factory-model]])
- **分层评审,不按作者分层**(来源: [[2026-06-15-agentic-code-review]]):按 blast radius/代码寿命/理解人数三变量分档——config 变更 = linter+一瞥,payments 路径 = 全栈(类型/测试/两个异质 AI 评审器/系统 owner 人/安全通过);solo 无用户 = 测试兜底+只审重要的("没用户是推迟评审的许可,不是跳过验证的许可"——跳过 = 以更高价推迟 [[intent-debt]]);大组织老代码 = 每条警示全额生效(重复 helper 是未来 bug 面;没人理解的变更 = [[comprehension-debt]] 变 on-call 事故)
- **评审器异质性**(来源: [[2026-06-15-agentic-code-review]]):4 评审器并行实验(CodeRabbit/Sentry Seer/Greptile/Cursor BugBot;146 真实 PR/679 findings/3.5 周)——**617 个标记位置 93.4% 恰好只被一个工具抓到、6% 两个、几乎无三个、四个一个都没有**;各强一类(Greptile 正确性/架构近零假阳性;CodeRabbit 网最广+一键修复;Seer 生产故障严重性)= 对抗性评审的实证;"四份同模型 = 一个评审员加更大的发票,四个真不同的评审员浮现任何单一成员(含人类)找不到的 bug 集";厂商基准:CodeRabbit Martian F1 ~49%、Greptile ~82% vs 44% bug-catch(更多假阳性)、Anthropic Code Review <1% 误标 + 内部实质评审率 16%→54%;实操:高端场景跑两个性格不同的、solo 一个好评审器+真测试、在自己的代码上测量(见 [[llm-as-a-judge]])
- **Human on the loop**(来源: [[2026-06-15-agentic-code-review]]):"人类读每行"已被量终结;同族模型闭环 = 盲点相关+在同一处自信地同意([[cognitive-surrender|borrowed confidence]])——"循环可以非常确定也非常错,没人能分辨";人保留四件:问责(不能 3am page 模型)/变更方向判断/高 blast radius 门槛/**没人写下来的行为**(模型审存在的代码,很少标记"没人想到要写的需求");AI 评审 = **传感器不是裁决**(数据,不是决定);Osmani 实践:AI 批量初审出风险排序(安全/需工作/高风险),人确认低风险+细看高风险——"不是旧评审小时略快,是不同形状的小时";Kun Chen 极端版(40 PRs/天):意图 upfront 写进 plan + 自动化评审门(No Mistakes)+ 卡住时升级——solo 专属理性条件,复制到团队 = 复现 Faros 数字(见 [[agent-management]])
- **评审纪律四则**(来源: [[2026-06-15-agentic-code-review]]):①**测试变更比代码读得更仔细**——agent 改行为后重写断言匹配新(坏)行为,"200 个改过的测试绿了≠对";**变异测试**:coverage 说行跑了,变异测试说行错了测试会不会发现 ②**CI 是不动的墙**——agent 会弱化 CI 让自己通过(不是恶意,梯度下降找最便宜的绿);确定性门是唯一不能被自信段落说服的部分;警惕删测试/跳 lint/降覆盖率阈值/重复 helper/**不受信任输入流入 prompt**(agent 功能 = prompt injection 新来源,漏洞潜伏在稍后到达的数据里,见 [[model-context-protocol]]、[[curse-of-instructions]]) ③**快失败昂贵尾部**——agent 擅长小而清(~28% 即时合并),收主观反馈即 **ghost 弃来回**(被拒 agent PR 38% 归因弃审,arXiv 2601.15195);断路器从便宜信号(文件类型/补丁大小)预测高维护 PR(arXiv 2601.00753,33,707 PRs);先 triage,别让人在 agent 一推就弃的庞然大物上花一小时 ④**证据门槛**——拒绝无证据变更(变更说明/diff 可读/测试输出/证明真跑过),把意图重构推回提交方(便宜),别自己吸收(贵)(见 [[pr-contract]])
- **官方评审方法论**(来源: [[2026-08-02-building-ai-native-engineering-team]],OpenAI):AI 评审器**可执行部分代码/解释运行时行为/跨文件跨服务追踪**(超越静态分析);**模型必须专门训练识别 P0/P1 bug + 调优为高信噪比**(冗长响应 = 噪音 lint 被无视);AI 评审**不必然加速 PR(抓真 bug 时更慢)但防缺陷防 outage**;工程师委派首轮评审、**own 最终评审与合并**;落地:**gold-standard PR 样例集(代码+注释)存为评估集衡量工具**、**PR comment reactions 作低摩擦质量度量**、小开始快速推广(见 [[pr-contract]])
- **人类侧闭环:PR Contract**(来源: [[2026-01-07-ai-code-review]]):"证明它工作"的负担显式化——四字段契约(意图/证据/风险+AI 角色/评审重点,见 [[pr-contract]]);量化了验证缺口:PR 增大 ~18%、每 PR 事故 +24%、变更失败率 +30%、约 45% AI 代码含安全缺陷、逻辑错误 1.75×/XSS 2.74×(均为二手引述待核);团队场景评审成为限速器,须拆小 PR 防堵;
- **知识转移作为验证义务**:AI 写的代码必须有人能解释——否则 on-call 昂贵(OCaml 拒绝 13k 行 AI PR 即案例);审 AI 代码比审人代码更费力
- **安全规则**:凡触碰 auth/支付/secrets/不可信输入,合并前人类威胁模型评审 + 安全工具扫描(把 AI 当高速实习生)
- **测试的硬上限**(来源: [[2026-03-14-comprehension-debt]]):覆盖全部可观察行为的测试套件常比被测代码更复杂——无法推理的复杂度不提供安全;**无法为没想到要指定的行为写测试**(没人写"拖拽项不应变全透明");AI 改行为并更新几百条测试匹配时,问题从"代码对吗"变"测试改动都必要吗,覆盖够抓我没在想的东西吗"——只有理解能回答(见 [[comprehension-debt]])
- **智能体对智能体评审**(来源: [[2026-02-11-codex-agent-first-engineering]],OpenAI 零人工代码实验):评审闭环全部代理化——本地自审 → 多个特定智能体审查(本地+云端)→ 响应反馈循环至全部满意(实为 Ralph Wiggum 循环);"人类可审但不必须,后来几乎全部转为智能体对智能体";验证手段同步代理化——按 worktree 起应用实例、Chrome DevTools 驱动、可观测性栈(LogQL/PromQL)查询;端到端自主阶梯(验证状态→复现 bug→录故障视频→修复→运行验证→录解决视频→开 PR→回应反馈→修构建→仅需判断时交人→合并);**合并哲学反转**:减少阻塞门、偶发失败重跑解决——"纠错成本低、等待成本高"(与 [[pr-contract]] 的人类签字立场构成阵营分歧,见综合页)
- **回压(back-pressure)体系**(来源: [[2026-03-12-skill-issue-harness-engineering]],HumanLayer):任务成功率与"代理能否验证自己的工作"强相关——最高杠杆投资;机制:强类型 typecheck/build、单测/集成测试、覆盖率报告(Stop hook 提示补)、UI 测试(playwright/agent-browser);**验证必须上下文高效**:早期每改必跑全量测试 → 4,000 行通过输出淹没上下文,代理丢失任务线索并对刚读的测试文件产生幻觉;改为**吞掉输出只浮错误**(成功静默、失败冗长,exit 2 让 harness 接续);hooks 是回压的机械载体(每次停止跑 typecheck/build,错误在完成前亮出)(见 [[harness-engineering]])
- **停止条件验证**(来源: [[2026-06-07-loop-engineering]],Osmani):`/goal` 原语把 maker/checker 分裂应用到**停止条件本身**——每轮后由单独的模型检查"完成"是否成立(写码的代理不给自己的作业打分),如"test/auth 下所有测试通过且 lint 干净"然后走开;但"**done 是主张,不是证明**"——无人值守的循环 = 无人值守地犯错,验证的责任仍在你肩上("你的工作是交付你确认能工作的代码",与 [[pr-contract]] 立场一致)(见 [[loop-engineering]])

## 与其他页面的关系

- 与 [[conformance-testing]] 互补:一致性测试是"验收标准",本页是"验证回路机制"
- 与 [[llm-as-a-judge]] 同族:独立评审/反驳模式
- 是 [[ai-feature-implementation-loop]] 质量层的核心;工具见 [[claude-code]]
