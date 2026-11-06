---
type: concept
tags: [ai-agents, model-behavior, security, instruction-following]
topic: ai-agents
created: 2026-11-06
updated: 2026-11-06
refs: [stale-instructions, three-tier-boundaries, lethal-trifecta, agents-md, claude-md, agent-containment, curse-of-instructions]
sources: [2026-10-22-stale-instruction-files, 2026-11-03-policy-wording-compliance]
status: active
---

# 指令层级(Instruction Hierarchy)

模型对输入**来源**的权威排序:system > user/指令文件 > tool output(代码、命令输出、网页)。这不是提示技巧,而是训练出来的属性,初衷是**防提示注入**——让网页或文件里的"忽略之前的指令"不能改写代理行为。

## 关键信息

- **机制(来源: [[2026-10-22-stale-instruction-files]])**:OpenAI Model Spec 不给 tool output 任何自身权威;2026 年发布的一个训练数据集进一步强化了这一排序;编码代理在实践中同样表现出该排序(项目文件的规则 > 工具描述里的规则),只在**没有任何指令覆盖**时才依工具输出行动
- **投喂方式决定层级(来源: 同上)**:Claude Code 把 `CLAUDE.md` 插进 system prompt 之后的 **user 消息**,并显式声明"These instructions OVERRIDE any default behavior and you MUST follow them exactly as written";Codex CLI 把 `AGENTS.md` 包进 `INSTRUCTIONS` 标签。而**代码只在代理打开文件时以 tool output 到达** —— 同一份仓库,文件是"命令",代码只是"数据"
- **后果:陈旧的现在时凌驾于当前的实况**(来源: 同上):指示文件用命令语态记录旧代码("Use print() for progress messages"),代码变了句子没变 → 句子仍有指令权威,代码只有工具输出权威 → **90.1% 的选择跟随了过时文件**,Claude Code 在 79/80 次里**指出冲突后仍照文件执行**(见 [[stale-instructions]])
- **可反向利用(来源: 同上)**:在**用户级**文件里加一句"文档与既有代码冲突时以代码为准",就等于把"跟随代码"提升为一条指令,于是冲突变成**两条指令之间**的选择,而该句恰好覆盖这一情形 —— 跟随代码 4.2% → 91.4%,代价是代理会在最终回复里逐条报告冲突(应视为特性而非噪声)
- **与注入防御同源(双向)**:正因为指令 > 工具输出,注入防御才成立(见 [[lethal-trifecta]] 的外部内容通道);也正因为如此,任何"被权威化"的文本都值得审 —— 仓库里的 `.md`、skill 文件、乃至被读进来的依赖 README,都在指令层或接近指令层
- **遵守不是二元的(来源: [[2026-11-03-policy-wording-compliance]])**:即使在同一层级内,实际遵守率随**措辞**与**模型/框架**在 0–78% 间浮动(条件式最差,开放权重组合 ≤20%) → 层级解决"谁说话算数",不解决"说了会不会做"(见 [[curse-of-instructions]])

## 实践含义

1. **不要把代码的现状写进指令文件**。写进去的是"命令",代码一变就变成错的命令(见 [[documentation-redundancy]]、[[stale-instructions]])
2. **用户级文件放"元规则"**:冲突时以谁为准、如何报告冲突 —— 这类规则对所有项目成立,且不与项目内容一起腐烂
3. **需要绝对确定的约束,别指望层级**:层级只保证"优先级",不保证"执行";该硬的地方用 hook/权限(见 [[three-tier-boundaries]]、[[governance-as-code]])

## 待办 / 后续

- 只在一篇论文、两套 harness(Claude Code / Codex CLI)、一种冲突类型上验证;"用户级 vs 项目级"的层级差异未测
- 若厂商把"代码优先"写进产品默认(或是 Model Spec),整类失效会集体消失 —— 值得跟踪
- 与"tool output 不可信"的安全立场存在结构张力:安全上希望**更低**信任工具输出,工程上希望**更高**信任代码事实;二者需要按场景切换的机制,目前没有
