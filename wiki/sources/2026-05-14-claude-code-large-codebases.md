---
type: source
tags: [ai-agents, claude-code, enterprise, large-codebases, anthropic]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# How Claude Code works in large codebases: Best practices and where to start (2026-05-14)

- 原文: `raw/How Claude Code works in large codebases_ Best practices and where to start.md`
- 类型: 官方技术博客(claude.com/blog,Anthropic Applied AI 团队,致谢 Alon Krifcher 等 8 人 + Zoox 反馈);**"Claude Code at scale" 系列首篇**(企业级大规模部署最佳实践)
- 发布时间: **2026-05-14(推断,待核实)**——frontmatter 标注 2001-05-14 明显笔误;Ken Huang 于 2026-05-20 据此文写作实现 checklist(Substack),HN 5 月末热帖(248 分,160 评论)佐证
- 备注: 本 wiki 第二十一篇源文档;Anthropic 官方首次系统化"企业规模 harness 组织与维护"实践;与 [[2026-05-08-ai-native-organization|阿里组织文章]] 形成厂商官方 vs 大厂内部的双视角

## 摘要

Claude Code 已跑在百万行 monorepo、数十年遗留系统、数十仓库分布式架构、数千开发者的组织里。本文给出规模下成功采用的通用模式:导航架构(agentic search 对比 RAG 索引)、harness 五扩展点 + LSP + 子代理、三个配置模式(可导航性 / 随模型进化维护 / 所有权),并附组件对照表与常见误区。

## 关键主张

**导航架构:agentic search vs RAG**

- Claude Code 像工程师一样导航:遍历文件系统、读文件、grep、跟随引用;本地运行,**无需构建/维护/上传代码索引**
- RAG 类工具在规模下会失败:**embedding pipeline 追不上活跃团队**——查索引时它反映的是数周/数天/数小时前的代码;返回两周前改名的函数、上个 sprint 删掉的模块,且**无任何过期提示**
- 权衡:agentic search 需要足够的**起始上下文**(CLAUDE.md + skills 分层)——"在十亿行代码库里找模糊模式,会在工作开始前撞上下文窗口";投入代码库设置(legibility)的团队结果更好

**harness 比模型更重要(官方表述)**:团队聚焦模型 benchmark,但"模型周围的生态——harness——决定表现的程度超过模型本身";五个扩展点**按序**构建(CLAUDE.md → hooks → skills → plugins → MCP,每层建立在前层之上),外加两个能力(LSP、子代理)

- **CLAUDE.md 先行**:root 总图 + 子目录局部约定,每会话自动读;保持普适性否则成为性能拖累
- **Hooks 使配置自改进**:stop hook 在上下文新鲜时反思会话、提议 CLAUDE.md 更新;start hook 按需动态加载团队上下文;lint/format 确定性执行("比依赖 Claude 记住指令更一致")
- **Skills 按需加载**(渐进披露);**可路径限定**——payments 团队把部署 skill 绑到其目录,别处永不自动加载
- **Plugins 分发"什么有效"**:捆绑 skills/hooks/MCP 配置为可安装包,新工程师 day-1 即获得与老手相同能力;托管市场分发组织级更新;案例:零售组织把 analytics 平台 skill 打包成 plugin 分发给业务分析师
- **LSP 集成**:给 Claude 与 IDE 相同的导航——符号级精度(go to definition、find all references、区分不同语言的同名函数);没有它 Claude 只能文本模式匹配,**会落到错误符号**;案例:某企业软件公司在 rollout 前全组织部署 LSP 使 C/C++ 导航可靠;"多语言代码库中最高价值投资之一"
- **MCP**:连接内部工具/数据;最成熟团队暴露**结构化搜索**为可调用工具
- **子代理:探索与编辑分离**——只读子代理映射子系统、发现写文件,主代理带完整图景编辑

**组件误区表**(精华):CLAUDE.md 误区 = 把可复用专家知识放进去(该放 skill);hooks 误区 = 用 prompt 做该自动跑的事;skills 误区 = 全部塞进 CLAUDE.md;plugins 误区 = 让好配置保持部落化(tribal);LSP 误区 = 以为自动配置;MCP 误区 = 基础没打好就建 MCP;子代理误区 = 同一会话里探索+编辑

**模式一:大规模可导航性**

- CLAUDE.md **精简分层**:root 只放指针与关键坑,"其余一切都会漂成噪声";子目录文件放局部约定;Claude 在代码库中移动时**累加加载**
- **在子目录初始化**(而非 repo root):Claude 自动向上走并加载沿途 CLAUDE.md,root 上下文不丢(monorepo 中反直觉但有效)
- **按子目录限定 test/lint 命令**:改一个服务跑全量套件 = 超时 + 无关输出浪费上下文;编译型 monorepo 深跨目录依赖时难做到,需项目特定构建配置
- `.ignore` 文件排除生成物/构建产物/三方代码;`.claude/settings.json` 里版本控制的 `permissions.deny`——全团队一致降噪;代码生成器开发者可本地覆盖
- **代码库地图**:root 放轻量 markdown 列出各顶层文件夹一行描述 = Claude 可先扫的目录;数百顶层文件夹用分层(地图只描述最高层,子目录 CLAUDE.md 提供下一层);简单情况 @-mention 即可
- **LSP 符号搜索**:grep 常见函数名 → 数千匹配,Claude 烧上下文逐个开文件;LSP 只返回同一符号的引用——**过滤发生在 Claude 读任何东西之前**
- 边界情况:几十万文件夹/百万文件、非 git 版本控制 → 后续系列文章;遗留系统见 COBOL 现代化文(外部引用)

**模式二:随模型进化主动维护**——为当前模型写的指令会反噬未来模型:补偿旧模型缺陷的规则/工具在新模型下变成开销甚至约束(例:强制"每个重构拆成单文件改动"阻止新模型做协调的跨文件编辑;p4 edit hook 在 Claude Code 原生 Perforce 模式后冗余);**有意义的配置评审每 3-6 个月一次**,重大模型发布后性能感觉平台期也值得做

**模式三:所有权与治理**——采用最快的 rollout 都有**先基础设施投资后开放**的共同点(小团队甚至一人先接线,开发者第一次接触就 productive 而非 frustrating);角色:**agent manager**(混合 PM/工程师,专职管理 Claude Code 生态,新兴角色)与最小可行 **DRI**(一人拥有配置/权限策略/插件市场/CLAUDE.md 约定并保持更新);**bottoms-up 采用会碎片化**——没有个人/团队组装并布道约定(标准 CLAUDE.md 层级、精选 skills/plugins),知识保持部落化、采用平台期;受监管行业治理问题提前出现(谁控制可用 skills/plugins、防止数千工程师各自重建同一东西、AI 代码走与人类代码相同的评审流程);建议:批准 skills 清单 + 强制代码评审 + 限量初始访问,信心增长后扩大;早期建立**跨职能工作组**(工程 + 信息安全 + 治理)

非传统设置(游戏引擎二进制资产、非 git VCS、非工程师贡献者)需额外配置;本文假设常规设置。

## 与现有 wiki 的关系

- 更新了 [[claude-code]](企业规模模式)、[[harness-engineering]](官方背书 + 维护节奏)、[[context-engineering]](RAG vs agentic + LSP)、[[subagents]](探索编辑分离)、[[claude-md]](分层 + 进化维护)、[[skills]](路径限定)、[[management-collapse]](agent manager/DRI ↔ Architect)、[[ai-feature-implementation-loop]](组织层扩充)
- 关键互证:"harness 决定表现超过模型本身" = Anthropic 官方版的 HumanLayer "skill issue" 与 Osmani harness 论;"配置评审 3-6 个月" 首次给 harness 过时问题一个节奏答案(与 [[cursor]] 护栏过时、Anthropic 逐组件移除方法论互证);RAG 索引陈旧失败模式 = [[file-as-memory]]"索引 vs 文件系统"论证的官方例证;agent manager/DRI ↔ [[management-collapse]] 的 Architect(阿里"设计教 AI 怎么工作的人"的 Anthropic 企业落地名);plugin 分发防部落化 ↔ [[distillation-anxiety]] 知识藏匿的组织解药;路径限定 skills = [[progressive-disclosure]] 的空间维度
- 外链发现:Ken Huang([[2026-05-08-ai-native-organization]] 引用的 Execution Graph/三柱作者)2026-05-20 据此文写实现 checklist——同一话语圈的直接证据;Anthropic 另文《How Anthropic runs large-scale code migrations with Claude Code》(ai-code-migration)可作后续源

## 待办 / 后续

- 核实发布日(推断 2026-05-14);系列后续文章(边界情况/非 git VCS)
- LSP 部署收益数据(无量化);RAG vs agentic search 的适用边界(索引类工具何时更好);配置评审 3-6 月节奏在实践中的验证
