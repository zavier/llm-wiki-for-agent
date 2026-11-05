---
type: concept
tags: [ai-agents, context, documentation]
topic: ai-agents
created: 2026-11-06
updated: 2026-11-06
refs: [agents-md, claude-md, context-engineering, agent-readability, curse-of-instructions, github, progressive-disclosure]
sources: [2026-02-12-evaluating-agents-md, 2026-02-11-codex-agent-first-engineering, 2026-06-05-intent-debt, 2026-05-14-claude-code-large-codebases]
status: active
---

# 文档冗余假说(Documentation Redundancy)

**主张**:LLM 自动生成的上下文文件(AGENTS.md/CLAUDE.md、`/init` 产物)与仓库里**已有的文档高度重叠**;它们的表观价值大多来自"给代理补上了缺失的文档",而不是"提供了额外信息"。推论:在文档齐全的仓库里,自动生成文件 ≈ 付费买一份代理本来就能自己发现的东西。

## 关键信息

- **原始证据(消融)**:ETH Zurich 把仓库内所有 `.md`、示例代码与 `docs/` 删除后重测(Claude Code 因成本排除)——LLM 生成上下文文件**一致提升 2.7%** 且**反超人写文件**(来源: [[2026-02-12-evaluating-agents-md]])。上下文文件是唯一文档来源时才有正收益 → 它此前的作用是**替代品**,不是补充
- **反常后果**:在文档齐全的 SWE-bench Lite / AGENTbench 上,LLM 生成文件平均 -0.5% / -2%,成本 +20% / +23%(同上)。**"有信息"不等于"有增量"**:多出来的 token 消耗注意力预算(见 [[context-engineering]]、[[curse-of-instructions]]),却没带来代理自己找不到的信息
- **失效形态**:文件里的"仓库概览/目录罗列"**不缩短**代理找到相关文件的步数——4 个模型中 95-100% 的生成文件都被判定含概览段,收益仍是零(同上);对照 [[agent-readability]]「上下文之外不存在」:概览是**代理能自行发现**的东西,写的价值接近 0
- **独立同向观察**:OpenAI 零人工代码实验列的四个败因——情境稀缺 / 指导过多反无效 / **立即腐烂(过时规则坟场)** / **难以核实(单 blob 无法机械检查新鲜度与交叉链接)**(来源: [[2026-02-11-codex-agent-first-engineering]]);四者都可归为"重复描述代码现状"的代价,其解是用 linter + CI 验证的结构化 docs/,而非一份会被抄写的长文
- **反例边界(重要)**:假说的成立条件是**冗余**。代码里看不出的东西——"我们不这么干因为…"、外部服务地址、必须用的工具链(uv/make 目标)、踩过的坑——**不是冗余**,人写它们时有 +4% 与更高的指令遵循(uv 使用率 1.6 次/实例 vs 未提及 <0.01)(来源: [[2026-02-12-evaluating-agents-md]])。这正与 [[intent-debt|意图账本]] 的分工一致:自动生成的描述"代码是什么",人写的承载"团队想什么"
- **组织侧推论**:若文件的价值只在补文档,则投资顺序应是 **README/docs 的完备性 → 少量外部约束**,而不是"每个仓库都跑一遍 /init";官方"配置评审 3-6 个月"的实践([[2026-05-14-claude-code-large-codebases]])在此读作**删冗余**的周期,而非"补写"的周期
- **未解**:假说只在 Python 冷门仓库与 4 个模型上验证;私有栈/冷门语言下参数知识覆盖不足,冗余度可能下降(作者自认的外部效度缺口);也未见"删文档后**人写**文件是否仍人写更强"的对照数据

## 与 wiki 其他部分的关系

- 落地页:[[agents-md]](条目纪律)、[[claude-md]](`/init` 产物 = 典型冗余物)
- 机制解释:[[context-engineering]] 的注意力预算、[[curse-of-instructions]] 的指令稀释
- 反面对照:[[agent-readability]] 的"给地图不给说明书"——地图**也是**代码能推断的,真正稀缺的是**约束与意图**
- 缓解手段:[[progressive-disclosure]](元数据预载、细节按需)——把"写下来"换成"必要时刻能查到"
