---
type: source
tags: [ai-agents, skills, knowledge]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Equipping agents for the real world with Agent Skills (2026-08-02)

- 原文: `raw/Equipping agents for the real world with Agent Skills.md`
- 类型: Anthropic 工程博客(作者 Barry Zhang、Keith Lazuka、Mahesh Murag;**原始发布日期未标注,文内标注 2025-12-18 更新——Skills 发布为开放标准 agentskills.io**;按剪藏日期归档)
- 备注: Agent Skills 的官方定义文;原文含 5 张示意图(SKILL.md 结构、上下文触发序列、代码执行、披露层级),正文文本已覆盖其内容

## 摘要

Agent Skills 的设计原理与开发指南:skill = 目录 + `SKILL.md`(必需 name/description frontmatter)+ 可选捆绑文件与脚本;核心设计原则是三级[[progressive-disclosure|渐进式披露]]。给出开发评测四准则、安全审计建议、生态现状(2025-12-18 开放标准)与展望(代理自建 skill)。

## 关键主张

- **定义**:skill 是"组织化的指令、脚本与资源文件夹,代理可发现并动态加载"——把通用代理变成适配你需求的专用代理;类比"给新员工写入职指南"
- **三级渐进式披露**:①启动时仅把每个已装 skill 的 name/description 预载进 system prompt(足够判断何时用)②相关时读取完整 SKILL.md ③捆绑文件(reference.md/forms.md 等)按需导航——"有文件系统与代码执行能力的代理不必全量载入",可打包上下文近乎无界
- **代码执行**:skill 可带脚本供 Claude 按需运行(PDF skill 的 Python 脚本提取表单字段,不载入脚本或 PDF 进上下文);确定性操作交给代码——更便宜、可重复
- **开发四准则**:①从评测开始(找能力缺口,增量补)②结构化扩展(SKILL.md 臃肿就拆分;互斥上下文分路径省 token;写明脚本是"运行"还是"读作参考")③从 Claude 视角监控(观察轨迹与过度依赖;name/description 决定触发,重点打磨)④与 Claude 迭代(让 Claude 把成功路径与常见错误沉淀为 skill;跑偏时让它自省)
- **安全**:恶意 skill 可引入漏洞、数据外渗、意外动作;只装可信来源,审计代码依赖、捆绑资源、可疑网络连接
- **生态**:支持 Claude.ai、Claude Code、Claude Agent SDK、Developer Platform;**2025-12-18 发布为开放标准(agentskills.io)跨平台可移植**;与 [[model-context-protocol|MCP]] 互补(skill 教复杂工作流,MCP 连外部工具)
- **展望**:代理自己创建/编辑/评测 skill,把行为模式编码为可复用能力

## 与现有 wiki 的关系

- **重构了 [[skills]]**(此前基于 Claude Code 文档的浅层内容,本篇是领域定义级来源)
- 新建:[[progressive-disclosure]](三源印证:本篇三级结构 + context engineering 的 JIT + Osmani 的扩展 TOC)
- 更新了 [[context-engineering]]、[[model-context-protocol]](与 MCP 互补)、[[anthropic]](开放标准)、[[ai-feature-implementation-loop]](反馈层 skill 沉淀)
- 与六篇前源互补无矛盾;与 [[claude-md]] 的分工论述一致

## 待办 / 后续

- 核实原始发布日期(约 2025-10 Agent Skills 发布时)
- 跟踪 agentskills.io 开放标准生态进展、代理自治创建 skill 的进展
- 对照 PDF skill 开源实现(GitHub anthropics/skills)验证三级披露写法
