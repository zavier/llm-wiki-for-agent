---
type: source
tags: [ai-agents, openai, codex, sdlc, team]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Building an AI-native engineering team (OpenAI 官方指南,发布日待核实)

- 原文: `raw/building-an-ai-native-engineering-team.pdf`(PDF 20 页,英文原文)
- 类型: 官方指南([[openai]],openai.com;**发布日待核实**——内容引 METR 2025-08 数据,估计 2025 末-2026;文件名与内容对应官方《Building an AI-native engineering team》指南;裁剪日 2026-08-02 暂作文件名日期)
- 备注: 本 wiki 第三十二篇源文档;**OpenAI 官方版的 SDLC 全流程 AI 化框架**——六阶段(Plan/Design/Build/Test/Review/Document/Deploy&maintain)每个都配 Delegate/Review/Own 三分法与落地 checklist;与 [[2026-02-11-codex-agent-first-engineering|2026-02-11 工程技术译文]] 同组织的官方姐妹篇(那篇偏内部工程文化,这篇偏外部团队采用指南)

## 摘要

前沿模型多小时持续推理(METR 2025-08:**2 小时 17 分连续工作,50% 正确率**;任务长度约**每 7 个月翻倍**;几年前仅 30 秒)——SDLC 全流程进入 AI 协助范围。四个使能:统一上下文跨系统(代码/配置/遥测单一模型读取)、结构化工具执行(直接调编译器/测试运行器/扫描器,产出可验证结果)、持久项目记忆(长上下文+compaction,特性从提案跟到部署)、评估循环(输出自动对照基准测试)。OpenAI 内部:周级工作变天级;routine 任务(文档/测试/依赖/feature flags)全委托 Codex;但**代码所有权——尤其新/模糊问题——仍归工程师**。每阶段三分法:Delegable(机械多步)→ Reviewable(人验证)→ Ownable(方向/所有权/战略)。结论:agent = 一审实现者 + 持续协作者,工程师握架构/产品意图/质量;"小规模定向工作流复合增长"。

## 关键主张

**Plan**:agent 连接 issue-tracking 读 spec 对照代码库 → 标记歧义/拆子组件/估难度;即时 trace 代码路径(过去要几小时/天);工程师:验证发现、故事点分配/工作量估算/非明显风险 = 人类判断;优先级/长期方向/排序/权衡 = 人类 led;checklist:特征 scoping/ticket 创建、tagging/dedup、按初始描述加子任务、ticket 到阶段触发 agent 补充细节

**Design**:脚手架 boilerplate/项目结构/设计 token/style guide 即时实现;设计直接转码+无障碍建议+用户流/边界分析;多原型数小时 vs 数天;checklist:**多模态 agent(文本+图像)**、设计工具 MCP 集成、**组件库用 MCP 编程式暴露**、设计→组件→实现工作流、**类型化语言(TypeScript)定义有效 props/子组件引导 agent**

**Build**(最摩擦最清晰影响):端到端功能(数据模型/API/UI/测试/文档)单次协调运行;长任务:整功能草稿/修构建错误不暂停/跨几十文件保持一致/测试随实现写/**符合内部约定的 diff-ready changesets+PR 消息**;工程师 = 评审者/编辑者/方向来源(澄清行为与边界、设计模式与护栏、评审架构含义、精炼业务逻辑与性能关键路径);checklist:**well-specified tasks 起步**、planning tool via MCP 或 **PLAN.md 提交进代码库**、检查 agent 执行命令是否成功、**迭代 AGENTS.md 解锁 agentic loops(跑测试/linter 收反馈)**;案例:Cloudwalk 全员用 Codex 把 spec 变代码(脚本/欺诈规则/微服务,分钟级)

**Test**:agent 从需求文档+功能逻辑建议测试用例(边界/失败模式,聚焦过度的开发者的第二意见);保持测试更新防 stale/flaky;**测试 = 应用功能的事实源(source of truth)——"定义高质量测试常是让 agent 建功能的第一步"**;测试在**独立会话**生成(与功能实现分开);Review:确保没走捷径/没 stub 测试、测试可被 agent 运行(权限+测试套件上下文感知);Own:覆盖与 spec/UX 对齐、对抗性思维、测试意图;checklist:**测试作独立步骤实现,验证新测试在功能实现前先失败**(TDD 官方背书)、AGENTS.md 设覆盖指南、给 agent 覆盖率工具示例

**Review**:人均每周 2-5 小时评审;AI 评审器**可执行部分代码/解释运行时行为/跨文件跨服务追踪逻辑**(超越静态分析);**模型必须专门训练识别 P0/P1 bug + 调优为简洁高信号反馈**(冗长响应 = 噪音 lint 被无视);AI 评审**不必然加速 PR 流程(抓真 bug 时更慢)但防缺陷防 outage**;工程师**委派首轮评审给 agent,但 own 最终评审与合并**(读+理解变更影响);评审强调:架构对齐/可组合模式/约定/功能匹配需求;案例:Sansan 用 Codex 评审竞态条件/数据库关系(人常漏)、硬编码、未来扩展性;checklist:**策展 gold-standard PR 样例集(代码+注释)存为评估集衡量工具**、选专门训练过 code review 的模型(通用模型 nitpick 低信噪比)、**PR comment reactions 作低摩擦质量度量**、小开始快速推广

**Document**:agent 读代码库总结功能/生成 mermaid 系统图;AGENTS.md 自动带文档指令;**SDK 程序化运行 → 文档进发布流水线**(评审 release commits 自动总结变更);工程师:文档组织/重要的"为什么"/标准模板/评审关键与对外文档;委托:文件模块首轮摘要/输入输出/依赖列表/PR 变更摘要;own:文档策略结构/标准模板/对外或安全关键(法律/监管/品牌风险)

**Deploy & maintain**:MCP 接日志工具 + 代码库上下文 → 单工作流"查端点 X 错误"→ 遍历代码库找 bug/性能;CLI 查 git 历史关联日志;委托:解析日志/异常指标/可疑代码变更/提议 hotfix;own:新发事故/敏感生产变更/低置信度场景——人类判断与最终签字;案例:Virgin Atlantic Codex VS Code 扩展 + Azure DevOps MCP + Databricks MCP 统一操作上下文(加速根因发现);checklist:MCP 接日志/部署系统、**模拟事故场景测试工作流**、访问范围与权限、prompt 模板("调查端点 X 错误"/"分析部署后日志尖峰")

**结论**:不需要激进改造,"小规模定向工作流复合增长";well-scoped tasks + guardrails + 迭代扩展责任;工程师稳握:架构/产品意图/质量

## 与现有 wiki 的关系

- 更新 [[pr-contract]](OpenAI 官方版三分法:委派首轮评审、own 最终评审合并——与 2026-02-11 实验的"人类可审但不必须"构成同公司两种声音,张力记录)、[[agent-verification]](评估循环/评审模型训练/gold-standard 评估集/PR comment reactions)、[[agents-md]](解锁 agentic loops + 自动文档指令)、[[conformance-testing]](测试独立步骤+先失败验证 = TDD 官方背书)、[[agent-management]](delegate/review/own 六阶段官方版)、[[ai-feature-implementation-loop]]
- 互证:delegate/review/own ↔ [[2026-01-08-coding-agents-manager|Osmani 版]] 与 [[agent-management]](此前为二手,现获 OpenAI 官方一手);"测试是第一步" ↔ [[spec-driven-development]]/[[ai-agent-spec]] 测试先行与 [[conformance-testing]];PLAN.md ↔ [[plan-mode]]/[[ai-agent-spec]];四使能 ↔ [[harness-engineering]] 演进(统一上下文/工具执行/项目记忆/评估循环 = harness 四支柱);METR 2h17m ↔ [[long-running-agents]] 能力时长数据;评审"执行代码而非模式匹配" ↔ [[agent-verification]] 浏览器自动化同族;gold-standard 评估集 ↔ [[anti-rationalization-tables]] 公开样例集思想(评估集的又一形态);PR comment reactions ↔ Keep Rate/在线代理指标;AI 评审不加速但防 outage ↔ [[2026-06-15-agentic-code-review|Agentic Code Review]]"评审时长 +441%"(不同面:耗时增加但防事故);MCP 三案例 ↔ [[model-context-protocol]]

## 待办 / 后续

- 核实发布日(内容引 METR 2025-08,估计 2025 末-2026);PDF 内图表数据(METR 任务时长图)无法全文提取,如需精确数字读 PDF 原图
- **已核实**:METR 2h17m 引用与一手数据一致([[2025-03-19-measuring-ai-long-tasks|METR 2025-03-19 报告交互图]] GPT-5 2025-08 数据点 ≈2 小时)——二手引用已验证 ✓
- 待核:Cloudwalk/Sansan/Virgin Atlantic 案例细节(均为官方营销性案例)
- 开放问题:官方指南(人类 own 合并)与内部实验(评审代理化)的适用边界——指南是"对外建议",实验是"内部探索",哪个代表 OpenAI 未来方向?
