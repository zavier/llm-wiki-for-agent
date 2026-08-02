---
type: concept
tags: [ai-agents, reasoning, reflection]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agentic-systems, llm-as-a-judge, agent-verification, agent-teams, ralph-loop, addy-osmani]
sources: [2023-06-23-llm-powered-autonomous-agents, 2026-03-26-code-agent-orchestra]
status: active
---

# Self-reflection

自反思:代理对自身过去行动的自我批评与修正,从错误中学习以改进后续步骤——真实世界试错场景的关键能力;2023 年定型的四条技术路线至今影响所有"反思/评审"实践。

## 关键信息

**四条技术谱系**(来源: [[2023-06-23-llm-powered-autonomous-agents]])

- **ReAct**(Yao 2023):thought/action/observation 循环——推理轨迹与行动交错;知识密集与决策任务均优于 Act-only 基线;是"LLMs autonomously using tools in a loop"定义的 2023 原型
- **Reflexion**(Shinn 2023):RL 设置 + 二值奖励;启发式函数判断轨迹何时该停(低效=太久无成功;幻觉=连续相同动作产生相同观察);反思由(失败轨迹,理想反思)两样本对生成,注入工作记忆(最多 3 条)
- **Chain of Hindsight**(CoH,Liu 2023):监督微调——把带人类反馈的输出序列(按奖励排序)作为上下文,模型学"改进趋势"而非单点输出;随机掩码 0-5% 过去 token 防复制
- **Algorithm Distillation**(AD,Laskin 2023):跨 episode 学习历史拼接喂入,蒸馏出 in-context RL 算法本身(而非任务策略);2-4 episodes 上下文即可学近最优

**概念区分**

- 自反思 = 代理**反思自己的轨迹**(同主体);[[llm-as-a-judge]] / evaluator-optimizer = **独立主体**评审输出——两族实践互补:前者省成本、后者更客观
- 与生成式代理的"反思"不同:后者是对记忆的高层总结(见 [[agentic-memory]]),前者是针对失败的修正
- 现代形态:Claude Code 的自验证清单、Anthropic 的"让代理自省跑偏原因"(skills 迭代)、Research 系统的 CoT 评估——均为本谱系的后代
- **循环护栏强制反思**(来源: [[2026-03-26-code-agent-orchestra]]):多代理编排中每次重试前强制反思 prompt("什么失败了?什么具体改动能修?我在重复同一方法吗?")+ 硬 `MAX_ITERATIONS=8`——**大幅减少卡死代理**(无护栏则无限循环同一错误方法)——反思从"可选品质"变成"编排护栏"(见 [[agent-teams]]);REFLECTION.md 提案机制:每任务后强制写(什么让我意外/一条可加进 AGENTS.md 的模式/一条 prompt 改进),lead 审查合并 = 复合学习的系统化(见 [[ralph-loop]])

## 与其他页面的关系

- 框架: [[agentic-systems]];独立评审对照: [[llm-as-a-judge]];验证门禁: [[agent-verification]]
