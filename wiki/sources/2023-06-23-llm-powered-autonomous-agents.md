---
type: source
tags: [ai-agents, planning, memory, tool-use]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# LLM Powered Autonomous Agents (2023-06-23)

- 原文: `raw/LLM Powered Autonomous Agents.md`
- 类型: 技术博客(Lilian Weng,Lil'Log;lilianweng.github.io;**发布于 2023-06-23**,frontmatter 已标注)
- 备注: 本 wiki 最早日期与唯一"学术综述式"源文档(2023 奠基文献,后文多篇实践文献的源头);原文含 10+ 张架构图,正文文本已覆盖其内容

## 摘要

LLM 代理的奠基性综述:提出三组件框架——**规划**(子目标分解 + 自反思)、**记忆**(感官/短期/长期,长期记忆 = 外部向量库 + MIPS 快速检索)、**工具使用**(外部 API)。逐项梳理技术谱系:CoT/ToT/LLM+P 规划;ReAct/Reflexion/Chain of Hindsight/Algorithm Distillation 反思;MRKL/TALM/Toolformer/HuggingGPT/API-Bank 工具;案例研究(ChemCrow、生成式代理、AutoGPT、GPT-Engineer);末尾列出三大挑战(有限上下文、长程规划、NL 接口可靠性)。

## 关键主张

- **三组件框架**(后文所有 agentic 文献的源头):LLM = 大脑;规划(分解+反思)+ 记忆(短期=上下文内学习,长期=外部向量库)+ 工具使用(模型权重缺失的外部信息/代码执行/专有源)
- **任务分解**:CoT("step by step",Wei 2022)为基;ToT(Yao 2023)每步多分支 + BFS/DFS 搜索;分解可由 LLM 提示/任务指令/人工输入完成;LLM+P(Liu 2023)把长程规划外包给经典规划器——PDDL 中间接口,限机器人与特定领域
- **自反思技术**(见 [[self-reflection]]):ReAct(thought/action/observation 循环)> Act-only 基线;**Reflexion**(启发式检测低效轨迹/幻觉,反射注入工作记忆);Chain of Hindsight(反馈序列微调);Algorithm Distillation(跨 episode 历史蒸馏成 in-context RL,2-4 episodes 学近最优)
- **记忆映射**:感官记忆≈输入嵌入;短期记忆≈上下文内学习(受窗口限制);长期记忆≈外部向量库;MIPS/ANN 算法:L SH/ANNOY/HNSW/FAISS/ScaNN(recall@10 对比见 ann-benchmarks)
- **工具使用谱系**:MRKL(LLM 路由到专家模块,2022——routing 的前身);TALM/Toolformer(微调学习调用 API);HuggingGPT(ChatGPT 规划 + HuggingFace 专家模型执行——orchestrator 前身);API-Bank(53 API、264 对话、三级工具能力基准)
- **案例**:ChemCrow(13 个化学专家工具)——**LLM 自评 GPT-4 ≈ ChemCrow,人类专家评审 ChemCrow 大幅领先**,说明 LLM 在深度专业领域"不知道自己的缺陷";Boiko 科学发现代理——11 个化学武器请求 36% 被接受,安全风险真实;生成式代理(25 个虚拟角色,记忆流 + 相关性/近因性/重要性检索 + 反思,涌现社交行为)
- **三大挑战**(2023 年状态):①有限上下文——向量库检索"表示能力不及全注意力"②长程规划——意外错误时难以调整计划,不如人类试错学习③NL 接口可靠性——格式错误与抗拒行为,AutoGPT"大量代码在解析输出格式"
- 定义呼应:ReAct 的 thought/action/observation 循环 = 后来 Willison 定义("LLMs autonomously using tools in a loop")的 2023 原型

## 与现有 wiki 的关系

- 新建:[[lilian-weng]]、[[self-reflection]]
- 更新了 [[agentic-memory]](生成式代理记忆流)、[[llm-as-a-judge]](ChemCrow 早期反证)、[[tool-evaluation]](API-Bank 谱系)、[[agentic-systems]](历史框架)、[[agentic-workflow-patterns]](MRKL/HuggingGPT 谱系)、[[ai-feature-implementation-loop]](奠基对照)
- 与八篇前源的关系:奠基 → 实践的关系,无矛盾;三大挑战中"有限上下文"已被 context engineering 系统性回应,"NL 接口可靠性"仍是开放问题(工具评测/验证闭环部分缓解)
- 值得注意的跨源对照:2023 的向量库长期记忆 vs 2025-26 的 [[file-as-memory]];生成式代理的重要性打分 ≈ Muratcan 的情感权重

## 待办 / 后续

- 跟进 ReAct/Reflexion/Generative Agents 原始论文,对照本综述摘要
- 找向量记忆 vs 文件记忆的对比数据(开放问题,两侧文献现已齐备)
- 验证 ChemCrow 评测结论的原始出处;LLM+P/PDDL 路线的后续进展
