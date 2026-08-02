---
type: concept
tags: [context, ai-agents, design-pattern]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [context-engineering, skills, ai-agent-spec, file-as-memory, agents-md, agent-readability]
sources: [2026-08-02-equipping-agents-with-agent-skills, 2026-08-02-effective-context-engineering-for-ai-agents, 2026-01-13-good-spec-for-ai-agents, 2025-10-06-file-system-is-the-new-database, 2026-02-11-codex-agent-first-engineering]
status: active
---

# Progressive disclosure

渐进式披露:只把"判断是否需要更多信息"所需的最小元数据放进上下文,细节按需加载——多个独立来源反复涌现的上下文设计核心原则,形如"目录 → 章节 → 附录"。

## 关键信息

- 定义与命名(来源: [[2026-08-02-equipping-agents-with-agent-skills]]):像结构良好的手册——先目录、再章节、后附录;代理有文件系统与代码执行工具时,可打包的上下文近乎无界
- Skills 的三级实现:①启动预载 name/description(够判断何时用)②相关时载入完整 SKILL.md ③捆绑文件(reference.md/forms.md)按需导航(见 [[skills]])
- 独立印证 1(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):just-in-time 检索——代理维护轻量标识(文件路径/存储查询/链接),运行时用工具动态加载;**元数据即信号**(文件命名/目录结构/时间戳);代理逐层组装理解,只留必要部分在"工作记忆"
- 独立印证 2(来源: [[2026-01-13-good-spec-for-ai-agents|Osmani 指南]]):扩展 TOC/分层摘要——spec 每节压成 1-2 句 + 引用标签留在 prompt 当"心理地图",细节按需喂入
- 权衡:运行时探索慢于预计算;需精心设计的工具与启发式,否则代理浪费上下文追死胡同
- 实践印证(来源: [[2025-10-06-file-system-is-the-new-database]]):11 模块个人 OS 的三级披露——路由 SKILL.md 常载 → 模块指令 → 数据文件,"任何信息最多两跳";模块边界即加载决策(identity/brand 拆分省 40% token)
- **反证**(来源: 同上,引 Vercel 对 Next.js 16 的评测):**56% 评测案例中 skill 从未被调用**——"LLM 本质上懒惰,渐进披露不可靠"(二手引述,待核);触发机制(name/description 质量)比披露结构本身更关键;结构再好,模型不触发就白搭
- **仓库知识库实例**(来源: [[2026-02-11-codex-agent-first-engineering]],OpenAI 零人工代码实验):AGENTS.md 作内容目录(~100 行)→ 结构化 docs/(design-docs/exec-plans/product-specs/references)→ 具体引用(llms.txt)——"给智能体一张地图,而不是一本 1,000 页的说明书";**用机械手段强制执行披露结构**:linter + CI 验证知识库新鲜度/交叉链接/结构,doc-gardening 代理扫过时文档开修复 PR——披露不再是建议而是不变量(见 [[agent-readability]])
- 是 [[context-engineering]] "最小高信号 token 集合"的具体实现策略之一

## 与其他页面的关系

- 标准实现: [[skills]];理论框架: [[context-engineering]];spec 形态: [[ai-agent-spec]]
