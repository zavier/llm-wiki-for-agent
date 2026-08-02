---
type: source
tags: [ai-agents, agents-md, eth-zurich, evaluation, evidence]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents? (2026-02-12,ETH Zurich)

- 原文: 无 raw 文件(AI 直接抓取自 arXiv 2602.11988 摘要页/HTML v1/第三方总结,2026-08-02;arXiv API 确认 published **2026-02-12**,v2 更新 2026-06-23)
- 类型: 学术论文(Gloaguen, T.; Mündler, N.; Müller, M.; Raychev, V.; Vechev, M.——ETH Zurich + LogicStar.ai;[arXiv:2602.11988],cs.SE)
- 备注: 本 wiki 第三十六篇源文档;**agentfile 反证的一手来源**(此前 [[2026-03-12-skill-issue-harness-engineering|HumanLayer]] 与 [[2026-03-26-code-agent-orchestra|Osmani]] 两路转述"平均成功率 -3%/推理成本 +20%+";现一手论文入库,数字口径需协调)

## 摘要

仓库级上下文文件(AGENTS.md/CLAUDE.md)是代理开发商强烈鼓励的实践,但此前无严谨研究检验其真实效果。本论文在真实 GitHub issue 派生的任务上、多代理多模型设置下系统检验:SWE-bench Lite + 新颖的 AgentBench;三条件(NONE 基线 / LLM 自动生成 / HUMAN 开发者编写);四代理(Sonnet-4.5/GPT-5.2/GPT-5.1 M./Qwen3-30B)。**主结果:上下文文件不提升代理性能,还显著增加推理成本(+20%+)**;trace 分析:指令一般被遵循、导致更多测试与更广探索,但**不能充当有效的仓库概览**;结论:上下文文件只应包含代码库之外的具体附加指令。

## 关键主张

**数字口径协调**(重要):Osmani/HumanLayer 转述的"平均成功率 **-3%**" vs 一手数据——Medium 总结(v2 口径):SWE-bench Lite(LLM 生成文件)平均 **-0.5%**、AgentBench 平均 **-2%**;v1 HTML 表格显示部分模型微升(步骤数↑、成本↑↑);**-3% 与 -0.5%/-2% 同量级但非精确一致——聚合口径差异待核**(转述可能基于不同子集/版本)

**成本**:推理成本 **+20% 以上**(两路转述一致 ✓);原因:指令推动更多探索、更多测试、更多工具使用(步骤数显著上升,如 Sonnet-4.5 SWE-bench Lite 步骤 54.4→57.2、成本 1.30→1.51)

**机制发现(trace 分析)**:
- 指令一般被遵循——上下文文件确实改变代理行为(更守规)
- 但**不充当有效的仓库概览**——作为"地图"功能失败
- **文档冗余假说**:LLM 生成文件与既有文档高度冗余;人工移除全部文档后(上下文文件成为唯一文档来源),LLM 文件**一致提升 2.7% 平均**,且胜过开发者写的文档——上下文文件的价值 = 文档缺失时的替代品,而非附加信息
- 人为编写文件仍优于自动生成(表:HUMAN 行与 LLM 行接近但略稳)

**结论**:上下文文件不提升代理性能(部分场景微降);**应只包含代码库之外的具体附加指令**(specific additional instructions beyond what is already available);厂商推荐 vs 实证结果存在具体差距——呼吁"自动生成简洁、任务相关指导"的原则性方法

**局限**:特定基准(SWE-bench Lite/AgentBench)与特定代理(Claude Code/Codex/Qwen);结果可能随设置变化

## 与现有 wiki 的关系

- 更新 [[agents-md]](反证一手化 + 数字协调 + 机制细节), [[ai-feature-implementation-loop]] 反证区(agentfile 条目数字更新:统一为 -0.5%/-2% 一手口径 + 转述 -3% 差异标注), [[2026-03-12-skill-issue-harness-engineering|skill-issue source]] 与 [[2026-03-26-code-agent-orchestra|orchestra source]] 的 ETH 引用标注
- 互证:文档冗余假说 ↔ [[agents-md]] "prompt additive" 原则(条目应提供代码库之外的信息——论文结论与 Osmani 实践指南意外一致);"指令被遵循但概览失败" ↔ 手册四节结构中 Patterns/Gotchas 有效 vs 综述性描述无效;铁律"绝不让代理直接写 AGENTS.md"(综合页)获论文支持(LLM 文件 < HUMAN 文件)
- 与 [[2026-05-14-claude-code-large-codebases|Claude Code at scale]] 张力:官方强烈推荐配置评审 3-6 月——"配置有价值但需人写、短而精"是两边的折中

## 待办 / 后续

- v2 全文未完整抓取(HTML v1 可用,v2 无 HTML);精确聚合方式与 -3% 转述差异待全文核对
- 与"运行笔记本"(Ralph Loop 代理自写 AGENTS.md 条目)的张力:论文显示 LLM 生成文件价值最低——代理自写条目质量仍存疑(综合页反证区待核项,现获得部分回答:LLM 文件冗余/低效)
