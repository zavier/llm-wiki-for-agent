---
type: source
tags: [ai-agents, agents-md, compliance, instruction-following, experiment]
topic: ai-agents
created: 2026-11-06
updated: 2026-11-06
status: active
---

# Do Coding Agents Follow AGENTS.md? The Effect of Policy Wording on Instruction Compliance (2026-11-03)

- 原文: `raw/2611.04367v1.pdf`(arXiv 2611.04367v1,2026-11-03;投 IEICE Trans. Inf. & Syst. Letters)
- 类型: 实证论文(Tsuchida, Fan, Matsumoto — NAIST;Shimari — Wakayama;Gaikovina Kula — Osaka)
- 备注: 本 wiki 第六十七篇源文档;**把"指令被遵循"(ETH 的定性结论)拆成"什么措辞、在哪个模型上、遵守百分之几"**。直接复用 [[2026-02-12-evaluating-agents-md|ETH]] 的 **CTXbench**

## 摘要

在 **86 个任务 / 10 个仓库**(取自 CTXbench,筛掉任务 commit 处无 ACF 的)里插入**同一条可机械检测的策略**,只用四种措辞之一(规定式 / 说明式 / 条件式 / 禁止式),在 4 个 harness-模型组合上各跑 3 次(每风格 1,032 次会话)。策略 ="在每个新增或修改的 Python 函数的 `def` 行正下方加注释 `# @tracked`"。结果:**条件式("如果你新增或修改函数,则…")被遵守得明显更差**;规定式与说明式谁更好**随组合而变**;开放权重组合整体几乎不遵守(≤20.4%,最低 0%)。

## 关键主张

**四个写法与遵守率(Table 3,%)**(来源: 同上):

| harness / 模型 | 规定式 | 说明式 | 条件式 | 禁止式 | p |
|---|---|---|---|---|---|
| Claude Code / claude-opus-5 | 78.0 | 77.2 | **64.2** | 70.7 | <0.001 |
| Claude Code / claude-sonnet-5 | 71.6 | 49.4 | **35.6** | **17.3** | <0.001 |
| qwen-code / gpt-oss-120b | 6.7 | 20.4 | 0.8 | 0.4 | <0.001 |
| qwen-code / Qwen3-Coder-Next | 1.3 | 0.8 | 0.4 | 0.0 | 0.343 |

**两条结论(来源: 同上)**:①**条件式的惩罚是稳定的**——三个显著组合里条件式都低于规定式与说明式(rank-biserial 0.29~0.97);作者解释:条件句要求代理**先判断自己的动作是否满足条件**,比直接指令更容易被漏掉。②**最优写法不稳定**——sonnet-5 上规定式最好(71.6 vs 49.4),gpt-oss-120b 上说明式最好(20.4 vs 6.7);同一 harness 内换模型,风格间差距从 opus-5 的 14pp 扩到 sonnet-5 的 **54pp** → **能力越弱,越吃措辞**。

**天花板问题(来源: 同上)**:qwen-code 上两个开放权重模型**所有写法都 <21%**(Qwen3-Coder-Next ≤1.3%)。作者谨慎标注:两个模型只跑了 qwen-code,**无法区分是模型、harness 还是这对组合**导致的天花板。

**设计细节(来源: 同上)**:86/138 任务保留(任务 commit 处有 ACF);AGENTS.md 与 CLAUDE.md 并存时取**较大**的一份、删掉较小的,再按各 harness 识别的文件名另存;策略统一**追加在文件最后一行**、空行分隔,保证四个版本位置与上下文完全相同。会话被判"合规"= **所有**目标函数都带该注释;同一任务 3 次运行合并成一个值;剔除"没有新增/修改任何 Python 函数"的会话(各风格剔除 63-75 次)。

**它引用的相关证据(转引,待核原文)**(来源: 同上):
- OctoBench(ACL 2026):仓库级代理对单条策略的遵守率 **79.75%~85.64%**
- Yang, He, Zhou([arXiv:2607.26819]):开源社区"贡献规则"类策略,四个模型对**"应拒绝贡献"的规则遵守率 0%**,且在 prompt 中给出规则原文**也没用**
- **McMillan([arXiv:2605.10039])四面析因**:**文件长度、策略位置、文件结构、是否存在冲突策略——都不显著改变遵守率** ← 这条最值得跟 [[curse-of-instructions]] 对照
- Mohsenimofidi 等(MSR 2026):ACF 策略五分类(本研究取其四,去掉 Descriptive,因其不表达显式策略)

## 与现有 wiki 的关系

- 新建/更新:[[curse-of-instructions]](重要限定:指令多≠被忽略,而是**遵守本就不完全且吃措辞**;McMillan 的四面析因说明"长度/位置/结构"不是遵守率杠杆)、[[agents-md]](写法可获得性建议)、[[three-tier-boundaries]] 与 [[governance-as-code]](书面规则的天花板 = 数据支撑"该用 hook 的别用散文")、[[agent-evals]](同一条策略的可机械检测设计 = 可复用的评测范式)
- 与 [[2026-02-12-evaluating-agents-md|ETH]] 互证:ETH 说"指令被遵循(uv 1.6 次 vs <0.01)所以失败不是不听话";本研究补充:**"被遵循"是一个 0-78% 的分布,不是二元**
- 与 [[2026-10-22-stale-instruction-files]] 互补:一个测"文件与代码冲突时听谁",一个测"文件里的话被听多少"
- 对 [[claude-md]] 的直接含义:**不要写条件句**("如果改了 X 就 Y")——改写成直接指令;跨模型共享一份文件时,写法无法同时最优

## 待办 / 后续

- 每种写法**只有一份文本**,风格与具体措辞/长度混淆(作者自承第一条威胁)——需要多文本重复才能把"风格"与"句子"分开
- 只测了一类策略(标记注释)与一种判定(全部函数都合规);真实规则(如"不许提交凭据")的遵守率可能不同
- 10 个仓库 → p 值偏乐观;复现包在 Zenodo(doi:10.5281/zenodo.23148524),未验
- 开放权重组合的天花板归因(模型 vs harness)是明确缺口;若属 harness(ACF 注入方式),则"换 harness 就能修"
