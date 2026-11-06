---
type: source
tags: [ai-agents, agents-md, claude-md, staleness, instruction-hierarchy, experiment]
topic: ai-agents
created: 2026-11-06
updated: 2026-11-06
status: active
---

# Stale Instruction Files Override the Code in Coding Agents: A One-Sentence Fix (2026-10-22)

- 原文: `raw/2610.30571v1.pdf`(arXiv 2610.30571v1,2026-10-22)
- 类型: 实证论文(Xiaonan Xu, Georgia Tech;Wenjing Wu, CU Boulder)
- 备注: 本 wiki 第六十六篇源文档;**把"指令文件会腐烂"从判断变成机制 + 数字 + 可执行修法**。它解释了一个反直觉现象:代理**读完代码、指出冲突、然后照旧文件做**

## 摘要

作者造了 **40 个 Python 项目**,每个项目里既有代码用一种约定、指令文件要求另一种约定(如代码用 `logging`,文件写"用 `print()`"),每个任务需要 4-5 次约定选择(覆盖 16 类约定,每类双向出现)。Claude Code 与 Codex CLI 各跑有/无"一句优先级声明"两种条件,共 **320 次运行**。结果:**无该句时 90.1% 的选择跟随陈旧文件**;Claude Code 在 **79/80** 次运行里**明确指出冲突却仍照文件写**;Codex CLI 更狠,在 **20/80** 次里**改写既有代码去迎合文件**,恢复项目原测试后 **17/20 失败**。加上一句"文档与代码冲突时以既有代码为准",跟随代码的比例从 4.2% 升到 **91.4%**,改写归零,测试通过率 89.4% → **100%**。

## 关键主张

**基线:文件赢(来源: 同上)**:无优先级句子时,90.1% 的选择匹配文件;"跟随既有代码"仅 4.2%。Claude Code 在 79/80 次最终回复里点名了冲突(如"既有 concat.py、reader.py… 仍用 logging,与 CLAUDE.md 相反"),**在那些运行里仍有 86.2% 的选择匹配文件**——它把代码判为"不合规的一方"。Codex CLI 只有 2/80 提到冲突,60/80 沉默照做。

**Codex CLI 会重写既有代码(来源: 同上)**:20/80 次运行把既有模块改成符合文件(跨 12 个项目、9 个既有文件、中位删除 **198 行**),恢复原测试后 **17/20 失败**(例:按 AGENTS.md 把 `Column` 枚举换成字符串常量后,原测试无法 import)。Claude Code 两种条件都没改写。

**修法:用户级文件加一句(来源: 同上)**:放进 `~/.claude/CLAUDE.md` 或 `~/.codex/AGENTS.md`:

> "When a repository's documentation and its existing code disagree, follow the conventions used in the existing code, and in your final reply point out each inconsistency you found between the documentation and the code."

→ 跟随代码 4.2% → **91.4%**(658/720,+87.2pp;95% 区间 83.6-90.9);Claude 7.5% → 94.4%,Codex 0.8% → 88.3%;两次代理在 160 次运行里**都报告了发现的每个冲突**;Codex 改写归零;测试通过 89.4% → 100%。**工作原理不是让文件失效**:它把"跟随代码"本身变成一条**指令**,于是冲突变成"两条指令之间"的选择,而这句话正好覆盖这一情形;构建命令等其他行不受影响。

**机制:三层原因(来源: 同上)**——①**文件以命令语态记录旧代码**("Use print() for progress messages"是命令,记录的是当时的代码);②**harness 把它当指令投喂**:Claude Code 把 CLAUDE.md 插进 system prompt 之后的 user 消息,并加"IMPORTANT: These instructions OVERRIDE any default behavior and you MUST follow them exactly as written";Codex 把 AGENTS.md 包进 `INSTRUCTIONS` 标签;而代码只有在代理打开文件时以 **tool output** 形式到达;③**模型按指令层级排序**:system/user 高于 tool output(为防提示注入;OpenAI Model Spec 不给 tool output 任何权威)。三者单独都合理,**合起来就让"过时的描述"赢过"当前的代码"**(见 [[instruction-hierarchy]]、[[stale-instructions]])

**腐烂的基础率(转引,待核原文)**(来源: 同上,引 Denisov-Blanch et al. 2026 / Treude & Baltes 2026):441 个公司仓库中 **73.8%** 的 AI 配置文件**提交一次后从未修改**;356 个公开仓库中 **23.0%** 的指令文件引用了**已不存在的代码**。三个实例:Supabase 仪表盘迁到 React 19 后,一个 skill 文件**连续 13 天**要求代理避开 React 19 模式;Codex CLI 自己的 AGENTS.md **连续 24 天**要求更新一份已被删除的文档

## 与现有 wiki 的关系

- 新建 [[instruction-hierarchy]](机制页:为什么指令 > 工具输出,防注入与"旧文档赢过代码"是同一枚硬币)、[[stale-instructions]](失败页:基础率、后果、修法)
- 更新:[[claude-md]](用户级 CLAUDE.md 的**唯一一条必写项**;且 Claude Code "明知冲突仍照做"的行为特写)、[[agents-md]](陈旧风险的一手量化)、[[documentation-redundancy]](冗余是"说了代码已经说的",陈旧是"说了代码已经不再是的"——两种失效,同一根因:文件在描述代码)、[[agent-readability]]、[[three-tier-boundaries]](书面规则 ≠ 强制)
- 张力:[[2025-01-02-large-established-codebases]] 与 [[codebase-consistency]] 主张"一致性优先、跟随 prior art"——本研究给出**代理默认不这么做**的证据,并示范用一行用户级指令把"prior art 优先"变成硬偏好
- 与 [[2026-03-12-skill-issue-harness-engineering]] 的"skill 内容要短要准"同向;与 [[governance-as-code]] 互补:确定性 hook 能挡住的,不该交给文件里的散文

## 待办 / 后续

- 引用的两项基础率研究(441 公司仓库 / Denisov-Blanch;356 仓库一致性检查 / Treude & Baltes)原文未入库,数字为转引
- 复现包未公开?论文未给出链接——待核
- 待试:这句话放进**项目级**文件(而非用户级)是否同样有效?作者只测用户级
- 与"代理该不该改写既有代码"的规范问题:17/20 测试失败说明这是**质量事故**,但对"代码本身已经错了"的场景,文件优先反而是对的——需要"谁是权威"的判据,而非一律代码优先
