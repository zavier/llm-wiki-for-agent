---
type: concept
tags: [ai-agents, configuration, knowledge]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, claude-md, anthropic, progressive-disclosure, model-context-protocol, muratcan-koylan, humanlayer, loop-engineering, addy-osmani, process-over-prose, anti-rationalization-tables]
sources: [2026-08-02-best-practices-claude-code, 2026-01-13-good-spec-for-ai-agents, 2026-08-02-equipping-agents-with-agent-skills, 2025-10-06-file-system-is-the-new-database, 2026-03-12-skill-issue-harness-engineering, 2026-05-14-claude-code-large-codebases, 2026-06-07-loop-engineering, 2026-05-03-agent-skills]
status: active
---

# Skills

可复用的领域知识/工作流/代码包:目录 + `SKILL.md`,代理按需发现与加载;把通用代理变成适配你需求的专用代理——"像给新员工写入职指南"。

## 关键信息

**解剖**(来源: [[2026-08-02-equipping-agents-with-agent-skills]])

- 结构:目录含 `SKILL.md`(YAML frontmatter 必需 `name` + `description`)+ 可选捆绑文件 + 可执行脚本;PDF skill 例——预写 Python 脚本提取表单字段,Claude 直接运行,不把脚本或 PDF 载入上下文
- **[[progressive-disclosure|渐进式披露]]三级**:①启动时仅把每个已装 skill 的 name/description 预载进 system prompt(够判断何时用)②相关时读取完整 SKILL.md ③捆绑文件(reference.md/forms.md)按需导航——可打包的上下文近乎无界
- 代码执行:确定性操作(排序、解析)交给脚本而非 token 生成——更便宜、可重复;代码既可是可执行工具也可是文档,要写明"运行"还是"读作参考"

**开发与评测**(来源: 同上)

- 从评测开始:在代表性任务上找能力缺口,增量补 skill
- 结构化扩展:SKILL.md 臃肿就拆分文件;互斥/少共用的上下文分路径省 token
- 从 Claude 视角:监控实际使用轨迹与过度依赖;name/description 决定是否触发,重点打磨
- 与 Claude 迭代:让 Claude 把成功路径与常见错误沉淀为 skill;跑偏时让它自省——发现它实际需要的上下文,而非预先猜测
- 安全:恶意 skill 可引入漏洞/数据外渗/意外动作;只装可信来源,审计代码依赖、捆绑资源、可疑网络连接
- **供应链实害**(来源: [[2026-03-12-skill-issue-harness-engineering]],HumanLayer):skill 注册表已被发现分发**数百个恶意 skill**(ClawHub 案例)——按 `npm install random-package` 的标准对待,skill 可在机器上执行任意代码;与 MCP prompt-injection 风险同类(见 [[harness-engineering]])
- **工具分发方式**:skill 不能直接捆绑 MCP/自定义工具——写成可执行文件/CLI/NPM 包随 skill 分发或指示安装;例:BrowserBase agent browser skills、Vercel agent-browser CLI 替代 Playwright MCP(来源: 同上)
- **激活机制**(来源: 同上):激活时 SKILL.md 以用户消息载入 + 告知目录;可捆绑多个 markdown 由主文件指示何时读哪份(多层披露)
- **Osmani 开源版:senior-engineer 脚手架**(来源: [[2026-05-03-agent-skills]],addyosmani/agent-skills,MIT,27K+ stars):20 个 skill 按 SDLC 六阶段组织(Define/Plan/Build/Verify/Review/Ship + `/code-simplify`,对应 `/spec`...`/ship` 七命令),元 skill 作路由器按阶段激活("工作流缩放到实际范围而非假定范围");**skill = 工作流不是参考文档**(过程胜过散文,见 [[process-over-prose]]);每个 skill 内置**反合理化表格**(借口→反驳,见 [[anti-rationalization-tables]])与**证据退出标准**(验证不可妥协);**范围纪律**("只碰叫你碰的东西",PR 可合并性的最大单一决定因素);Google DNA(Hyrum's Law/测试金字塔+Beyoncé Rule/DAMP over DRY/~100 行 PR+C-N-O-F 标签/Chesterton's Fence/主干开发/Shift Left+特性开关/代码即负债);**可移植性**:同一 SKILL.md 可入 .cursor/rules/、Gemini CLI、Codex、Aider、Windsurf、OpenCode——"写一次工作流,运行时来执行";**对长时代理更重要**("运行越长,资深脚手架越要强制执行而非建议");"代理是极其能干的初级工程师,对 diff 之外的工作没有直觉"

**生态**

- 支持面:Claude.ai、Claude Code、Claude Agent SDK、Developer Platform;**2025-12-18 发布为开放标准(agentskills.io)**——跨平台可移植
- 与 [[model-context-protocol|MCP]] 互补:skill 教涉及外部工具与软件的复杂工作流,MCP 连接外部工具
- 展望:代理自己创建/编辑/评测 skill,把行为模式编码为可复用能力
- 形态:`.claude/skills/<name>/SKILL.md`;工作流型 skill 用 `disable-model-invocation: true` 留给手动触发(来源: [[2026-08-02-best-practices-claude-code]])
- 与 [[claude-md|CLAUDE.md]] 分工:全局规则常驻 CLAUDE.md 每会话加载;领域知识/偶尔用的流程放 skills 按需加载;本 wiki 自身也采用同一模式(AGENTS.md + skills 目录)
- **自动/手动双模式**(来源: [[2025-10-06-file-system-is-the-new-database]]):参考型 skill(`user-invocable: false`)静默自动注入(声音指南/反模式,解决一致性问题);任务型 skill(`disable-model-invocation: true`)手动 /命令触发(/write-blog 一次装配 5 路上下文,解决精度问题);skill 只引用模块不复制内容(单一事实源)
- **触发率反证**(来源: 同上):Vercel 对 Next.js 16 的评测显示 **56% 案例中 skill 从未被调用**——触发是现实瓶颈,name/description 是触发开关(二手引述,待核);[[muratcan-koylan|作者]] 据此主张渐进披露不可靠
- **触发描述要平实**(来源: [[2026-06-07-loop-engineering]],Osmani):"tight boring description beats a clever one"——Codex/Claude Code 都按描述匹配隐式触发;对 56% 触发率问题的直接工程回应;循环语境下 skill = 意图的书面外化,没有它"循环每轮从零重新推导项目"(见 [[intent-debt]])
- **skill 是创作格式,plugin 是分发方式**(来源: 同上):跨仓库共享/捆绑多个 skill = 打成 plugin 发布;与"工具分发方式"互补(脚本/CLI 分发的是能力,plugin 分发的是整套配置)
- **路径限定**(来源: [[2026-05-14-claude-code-large-codebases]],Anthropic 官方):skill 可绑到特定路径——payments 团队把部署 skill 绑定到其目录,"别人在 monorepo 别处工作时永不自动加载"——渐进披露的空间维度,回应触发率担忧的工程解之一

## 与其他页面的关系

- 载体: [[claude-code]];分工: [[claude-md]];原理: [[progressive-disclosure]]
- 相关: [[subagents]]、[[model-context-protocol]];组织来源: [[anthropic]]
