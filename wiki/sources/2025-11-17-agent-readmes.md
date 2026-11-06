---
type: source
tags: [ai-agents, agents-md, claude-md, empirical-study, content-analysis, maintenance]
topic: ai-agents
created: 2026-11-06
updated: 2026-11-06
status: active
---

# Agent READMEs: An Empirical Study of Context Files for Agentic Coding (2025-11-17 / v2 2026-08-09)

- 原文: `raw/2511.12884v2.pdf`(arXiv 2511.12884v2,2026-08-09;v1 2025-11-17;TOSEM 已接收 2026-09)
- 类型: 大规模实证/内容分析(Chatlatanagulchai, Kasetsart + NAIST;Li, Kashiwa, Reid, Thonglek, Leelaprute, Rungsawang, Manaskasemsak, Adams, Hassan, Iida —— Kasetsart/NAIST/Queen's)
- 备注: 本 wiki 第六十八篇源文档;**整个上下文文件文献的"底数普查"**(2,303 份文件)。它是 [[2026-02-12-evaluating-agents-md|ETH]]、[[2026-01-28-agents-md-efficiency|Lulla]]、[[2026-11-03-policy-wording-compliance|Tsuchida]] 三篇的共同背景引用

## 摘要

首个大规模普查:**2,303 份 agent 上下文文件 / 1,925 个仓库**,覆盖 Claude Code(`CLAUDE.md`)、Codex(`AGENTS.md`)、Copilot(`copilot-instructions.md`)。三个发现:①这些文件**不是静态文档**,而是"像配置代码一样**频繁小步增补**、只增不减"的工件;②内容高度偏向**功能性**(测试 75.9%、实现细节 70.8%、架构 68.1%),而**非功能约束严重缺失**(安全 14.8%、性能 14.5%);③可读性差——中位 FRE 复杂度落在"difficult"档,且**机器可读性指标与人工判断几乎不相关**(ρ=0.19),说明这类文体不适合直接用 FRE 衡量。

## 关键主张

**RQ1 形态(来源: 同上)**:中位词数 —— Copilot **535.0**、Claude Code **485.0**、Codex **335.5**(Codex 显著更短);FRE 可读性 —— Claude Code 中位 42.39、Copilot 44.39(均属"difficult"),Codex 最易读;结构高度一致:**单一顶级 H1**(中位 1.0)、H2 中位 6-7 个;H3 层级 Copilot 12.0 / Claude 11.0 显著多于 Codex 9.0;H4 以下少见。**方法学警告**:FRE 与人判相关仅 ρ=0.19(p=0.05),因为命令行/代码 token 被当成短词、虚高分数——**不要用通用可读性指标评价这类文件**。

**RQ2 维护(来源: 同上)**:共 5,655(Claude)/2,767(Codex)/2,237(Copilot)次提交涉及这些文件;**Claude Code 67.0%** 的文件被多次修改(Copilot 59.8%、Codex 59.4%);相邻提交中位间隔 **22.3h(Codex)/23.8h(Claude)/68.0h(Copilot)**——是"按天"而不是"同一次会话里反复试 prompt",作者据此认为这是**随项目演进增补**而非调试式修补;100 个抽检提交里 **92%** 含实质性指令编辑(增/改/删),纯格式维护仅 8%;**增多于删**(文件在长)。

**RQ3 内容(16 类占比,%)**(来源: 同上):测试 75.9、实现细节 70.8、架构 68.1、开发流程 65.1、构建与运行 63.0、系统概览 59.0、维护 44.6、配置与环境 38.9、文档与引用 26.8、调试 25.3、AI 集成 24.1、DevOps 18.4、**安全 14.8**、**性能 14.5**、UI/UX 8.7、项目管理 5.4。作者解读:开发者用这些文件让代理**能干活**,几乎不设**非功能红线**——"约每七份文件才有一份提到安全"。

**RQ4 自动分类(来源: 同上)**:用 GPT-5 按 16 类自动打标,部分类别可靠(System Overview P0.88/R0.90/F0.87、Build & Run F0.92、Testing F0.94、Implementation Details F0.89),部分很差(**AI Integration P0.33/F0.57**、Configuration & Environment F0.75)——可作为"规模化追踪"的工具雏形,但按类比 F1 差异大,不能当作全自动可靠。

**版本漂移(引用时必看)**:v1(2025-11-17)与 v2(2026-08-09)在 16 个百分比中有 **11 个不同**(语料未变,分类口径调整)。例:测试 75.0→75.9、实现细节 69.9→70.8、架构 67.7→68.1、安全 14.5→14.8。**v1 摘要举的例子是"build and run 62.3%",v2 换成"test procedures 75.9%"** —— 若某处引 62.3%,是在引九个月前的版本。

## 与现有 wiki 的关系

- 为 [[agents-md]] 提供**生态底数**:典型文件写什么、多长、多久改一次
- **与 [[2026-10-22-stale-instruction-files]] 的表面矛盾(重要)**:本研究说文件被**主动维护**(Claude 67% 多次修改、中位间隔约 1 天);陈旧研究引用的公司仓库数据说 **73.8% 提交一次后从未修改**。两者人群不同(活跃公开 OSS vs 441 个公司仓库),不能直接对撞——已记入 [[stale-instructions]] 与 [[context-files-evidence]] 的开放问题
- 为 [[documentation-redundancy]] 提供**内容侧证据**:测试/实现/架构占前三 = 大部分是"代码里已有的东西";而真正稀缺的安全/性能只占 14-15% → 与"只写代码看不出的约束"的建议正好错位
- 与 [[2026-11-03-policy-wording-compliance]] 互证:文件里"测试怎么跑"最常写(75.9%),而遵守率研究显示**写法决定能不能被听见**——写得多 ≠ 被遵守
- 数据集/复现包:GitHub + HuggingFace(`hao-li/AIDev` 等衍生数据集被引用)

## 待办 / 后续

- v1→v2 的 11 处漂移已在上文给样;若 wiki 里其他页面引用了 v1 数字(如 62.3%),需按 v2 统一
- 它是**观察性研究,不做代理实验**——不能用来论证"有效/无效",只能论证"写了什么"
- 开放:安全/性能只有 14-15% 的成因(工具缺?意识缺?)未查;非功能红线的缺失与 [[governance-as-code]] 的"该进 hook"形成直接张力
