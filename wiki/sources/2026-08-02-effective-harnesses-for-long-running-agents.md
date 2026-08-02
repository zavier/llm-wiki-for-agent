---
type: source
tags: [ai-agents, long-running, harness, memory]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Effective harnesses for long-running agents (2026-08-02)

- 原文: `raw/Effective harnesses for long-running agents.md`
- 类型: Anthropic 工程博客(作者 Justin Young,Claude Agent SDK 团队;致谢含代码 RL 与 Claude Code 团队)
- 发布日: frontmatter `published` 为空,**待核实**(正文提及 Opus 4.5 与 Claude 4 prompting guide,推定 2025 底-2026);文件命名取剪藏日 2026-08-02
- 备注: 本 wiki 第十篇源文档;讨论跨上下文窗口的**长时运行代理**(harness 层),与"如何让 AI 更好地实现功能"直接相关

## 摘要

解决长时任务的核心难题:代理在**离散会话**中工作,每次新会话开始时没有任何先前记忆("软件项目换班制,每个新工程师不记得上一班发生了什么")。指出 compaction 不足以跨会话——Opus 4.5 跑 Claude Agent SDK 循环,只给高层提示("build a clone of claude.ai")仍建不出生产级 web app。提出两件套方案:**initializer agent**(首个会话建环境)+ **coding agent**(每个后续会话做增量推进并留下清晰工件)。

## 关键主张

- **问题分解**:跨会话记忆缺失;失败表现为两个模式——①**一次性做完**(one-shot):试图一口气实现整个 app → 中途上下文耗尽 → 下一会话从"半实现、无文档"起步,靠猜 + 花大量时间恢复基本功能(compaction 也不总能传递清晰指令);②**提前宣布完成**:后续会话看到已有进展就宣布项目完成
- **两件套方案**:①初始器代理:首个会话用专门 prompt 建环境——`init.sh` 脚本、`claude-progress.txt` 进度日志、初始 git commit;②编码代理:每个后续会话做增量推进 + 结构化更新(注:两者系统提示/工具/harness 完全相同,仅初始 prompt 不同)
- **feature list(核心创意)**:初始器把用户需求展开成**结构化 JSON 特征清单**(claude.ai 克隆例 = 200+ 条端到端特征,如"新建聊天按钮创建新对话"),每条含 category/description/steps,**初始全部标记 `passes: false`**;编码代理只允许改 passes 字段;强措辞指令("It is unacceptable to remove or edit tests")防删改;选 JSON 而非 Markdown 因为**模型更不易改写 JSON 文件**
- **增量纪律**:一次只做一个特征(解决"一次做太多");会话结束必须留干净状态——git commit(描述性消息)+ 进度文件更新;git 可回退坏改动、恢复可用状态
- **测试(最后的大失败模式)**:不做显式提示时,Claude 会改代码、甚至跑单测/curl,但**识别不出端到端不工作**;显式提示用浏览器自动化工具(Puppeteer MCP)、"像人类用户一样测试"后大幅提升——能发现代码本身看不出的 bug;残余限制:vision 与浏览器自动化看不到原生 alert 模态框
- **会话起步仪式**(省 token + 防错误叠加):①`pwd` 确认工作目录 ②读 git log + progress 文件 ③读特征清单选最高优先级未完成特征;初始器写 init.sh 并跑通基本端到端测试,之后每个会话先起开发服务器 + 冒烟测试,确认没被留在损坏状态再动手
- **失败模式表**(四行):提前宣布项目完成 / 环境带 bug 无文档 / 特征未测就标完成 / 花时间搞清怎么运行 → 各自对应初始器与编码代理的解法
- **开放问题**:单通用编码代理 vs 多代理架构(测试代理/QA 代理/清理代理做子任务是否更好)未定;demo 针对全栈 web app,向科研/金融建模等长时任务泛化待验证

## 与现有 wiki 的关系

- 新建概念: [[long-running-agents]](跨会话 harness 模式)
- 更新了 [[agentic-memory]]、[[file-as-memory]](progress 文件 + git 作为跨会话记忆的新实例)、[[conformance-testing]](feature list = 可执行一致性清单)、[[agent-verification]](浏览器自动化验证)、[[context-engineering]](compaction 不足 + 多上下文窗口工作流)、[[ai-feature-implementation-loop]](长时任务失败模式表)
- 与既有无矛盾;补充了三个既有开放问题的实证侧面:compaction 局限(上下文工程)、单 vs 多代理(编码类长时任务)、文件作为记忆载体
- 跨源呼应:feature list 的 passes 门禁 ≈ Osmani 的 conformance checklists + Willison 的一致性测试;progress 文件 + git 历史 ≈ [[file-as-memory]] 的实例化;一次一个特征 ≈ 单代理增量推进(与多代理 +90.2% 的对照)

## 待办 / 后续

- 核实发布日与 Claude Agent SDK 版本;跟进 quickstart 代码示例(anthropics/claude-quickstarts 的 autonomous-coding)
- 跟进"单代理 vs 多专用代理"长时任务对比(开放问题,与 [[multi-agent-systems]] 研究类数据互补)
- 跨会话记忆载体(进度文件+git vs 向量库 vs 笔记)的对比数据仍缺
