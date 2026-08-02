---
type: concept
tags: [ai-agents, configuration, persistent-context]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, agents-md, skills, context-engineering, file-as-memory, harness-engineering]
sources: [2026-08-02-best-practices-claude-code, 2026-08-02-effective-context-engineering-for-ai-agents, 2025-10-06-file-system-is-the-new-database, 2026-05-14-claude-code-large-codebases]
status: active
---

# CLAUDE.md

Claude Code 的持久上下文文件:每次会话启动时自动读取,承载代码本身推断不出的项目约定;本质是"给代理的仓库内规则文件"。

## 关键信息

- `/init` 自动生成初稿(分析构建系统、测试框架、代码模式),再人工打磨(来源: [[2026-08-02-best-practices-claude-code]])
- 取舍原则:只放"删掉会导致 Claude 犯错"的行。✅ 包括:Bash 命令、异于默认的风格规则、测试指令与 runner、仓库礼仪(分支/PR 约定)、架构决策、环境怪癖、gotchas。❌ 排除:读代码能看出来的事、标准语言约定、API 文档(给链接)、频繁变化的信息、逐文件描述、自明实践("写干净代码")
- **过长 = 被忽略**:规则淹没在噪声里时 Claude 会无视。症状诊断:有规则仍重复犯错 → 文件太长;反复问已答问题 → 措辞含糊
- 强调词("IMPORTANT"/"YOU MUST")可提升遵循度
- 支持 `@path/to/import` 导入其他文件(README、git 指令、个人覆盖)
- 放置层级:home(`~/.claude/CLAUDE.md`,全局)/ 项目根(入库共享)/ `CLAUDE.local.md`(个人,gitingore)/ 父目录(monorepo 自动合并)/ 子目录(按需加载)
- 与 [[skills]] 分工:CLAUDE.md 每次会话全量加载,只放普适规则;领域知识放 skills 按需加载
- 混合策略角色(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):CLAUDE.md 前置注入 + glob/grep 按需检索——Claude Code 混合上下文策略(预加载 + just-in-time)的前半;避免陈旧索引与复杂语法树问题(见 [[context-engineering]])
- **指令层级扩展**(来源: [[2025-10-06-file-system-is-the-new-database]]):仓库级 CLAUDE.md(总图,所有 AI 工具先读)→ AGENT.md(核心规则 + 决策表:请求→精确动作序列)→ 模块级指令文件(领域规则);作用域化消除"指令冲突"(单一 system prompt 里规则互相打架),单模块更新无回归;个人 OS 形态见 [[file-as-memory]]
- 像代码一样对待:定期剪枝、用"行为是否真的改变"验证改动、入库让团队贡献
- 与 [[agents-md]] 同构:都是"给代理的仓库内规则文件"——Anthropic 与 GitHub 生态的对应物
- **大规模分层加载**(来源: [[2026-05-14-claude-code-large-codebases]],Anthropic 官方):root 文件放"指针与关键坑","**其余一切都会漂成噪声**";子目录文件放局部约定,Claude 在树中移动时**累加加载**;在**子目录初始化**(Claude 自动向上走加载沿途 CLAUDE.md,root 上下文不丢);**按子目录限定 test/lint 命令**(改一个服务跑全量套件 = 超时 + 无关输出浪费上下文,编译型 monorepo 深跨目录依赖时难做到);`.ignore` 排除生成物/构建产物 + 版本控制的 `permissions.deny`(`.claude/settings.json` 入库,全团队一致降噪,代码生成器开发者可本地覆盖);代码库地图(顶层文件夹一行描述 = 可先扫的目录,数百顶层文件夹用分层地图)
- **随模型进化维护**:为当前模型写的规则可能反噬未来模型——补偿旧模型缺陷的指令(如"每个重构拆成单文件改动")在新模型下变成约束(它现在能协调跨文件编辑);hooks 同理(强制 p4 edit 的 hook 在原生 Perforce 模式后冗余);**配置评审每 3-6 个月一次**,重大模型发布后性能平台期也做(来源: 同上)

## 与其他页面的关系

- 工具: [[claude-code]];对照: [[agents-md]];互补: [[skills]]
- 过长导致遵循度下降 → [[curse-of-instructions]] 的配置文件形态
