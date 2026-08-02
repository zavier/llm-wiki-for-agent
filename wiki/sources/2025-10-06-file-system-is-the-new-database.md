---
type: source
tags: [context-engineering, ai-agents, file-system, memory]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# The File System Is the New Database: How I Built a Personal OS for AI Agents (2025-10-06)

- 原文: `raw/The File System Is the New Database_ How I Built a Personal OS for AI Agents.md`
- 类型: X 长推文/个人架构复盘(作者 [[muratcan-koylan]],Context Engineer @ Sully.ai;**frontmatter 标注 published 2025-10-06,但内嵌引文日期至 2026-02,成文时间存疑**;剪藏 2026-08-02)
- 备注: 本 wiki 首篇独立开发者视角的源文档(其余为 Osmani + Anthropic);原文含 10+ 张架构截图,正文文本已覆盖其内容

## 摘要

独立实践者的完整架构复盘:"Personal Brain OS"——一个住在 Git 仓库里的文件式个人操作系统(80+ 个 Markdown/YAML/JSONL 文件,零数据库零依赖)。核心:11 个隔离模块 + 三级渐进披露(任何信息最多两跳)+ 指令层级(CLAUDE.md→AGENT.md→模块文件)+ 文件系统记忆(格式-功能映射、情景记忆、跨模块引用)+ 遵循 Anthropic 标准的 Skills 双模式(自动注入/手动触发)+ 五条硬教训。一句话立场:**"这是 context engineering,不是 prompt engineering"**——从优化单次交互转向设计信息架构。

## 关键主张

- **核心问题是上下文而非提示**:注意力预算 + U 形注意力曲线("lost-in-middle");模块隔离——内容任务不见网络数据,会议准备不见内容模板
- **三级渐进披露**:L1 路由文件(SKILL.md,常载,告诉代理哪个模块相关)→ L2 模块指令(CONTENT.md/OPERATIONS.md/NETWORK.md,40-100 行)→ L3 数据(JSONL/YAML,最后按需);"任何信息最多两跳"
- **指令层级**:CLAUDE.md(仓库总图,所有 AI 工具先读)→ AGENT.md(7 条核心规则 + 决策表:请求→精确动作序列)→ 模块级指令文件;作用域化消除"指令冲突",单模块更新无回归
- **文件系统记忆**:无数据库/向量库;格式-功能映射——JSONL 日志(追加式=防覆盖、流式逐行读)、YAML 配置(层级+注释,人机可读)、Markdown 叙事(原生渲染+干净 diff);每个 JSONL 以 `_schema/_version/_description` 头行开始
- **情景记忆**:experiences/decisions/failures 三个追加日志,存"判断"而非仅事实(情感权重 1-10、推理、备选方案、根因与预防);failures 日志最值钱——"用真实痛苦换来的模式识别";决策日志让代理引用"你实际怎么想"(例:职业权衡框架 Learning > Impact > Revenue > Growth)
- **跨模块引用**:flat-file 关系模型(contact_id/pillar 映射),模块隔离加载、连接推理——"没有连接的隔离只是文件夹堆";会议简报由三文件链自动组装
- **Skills 双模式**(遵循 Anthropic 标准):参考型 `user-invocable: false` 静默自动注入(声音指南/反模式);任务型 `disable-model-invocation: true` 手动 /命令触发(/write-blog 一次装配 5 路上下文);skill 只引用不复制(单一事实源)
- **声音编码为结构化数据**:五维 1-10 量表 + 50+ 禁用词三层 + 结构陷阱 + "每段最多一个破折号";模板内置质量门与 4 遍编辑流程;自评清单
- **五条教训**:①schema 过度设计(15+ 字段→8-10,稀疏数据让代理乱填)②声音指南过长(1200 行→关键规则前置 100 行)③模块边界是加载决策(identity/brand 拆分省 40% token)④追加式不可妥协(代理重写 JSONL 丢 3 个月数据)⑤信息架构 > 提示技巧
- **反证引述**(二手,待核):Vercel 对 Next.js 16 的评测——**56% 案例中 skill 从未被调用**("LLM 本质上懒惰,渐进披露不可靠");NeurIPS 论文《LLM 生成的人格是带陷阱的承诺》

## 与现有 wiki 的关系

- 新建:[[muratcan-koylan]]、[[file-as-memory]]
- 更新了 [[context-engineering]](实践印证+格式映射)、[[agentic-memory]](情景记忆扩展)、[[progressive-disclosure]](实践印证 + Vercel 反证)、[[skills]](自动/手动双模式 + 触发率反证)、[[claude-md]](指令层级)、[[ai-feature-implementation-loop]](独立视角支持与反证)
- 与七篇前源互补:**提供了 Anhtropic 视角之外的反证**(skill 触发率)与扩展(情景记忆、格式-功能映射);无直接矛盾
- 元观察:本 wiki 自身就是"文件即知识库"架构的实例(index/log/topics/refs 均为文件)

## 待办 / 后续

- 核实成文时间(frontmatter 2025-10-06 vs 内嵌引文 2026-02);查 Vercel Next.js 16 skills 评测原文(56% 未调用)
- 找 NeurIPS"LLM 生成人格"论文原文;看 Agent-Skills-for-Context-Engineering 开源仓库(8,000+ stars)
- 其决策日志/情景记忆实践可作为本 wiki answers 页的参考形态
