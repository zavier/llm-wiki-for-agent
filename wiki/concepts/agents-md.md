---
type: concept
tags: [ai-agents, configuration]
topic: ai-agents
created: 2026-08-02
updated: 2026-11-06
refs: [github, three-tier-boundaries, ai-agent-spec, harness-engineering, factory-model, agent-readability, humanlayer, intent-debt, process-over-prose, ralph-loop, conformance-testing, documentation-redundancy, context-files-evidence, stale-instructions]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-04-19-agent-harness-engineering, 2026-02-25-factory-model-coding-agents, 2026-02-11-codex-agent-first-engineering, 2026-03-12-skill-issue-harness-engineering, 2026-06-05-intent-debt, 2026-05-03-agent-skills, 2026-01-31-self-improving-agents, 2026-08-02-building-ai-native-engineering-team, 2026-02-12-evaluating-agents-md, 2026-01-28-agents-md-efficiency, 2026-10-22-stale-instruction-files, 2026-11-03-policy-wording-compliance, 2025-11-17-agent-readmes]
status: active
---

# agents.md

仓库内配置文件,定义 AI 代理(如 GitHub Copilot)的行为规范与专职人格;本质是"为代理写的 spec"。

## 关键信息

- GitHub 分析了 2,500+ 仓库的 agent 文件(来源: [[2026-01-13-good-spec-for-ai-agents]]),发现:**大多数因太模糊而失败**;有效者覆盖 [[ai-agent-spec|六大核心区域]]
- 用途:定义专职代理人格——@docs-agent(技术写作)、@test-agent(QA)、@security-agent(代码审查);每份文件是"该人格的聚焦 spec":行为、命令、边界
- 适合"不同任务用不同代理"而非一个万能助手
- 与 [[three-tier-boundaries]] 结合:边界层级明确后代理决策更稳
- 相关形态:Anthropic 的 Skills(可复用 Markdown 行为定义)、Claude Code 子代理(独立 system prompt 与上下文窗口)
- **棘轮原则**(来源: [[2026-04-19-agent-harness-engineering]]):AGENTS.md 是 harness 的最高杠杆配置点(每轮进系统提示)——每一行都应能追溯到一次具体失败("出过事才加,模型强到冗余才删");保持短:HumanLayer 压在 60 行内——"飞行员的检查单,不是风格指南",更多规则让每条规则更不重要;与 [[three-tier-boundaries]] 的"真实示例锚定边界"互补(见 [[harness-engineering]])
- **文档 = 代理的训练材料**(来源: [[2026-02-25-factory-model-coding-agents]]):代理的入职环 ≈ 新工程师入职——探索代码库、搜 commit 历史、git blame、升级给人;**投资测试**:"仅凭文档 + commit 历史,一个新工程师能理解代码为何如此结构吗?"不能 → 代理在那里也会挣扎;git 历史正在成为代理导航的知识图谱,Slack/email 成为人-代理接口(见 [[factory-model]])
- **大文件的四个失败原因 + 地图论**(来源: [[2026-02-11-codex-agent-first-engineering]],OpenAI 零人工代码实验):大 AGENTS.md ①情境稀缺(巨文件挤掉任务/代码/文档)②指导过多反无效(什么都"重要"= 什么都不重要,局部模式匹配)③立即腐烂(过时规则坟场)④难以核实(单 blob 不适合机械检查:覆盖率/新鲜度/所有权/交叉链接)→ **"给智能体一张地图,而不是一本 1,000 页的说明书"**:~100 行 AGENTS.md 作内容目录 + 结构化 docs/(design-docs 带验证状态、exec-plans 版本化、references 的 llms.txt、QUALITY_SCORE/RELIABILITY/SECURITY);linter + CI 验证知识库新鲜度/交叉链接;doc-gardening 代理定期扫过时文档发修复 PR;"黄金原则"编码进仓库 + 后台清理任务(见 [[agent-readability]])
- **ETH Zurich 研究**(来源: [[2026-02-12-evaluating-agents-md]],**全文已入库 2026-11-06**;arXiv 2602.11988v1,2026-02-12,ETH Zurich + LogicStar.ai;AGENTbench = 138 实例/12 个自带上下文文件的冷门 Python 仓库 + SWE-bench Lite、四代理(Sonnet-4.5/GPT-5.2/GPT-5.1 M./Qwen3-30B)、三条件(NONE/LLM 生成/HUMAN)):
  - **数字口径已闭合**:摘要写"LLM 生成平均 **-3%**、人写 **+4%**",正文 §4.2 的分基准数字是 **-0.5%(SWE-bench Lite)/ -2%(AGENTbench)**;**两者同属一篇论文的不同层级,不是转述误差**(此前"-3% 待核"作废;引用行为取正文)
  - **代价**:步骤 +2.45/+3.92、成本 **+20%/+23%**、GPT-5.2/5.1m 的 reasoning token **+22%/+14%**;**人写文件除 Claude Code 外均提升**,但也要 +3.34 步、成本最高 +19%
  - **机制**:指令**真的被执行**(uv 被提及 1.6 次/实例 vs 未提及 <0.01;仓库专属工具 2.5 次 vs <0.05)→ 更多测试/探索 → 成功**不升**;**概览无效**:95-100% 的生成文件含概览段,却**没缩短**找到 PR 改动文件的步数;GPT-5.1 mini 甚至会反复去找并重读**已在上下文里**的文件(只在文件存在时发生,是它步数暴增的直接原因)
  - **冗余本质**:删掉仓库全部 `.md`/示例/`docs/` 后,LLM 文件**一致 +2.7% 且反超人写文件** → 价值 = 文档缺失时的替代品(见 [[documentation-redundancy]])
  - **消融**:换成更强的 GPT-5.2 生成(+2% SWE-bench Lite / **-3%** AGENTbench)、或换 Codex↔Claude Code 的生成提示,均无一致优劣 → **强模型/好提示不产生更好的上下文文件**;按仓库看无一仓库出现显著效应
  - **结论**:**只应包含代码库之外的具体附加指令**(工具链、非默认约定),优先人写;`641 词 / 9.7 节` 的实测人写文件相对“无文件”只换到 **+2.4%(p=21%,不显著)**——真正的信号是**人写 > 生成物 7pp(p=3.8%)**。不能读作“再写长点也行”
  - ⚠️ **v3 口径变更(2026-09-29)**:v1 摘要的“生成 -3% / 人写 +4%”已被取代——基准改名 **CTXbench**,人写从 +4% 降为 **+2.4% 且不显著**,摘要改为“**不普遍提升成功率**”(对生成物与人写都成立)。引旧数字(“+4%”或“AGENTbench”)即意味着在引 v1
  - **后续研究群(2026-11-06 入库四篇)**:[[2026-01-28-agents-md-efficiency]](手写根文件使时长 **-28.64%**、输出 token **-16.58%**,但**未测正确性**)、[[2026-10-22-stale-instruction-files]](陈旧文件赢过代码 **90.1%**,一句话可纠正——见 [[instruction-hierarchy]]、[[stale-instructions]] 两个新页)、[[2026-11-03-policy-wording-compliance]](**用 CTXbench 86 个任务**测措辞:遵守率 **0-78%**,条件式最差)、[[2025-11-17-agent-readmes]](2,303 份文件的内容普查:测试 75.9%/安全 14.8%)→ 全部收入 [[context-files-evidence]] 记分卡
  - HumanLayer 版结论:不自动生成、少即是多、渐进披露、<60 行;——**绝不让代理直接写 AGENTS.md,lead 批准每一行**;结构示例:STYLE/GOTCHAS/ARCH_DECISIONS/TEST_STRATEGY
- **意图账本 framing**(来源: [[2026-06-05-intent-debt]],Osmani):AGENTS.md = **意图账本,不是配置**——自动生成的文件(如 /init)描述"代码是什么",意图文件描述"团队想什么"(约定、"我们不这么干因为"、任何单文件里看不见的约束);与 OpenAI 四败因/ETH 反证不矛盾:反对的不是文件存在,是"把描述代码的文件当规则文件"——意图必须人写(见 [[intent-debt]])
- **五条不可妥协**(来源: [[2026-05-03-agent-skills]],Osmani 元 skill 提炼,"明天就能进任何 AGENTS.md"):①建之前显性化假设(静默的错误假设是最常见失败模式)②需求冲突时停下问,别猜 ③该顶回去就顶回去(不是 say-yes 机器)④偏好无聊明显的方案(聪明是昂贵的)⑤只碰叫你碰的东西——与 OpenAI 四败因兼容:短而强制(五条)而非长而忽略(见 [[process-over-prose]])
- **手册结构与复合学习**(来源: [[2026-01-31-self-improving-agents]],Osmani):AGENTS.md = 代理的"运行笔记本"(发现/约定/指引),四节结构 Patterns & Conventions / Gotchas / Style-Preferences / Recent Learnings;条目简短事实化——**prompt additive**;每任务后追加学习("代码库用 Library X 做 Y"、"Gotcha:改 user model 也要改 audit log");**Eric J. Ma 实时反馈技术**:"别用旧端点,用 v2/users API。**记到 AGENTS.md 里,然后继续**"——把实时纠正沉淀为持久偏好;警惕 context bloat(归档过时内容/按任务分区);**验证代理真的在用**(记忆只有被注入 prompt 才有效,progress.txt 需在 prompt 模板显式加入)(见 [[ralph-loop]]);与意图账本互补:意图账本管"团队想什么"(人写),运行笔记本管"代理学到什么"(循环追加,质量仍需人审——按文档冗余假说,自动追加条目属**最高风险形态**,见 [[documentation-redundancy]])
- **官方用法:解锁 agentic loops + 自动文档指令**(来源: [[2026-08-02-building-ai-native-engineering-team]],OpenAI):"**迭代 AGENTS.md 解锁 agentic loops**——跑测试和 linter 收反馈"(AGENTS.md = 让代理能自验的开关);文档指令自动包含在每次 prompt(改文档的约定随 agent 自动执行);测试覆盖指南也进 AGENTS.md;从官方 checklist 看,AGENTS.md 已是三处落地机制的载体(循环/文档/覆盖)——配置面的最高杠杆再次确认(见 [[conformance-testing]])

## 与其他页面的关系

- 实证与研究来源: [[github]]
- 内容规范: [[ai-agent-spec]];边界: [[three-tier-boundaries]]
