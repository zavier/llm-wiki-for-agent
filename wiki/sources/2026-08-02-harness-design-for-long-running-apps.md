---
type: source
tags: [ai-agents, harness, generator-evaluator, frontend, long-running]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Harness design for long-running application development (2026-08-02)

- 原文: `raw/Harness design for long-running application development.md`
- 类型: Anthropic 工程博客(Labs 团队,**作者 Prithvi Rajasekaran**;致谢含 Mike Krieger、Justin Young 等)
- 发布日: frontmatter `published` 为空,**待核实**(正文提及 Opus 4.6 发布,推定 2026);文件命名取剪藏日 2026-08-02
- 备注: 本 wiki 第十一篇源文档;是 [[2026-08-02-effective-harnesses-for-long-running-agents|上一篇 harness 文献]]的直接续作(同团队、同代码基);GAN 启发的 generator-evaluator 架构,跨越主观审美(前端设计)与可验证正确性(全栈编码)两个领域

## 摘要

作者从前端设计质量与无人工干预建应用两个问题出发,受 GAN 启发设计**生成器-评估器(generator-evaluator)多代理结构**:先把主观判断("这个设计好不好")转化为可评分的具体标准,再用独立的评估器代理打分反馈,驱动生成器迭代。应用到长时自主编码后,最终架构是**三代理:planner(规划器)、generator(生成器)、evaluator(评估器)**,产出跨多小时的完整全栈应用。文章还记录了模型换代(Opus 4.5 → 4.6)时精简 harness 的系统化方法。

## 关键主张

- **两个新失败模式**:
  - **上下文焦虑(context anxiety,见 [[context-anxiety]])**:上下文窗口将满时,模型开始提前收尾;Sonnet 4.5 表现强烈,仅靠 compaction 不够——**context reset(清空窗口 + 新代理 + 结构化交接)**成为必需;Opus 4.5 基本消除了该行为,后续 harness 得以去掉 reset
  - **自评偏差**:让代理评价自己的工作,它会自信地夸奖——即使人类明显觉得平庸;主观任务(设计)尤甚;**把干活的和评分的分开**是强杠杆——独立评估器调成"多疑"比让生成器批判自己可行得多;评估器本身仍是 LLM,仍有宽松倾向,但可调
- **前端设计实验**:四个评分标准——**Design quality(整体性)/ Originality(原创性,明确惩罚模板布局与"AI slop"如白卡片紫渐变)/ Craft(工艺:排版/间距/色彩/对比)/ Functionality(可用性)**;重点加权 design+originality(模型默认 craft/functionality 已达标);评估器用 few-shot 评分样例校准,减少跨迭代分数漂移;评估器带 **Playwright MCP 直接操作活页面**再打分;每代 5-15 轮迭代,全程最长 4 小时;生成器每轮做战略决策(分数趋好→精修;不行→整体换风格);标准措辞本身会塑造输出("museum quality"→视觉趋同);第九轮平淡 → 第十轮彻底重造(3D 空间、CSS 透视地板、门式导航)的创作跳跃是单遍生成未见过的
- **全栈三代理架构(V1,Opus 4.5)**:
  - **Planner**:1-4 句 prompt → 完整产品 spec;要求雄心勃勃的范围、聚焦产品语境与高层技术设计而**非细粒度实现细节**(细节写错会在下游级联);主动把 AI 功能织入 spec;可用 frontend design skill
  - **Generator**:一次一个特征(sprint),React/Vite/FastAPI/SQLite 栈,每个 sprint 结束自评再交 QA,git 版本控制
  - **Evaluator**:Playwright MCP 像用户一样点遍运行中的应用(UI/API/数据库状态),按 bug + 四条标准(产品深度/功能/视觉设计/代码质量)打分;**每条标准有硬阈值,任一不达标 sprint 失败**并给出可执行的详细反馈
  - **Sprint contract**:写码前生成器与评估器**协商"完成"定义**——生成器提方案 + 成功验证方式,评估器审查是否在做对的事,迭代到达成一致;文件通信(一方写文件、另一方读并回复)
- **V1 实证(Retro 游戏制作器)**:Solo 20 分钟/$9 vs Harness 6 小时/$200——**成本 20 倍,质量差距立现**;solo 版核心功能坏了(实体无输入响应、接线断裂无表面迹象);harness 版可玩、更丰富、含 AI 生成功能;评估器抓到真实 bug(具体到行号与根因,如 `fillRectangle` 未在 mouseUp 触发、删除键 handler 条件错误、FastAPI 路由顺序导致 422)
- **评估器调优的代价**:开箱即用的 Claude 是**差劲的 QA**——发现真问题后说服自己"不严重"而放行;测试表面化,不探边界;调优循环 = 读评估器日志、找与人类判断的分歧、更新 QA prompt,多轮才达标;残余盲区:布局细节、直觉不顺畅的交互、深层嵌套功能的漏测;**"Claude 听不见"**——DAW 的音乐品味反馈环失效
- **harness 简化原则(V2,Opus 4.6)**:每个 harness 组件都编码了"模型自己做不到什么"的假设,值得压力测试——**假设会随模型变强而过时**;激进砍掉全部组件失败(无法复现性能、不知道谁承重)→ 改逐组件移除评估;Opus 4.6(更会规划、更持久、更可靠地大代码库、更好的 code review/debug、长上下文检索改进)后:去掉 sprint 结构(生成器无分解连续跑 2+ 小时);保留 planner(去掉则生成器欠范围化)与评估器(改单次终评);**评估器价值有边界**:任务在模型可靠 solo 能力内时是纯开销,在能力边界外才有真实提升
- **V2 实证(DAW)**:3 小时 50 分 / $124.70(planner 4.7 分钟/$0.46;Build R1 2h07m/$71.08,QA R1 8.8m/$3.24,三轮递减);QA 仍抓到真缺口(时间线 clip 不能拖、录音是 stub、EQ 是数字滑杆非图形)
- **结论**:harness 组合空间不会随模型变强而缩小,而是**移动**——AI 工程师的工作是不断找新的组合;换新模型时应重新审视 harness,剥掉不再承重的部分、加新能力

## 与现有 wiki 的关系

- 新建概念: [[context-anxiety]]
- 更新了 [[llm-as-a-judge]](自评偏差实证 + 评估器校准)、[[long-running-agents]](三代理架构与 sprint contract)、[[context-engineering]](context anxiety 与 reset)、[[agent-verification]](硬阈值评估器)、[[agentic-workflow-patterns]](evaluator-optimizer 深度案例)、[[spec-driven-development]](planner 自动化 Specify)、[[ai-feature-implementation-loop]](成本数据与简化原则)
- 与既有无矛盾;多组互证:**自评宽松 ↔ ChemCrow 反证**(两条独立证据);**上下文焦虑 ↔ 上篇"提前宣布完成"**(机制解释);**sprint contract ↔ conformance checklists**(协商式 done 定义);**评估器盲区 ↔ 上篇 alert 模态框盲区**(验证器受模型输入模态限制)
- 成本数据首次给出 harness 的量化代价(Solo vs 三代理 20 倍);社区呼应:文末提到 "Ralph Wiggum" 方法(hooks/脚本保持连续迭代循环)与 harness 思路趋同

## 待办 / 后续

- 核实发布日与 Opus 4.6 时间线;跟进 Anthropic Labs frontend design skill
- 评估器"能力边界"判断的操作化(任务在模型可靠 solo 能力内外怎么判断?)——开放问题
- 跟进 generator-evaluator 在科学/金融等领域的泛化;QA 盲区(模态受限)的缓解实践
