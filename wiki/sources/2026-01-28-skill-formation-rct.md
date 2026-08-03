---
type: source
tags: [ai-agents, skill-formation, rct, anthropic, learning]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-03
status: active
---

# How AI Impacts Skill Formation (2026-01-28,Anthropic RCT)

- 原文: `raw/2601.20245v2.pdf`(全文 12 页;2026-08-03 pdftotext 摄入;v2 发布 2026-02-01)
- 类型: 学术论文(RCT,预注册 OSF w49e7;Anthropic Fellows Program;arXiv:2601.20245 cs.CY;作者 Judy Hanwen Shen\*、Alex Tamkin)
- 备注: 本 wiki 第三十五篇源文档;**全文一手化完成**(此前为摘要+关键段落抓取,2026-08-02);所有待核数字闭合;注释转录开源:github.com/safety-research/how-ai-impacts-skill-formation

## 摘要

随机对照实验:学习新 Python 异步库(Trio)时,处理组(用 AI 助手 GPT-4o + 网页搜索 + 指令)vs 对照组(仅网页搜索 + 指令)。**主发现:用 AI 完成任务损害新技能形成**——概念理解、代码阅读、调试能力均受损(quiz 低 **-17% = 4.15/27 分 = 2 等级分,Cohen's d=0.738, p=0.010**;控制 warm-up 协变量后 d=0.725, p=0.016),且**任务完成时间无显著差异(p=0.391)**。**完全委派编码任务者有一些生产力提升,但以学习库为代价**。识别出**六种 AI 交互模式,三种涉及认知参与,即使有 AI 协助也保持学习结果**——高分模式 65-86% vs 低分模式 24-39%,分界鲜明。论文明确 chat 界面 = 认知卸载的**下界**:agentic/autocomplete 场景(免写 query)提速更大但技能损失更大。

## 关键主张

**实验设计**:主研究 n=52(26/26;58 招募、53 完成三部分、1 人按预注册标准除名——quiz 留四题空白);warm-up 任务(给字符串列表加边框,~4 分钟,无异步概念)校准 Python 熟练度;Trio 任务上限 35 分钟(两任务:timer 并发打印 + 带错误处理的记录检索);总时长上限 1h15、平均 58.5 分钟;众包平台 + $150 固定报酬;伦理经 Anthropic 内部审查

**Quiz 设计(可借鉴的测量工件)**:14 题 / 27 分;基于 CS 教育 meta-analysis 的四题型取三——概念理解、代码阅读、调试(排除写码以消除语法噪声,"低层语法记忆随 AI 集成重要性下降");覆盖 Trio 7 个核心概念;5 个版本经 item response theory 校准(题目-总分相关性/平均得分/局部题目独立性);评分细则预注册后提交

**主结果**:quiz -17%(4.15 分, d=0.738, p=0.010);任务时间无显著差异(p=0.391)——对照组 4/26 未在限时内完成第二任务,AI 组全部完成;所有经验水平(1-3/4-6/7+ 年)上对照组 quiz 均更高;**debugging 类题差距最大**(最小为代码阅读——两组代码阅读暴露相似,但对照组遇到更多错误、调试能力更强)

**为什么没提速(机制)**:完全委派子组(n=4,~20% 处理组)19.5min vs 对照 23min 确实快;但 AI 交互时间中位偏高——有人总交互 11 分钟、单条 query 写 6 分钟、共 15 条 query;**写 query 的斟酌时间(重读指令/改写查询)本身是理解过程**;chat 助手此成本显著,agentic/autocomplete 无此成本 → 提速更大、知识损失更大("较短的交互转化为对技能形成更大的负面影响")

**六种交互模式(定性分析,屏幕录制逐人标注 51/52 人)**:

| 模式 | n | 用时 | quiz |
|---|---|---|---|
| AI Delegation(只让 AI 生成+粘贴) | 4 | 19.5min 最快 | 39% |
| Progressive AI Reliance(任务 1 自己问,任务 2 全委派) | 4 | 22min | 35% |
| Iterative AI Debugging(5-15 条反复求助修错/验证) | 4 | 31min 最慢 | 24% |
| Generation-Then-Comprehension(生成后追问理解) | 2 | 24min | **86%** |
| Hybrid Code-Explanation(生成+解释混合提问) | 3 | 24min | 68% |
| Conceptual Inquiry(只问概念,独立解决错误) | 7 | 22min | 65% |

- 关键洞察:Generation-Then-Comprehension 与 AI Delegation **表面行为几乎一样**(生成→粘贴),唯一区别是"生成后再用 AI 检查自己的理解"——86% vs 39%(见 [[cognitive-surrender]] 的 offloading/surrender 与 [[loop-engineering]] 同构循环异果)
- 高分模式共同点:认知参与 + 独立思考;低分模式共同点:重依赖 AI 生成或调试,认知卸载(Lee et al. 2025)

**错误即学习(机制层发现)**:对照组中位遭遇 3 个错误 vs AI 组 1 个;12 个零错误完成者只有 2 人在对照组;错误类型分化——NameError/AttributeError 是打字错(与 Trio 无关),RuntimeWarning(coroutine never awaited)/TypeError(coroutine 对象而非 async 函数)是 **Trio 相关错误,强制理解核心概念**;论文结论:"遇到并独立解决错误可能在编码技能形成中起重要作用"

**采纳行为**:直接粘贴(n=9)最快;手动打字复制(n=9)与对照同速;混合(n=4);自己写+仅澄清提问(n=4)又快又高分;但**粘贴 vs 打字复制的 quiz 无显著差异**——"认知努力可能比完成任务花费的原始时间更重要"

**query 统计**:解释类 q=79(21/25 人问过)、生成类 q=51(仅 16/25 用 AI 生成代码)、调试类 q=9、能力类 q=4、感谢类 q=4;3/8 最低分者只生成不问解释;调试类 query 占比与完成时间正相关(r=0.43, p=0.033)、与 quiz 负相关(r=-0.41, p=0.043)

**自评与反馈**:对照组自报学习更高(7 点量表);两组愉悦度相近;AI 组自感"懒"、"理解还有 gaps"、"希望当时多读生成代码/多要解释"——投降者事后部分自知;对照组反馈"任务好玩、指令帮助理解 Trio"

**pilot 与方法论透明**(4 个 pilot):P1 平台 35% 对照组违规使用 AI(即"无 AI 对照组"在现实中会漏);P2 平台屏幕录制验证合规;local item dependence 问题(题目互相泄露答案)通过分页解决;pilot D(n=20):任务时间 d=1.11, p=0.03 / quiz d=1.7, p=0.003(pilot 效应更大,预注册保守取 d=0.85);pilot D 中对照仅 60% 完成两任务 vs AI 90%(Python 语法问题,非 Trio,主研究加了语法提示)

**局限(future work)**:单一 chat 界面任务 = 认知卸载下界,agentic 工具需直接实验;1 小时窗口 vs 真实数月-年技能形成(需纵向研究);无真实工作激励;无"人类协助"反事实(结对/课堂/评审 vs AI);prompting 技能未测量(仅自报);学习效果只以 quiz 测

## 与现有 wiki 的关系

- 更新 [[comprehension-debt]](全部数字闭合 + 错误即学习微观机制 + quiz 方法学 = 测量工件候选)、[[cognitive-surrender]](六模式 = offloading/surrender 实验级映射 + 事后自知证据)、[[agentic-engineering]](数字核实 + chat=下界坐实 skill atrophy 担忧)、[[pure-impure-engineering]](新技能任务无提速 vs 熟悉任务提速文献的边界标定)、[[ai-feature-implementation-loop]](理解力层与反证更新)、主题页(实证闭合 + 开放问题 3 更新 1 新增)
- 互证:六模式 ↔ [[cognitive-surrender]] offloading(健康)vs surrender(失败)二元谱系;"生成后理解" vs "纯委派"同行为异结果 ↔ [[loop-engineering]]"同构循环异果";错误机制 ↔ 刻意摩擦反制的实验支持;debugging 最大差距 ↔ "监督 AI 代码所需能力恰被 AI 使用侵蚀"的闭环反讽;chat=下界 ↔ 此前 wiki 的"agentic 损失可能更大"从推论升格为论文自身立场
- 无新矛盾;与 Goedecke ~30% 自报的关系 = 任务新旧边界而非矛盾(见 [[pure-impure-engineering]])

## 待办 / 后续

- 数字口径已全部闭合(参与人数 n=52、-17% 与 4.15 分、d=0.738 均已核实);仍开放:六模式在真实纵向场景(非 1 小时任务)的分布;agentic 编码工具的同类 RCT(论文列为 future work);"错误甜蜜点"(多少/什么类型错误最优)无数据
