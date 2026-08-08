---
type: concept
tags: [context, prompt-engineering, ai-agents]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [curse-of-instructions, anthropic, ai-agent-spec, subagents, claude-md, agentic-memory, context-rot, progressive-disclosure, skills, long-running-agents, context-anxiety, harness-engineering, cursor, humanlayer, claude-code, pi-coding-agent, minimal-vs-rich-harness]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-best-practices-claude-code, 2026-08-02-effective-context-engineering-for-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2026-08-02-equipping-agents-with-agent-skills, 2025-10-06-file-system-is-the-new-database, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-04-19-agent-harness-engineering, 2026-04-30-cursor-agent-harness-improvement, 2026-03-12-skill-issue-harness-engineering, 2026-05-14-claude-code-large-codebases, 2025-11-30-opinionated-minimal-coding-agent]
status: active
---

# Context engineering

管理给 LLM 的上下文:在有限注意力预算下找到**最小的高信号 token 集合**;prompt engineering 的自然演进——从"写对提示"到"配置对的上下文状态"。

## 关键信息

**定义与动因**

- 定义(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):策展推理期间的最优 token 集——系统提示、工具、MCP、外部数据、消息历史;问题从"用什么词"变成"什么上下文配置最可能产生期望行为"
- 与 prompt engineering 的关系:自然演进,非替代;prompt 是一次性写作,context 是每轮推理都要重复策展的迭代过程
- 为什么重要:[[context-rot]](token 越多召回越差)+ 注意力预算(transformer n² 成对注意力、训练分布偏短序列、位置编码插值有损)→ "性能梯度而非硬悬崖",上下文必须当作**有限资源、边际收益递减**
- "context length 不是 context quality 的替代品"([[2026-01-13-good-spec-for-ai-agents|Osmani 指南]] 同调)

**组件(每轮策展的对象)**

- 系统提示:**正确高度**——介于"脆弱的硬编码逻辑"(脆弱、难维护)与"过度笼统/假想共享上下文"(无具体信号)之间;分节(XML 标签 / Markdown 标题);"minimal ≠ short";先拿最好模型测最小 prompt,按失败模式增量补充
- 工具:代理与信息/行动空间的契约;返回要 token 高效、鼓励高效行为;**最小可用工具集**——臃肿导致选择歧义("人类工程师都无法确定用哪个工具,代理更做不到");与 [[agent-computer-interface|ACI]] 同源;Claude Code 默认 25,000 token 响应上限;代理"上下文有限 vs 计算机内存廉价"的 affordance 差异(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]])
- 示例:精选多样化、典范性示例,而非罗列边界情况清单("example 是千言万语对应的图");与 [[curse-of-instructions]] 的缓解一致

**检索:agentic search**

- 范式转移:从"嵌入检索预加载"到 **just-in-time 上下文**——维护轻量标识(文件路径、存储查询、链接),运行时用工具动态加载;Claude Code 用 head/tail 分析大数据集,从不全量载入
- 镜像人类认知:外部索引(文件系统/书签)按需取回;元数据即信号(测试目录下的 `test_utils.py` vs `src/core_logic/`);**渐进式披露**——代理逐步探索,每次交互生成下个决策的上下文,只留必要部分在"工作记忆"
- 权衡:运行时探索慢于预计算;需精心设计工具与启发式,否则浪费上下文追死胡同
- **混合策略**:预加载 + JIT——[[claude-md|CLAUDE.md]] 前置注入,glob/grep 按需检索;适合内容不太动态的领域(法律/金融)
- **标准实现**:[[skills|Agent Skills]] 的三级披露(SKILL.md 元数据预载 → 正文按需 → 捆绑文件导航)是渐进式披露的直接工程化(见 [[progressive-disclosure]])

**长时任务三技术**(token 超窗口时;所有窗口大小都受污染影响)

- **上下文焦虑与 reset**(来源: [[2026-08-02-harness-design-for-long-running-apps]]):模型接近自己以为的上下文极限时提前收尾(见 [[context-anxiety]]);compaction 保留连续性但**不给干净起点**,焦虑可残留;reset(清空窗口 + 新代理 + 结构化交接)给干净起点,代价是交接工件质量 + 编排开销;模型代际差异大(Sonnet 4.5 必需 reset,Opus 4.5 后不再需要)

- **Compaction**:近满时总结重开——保留架构决策/未解决 bug/实现细节,丢弃冗余工具输出;调优:先最大化召回、再迭代提精度;最轻形态:工具结果清理(Claude 平台已发布)
- **Tool-call 输出卸载**(来源: [[2026-04-19-agent-harness-engineering]]):大工具输出(2,000 行日志)只保留头尾 token,全文落盘文件系统、按需读回——与 compaction 并列的上下文腐烂应对技术;Claude Code 的 head/tail 分析即其实例(见 [[harness-engineering]])
- **[[agentic-memory|结构化笔记]]**:窗口外持久化,按需拉回(Pokémon 例证)
- **子代理架构**:专职子代理干净上下文干活,只回 1-2k token 摘要(见 [[subagents]])
- 选择:compaction 适合来回对话流;笔记适合有里程碑的迭代开发;多代理适合并行探索的研究
- 会话级工具([[2026-08-02-best-practices-claude-code|Claude Code 实践]]):`/clear` 任务间重置、`/compact <指令>` 定向压缩、`/rewind` 部分压缩、`/btw` 侧问不进历史;自动压缩保留关键信息
- 长时对话管理(来源: [[2026-08-02-how-we-built-our-multi-agent-research-system]]):总结完成阶段 → 存外部记忆 → 新子代理接续,保持跨上下文连贯;子代理输出直写文件系统避免传话游戏(见 [[multi-agent-systems]])
- **多上下文窗口工作流**(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]],Claude 4 prompting guide):跨会话任务的关键教训——**compaction 不足以跨会话**("不总能传递清晰指令");harness 用"首个上下文窗口专用 prompt"(初始器代理)建环境 + 后续会话增量推进 + 会话起步仪式(pwd → git log + progress → 特征清单 → init.sh 冒烟),仪式省 token 且防错误叠加(见 [[long-running-agents]])
- **护栏→动态上下文演进**(来源: [[2026-04-30-cursor-agent-harness-improvement]],Cursor):2024 末的护栏(每改必喂 lint/类型错误、行数读太少就改写读取请求、限单轮工具数、静态上下文预载)在模型变强后**大多淡出**——保留少量静态上下文(OS/git 状态/当前文件),转向动态上下文(模型按需拉取:过往对话/终端会话/工具);"减少护栏、增加动态上下文"是 harness 随模型进化的直接例证(见 [[harness-engineering]])
- **指令预算与愚蠢区**(来源: [[2026-03-12-skill-issue-harness-engineering]],HumanLayer,引 Matt Pocock 概念):每一条工具描述/指令都消耗"指令预算",无关条目是无收益的负担——工具描述填满窗口就把代理推进"愚蠢区"(dumb zone);与 [[context-rot]] 的干扰项复合效应一致(低语义相似度时退化更陡);**长上下文怀疑论**:扩展上下文(如 YaRN)只是"把干草堆变大,不会让你更会找针"——窗口隔离(子代理)比更大的窗口更有效(见 [[subagents]])
- **检索架构对比:agentic search vs RAG 索引**(来源: [[2026-05-14-claude-code-large-codebases]],Anthropic 官方):Claude Code 像工程师一样遍历文件系统/grep/跟随引用(本地、无索引)——**agentic search**;RAG 类工具 embedding 整个代码库,**规模下失败模式是索引陈旧**(pipeline 追不上活跃团队:返回两周前改名的函数、上个 sprint 删掉的模块,且无过期提示);agentic 无索引维护成本,但**依赖起始上下文**(CLAUDE.md + skills 分层,否则十亿行代码库找模糊模式在开始前撞窗口);**LSP = 符号级检索**:grep 常见函数名 → 数千匹配烧上下文逐个开文件,LSP 只返回同一符号的引用——"过滤发生在模型读任何东西之前",多语言代码库最高价值投资之一(见 [[claude-code]])

**总原则**:找最小的高信号 token 集合;"do the simplest thing that works";模型越强,规定性工程越少

- **完全控制论**(来源: [[2025-11-30-opinionated-minimal-coding-agent]],[[pi-coding-agent]]):独立实践者的极端版——"Twitter 上全是上下文工程文章,但没有 harness 真的让你做它":主流工具背后注入内容且不在 UI 暴露;pi 的全部卖点 = 精确控制进模型的每个 token + 观测代理实际读了什么;极简系统提示+工具(<1000 tokens)是该哲学的实现手段("模型 RL 后天生懂编码代理")——与"最小高信号 token 集合"同向,与"rich harness"的配置传统对立(见 [[minimal-vs-rich-harness]]);无 compaction 单会话数百轮 = "不引入自动压缩"本身也是上下文控制策略(对照 [[context-anxiety]])
- 实践印证(来源: [[2025-10-06-file-system-is-the-new-database]]):独立实践者用三级披露 + 模块隔离做成 11 模块个人 OS("任何信息最多两跳");U 形注意力曲线 = "lost-in-middle",关键规则必须前置(1200 行声音指南改为关键规则前 100 行);模块边界即加载决策(拆一个模块省 40% token);格式-功能映射与追加式安全见 [[file-as-memory]]

## 与其他页面的关系

- 现象依据: [[context-rot]]、[[curse-of-instructions]]
- 技术: [[agentic-memory]]、[[subagents]]、[[claude-md]]、[[model-context-protocol]]
- 在 [[ai-agent-spec]] 中对应原则 3(模块化)的技术实现;方法来源: [[anthropic]]
