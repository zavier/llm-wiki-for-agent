---
type: source
tags: [ai-agents, sdlc, anthropic, governance, process]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# The AI-native SDLC playbook (Anthropic 官方,2026-08-21)

- 原文: `raw/The AI-native SDLC playbook.md`(claude.com/resources/articles/the-ai-native-sdlc-playbook;作者 Louis Claxton;Applied AI 团队实践沉淀;致谢 Jim Blackhurst / Will Steuk / Jamal Arif)
- 类型: 官方指南——六阶段(Plan/Design/Build/Test/Deploy/Maintain)+ 16 个 play,每个 play 含"变化点/起步条件/执行步骤/治理考量/度量方法";web 版 + PDF
- 备注: 本 wiki 第五十三篇源文档;**官方指南层第二份 SDLC 全流程框架**,与 [[2026-08-02-building-ai-native-engineering-team|OpenAI 官方指南(2026-08-02)]] 直接对位(并排对比见 [[official-sdlc-guides]]);也是 Anthropic 至今对**流程、治理、度量**最完整的官方立场

## 摘要

代码不再是瓶颈,围绕代码的流程还是:多数组织保留着为"写码最贵"时代设计的审批门、评审、交接与政策(PRD/估算仪式/安全评审都为此而生),agentic 编码提速后这些控制**假设失效**(逐行人工审查跟不上 agent 写的 diff)且**治理成本上升**(例外仍走周会/委员会,安全团队按人类产出配备 → 队列堆积或欠审)。AI-native SDLC = **保留旧控制目标、换新执行方式**:流程从线性变循环,每个阶段以向版本控制**提交一个工件**结束、下一阶段读它开始——`intent.md → spec.md → plan.md → diff+tests → PR+review findings → incident record`,接受工件即触发下一关,**提交链即审计链**。治理在新版中"随行动强制执行":skill 是建议性控制(让违规罕见),hook 是确定性层(让违规接近不可能),审批门以 hook 实现,managed settings 让平台层配置不可被工程师关闭。每个 play 配**领先/滞后指标**(git 时间戳、返工率、首轮合并率、eval pass rate、time to first review、DORA、band breach→intent.md)。终局:Maintain 阶段确定性检测(控制带)只在越界时调用代理一次,发现写成新的 `intent.md` 回灌 —— **循环自己喂自己,人的判断留在循环之上**。

## 关键主张

**诊断:瓶颈迁移的三后果**——①build 两侧(plan / review-test / deploy)仍是人的速度,成为新瓶颈;②控制与现实脱节——"人工逐行审查"在 agent 写大部分 diff 时不可持续;③治理成本上升——例外仍走人工审批路径。安全瓶颈例:安全团队按人类产出规模配备,agent 放大产出后只有"队列堆积"或"欠审上线"两个坏结果。推论:实现阶段的转型必须配同等强度的**流程转型**(来源: 本文)。

**核心机制:提交工件链**——每阶段终点的提交触发下阶段;早期工件是 markdown(产品负责人与代理读同一文件),Build 之后是代码与其记录;工件含作者/时间戳/修订史 = 审计(谁要的、代理产出什么、谁批准)。文章明确点名 `intent.md`(Plan)、`spec.md`(Design)、`plan.md`(Build)、diff+tests、PR+findings(Deploy)、incident record(Maintain 起点)——详见 [[artifact-chain]]。

**Plan:意图一次捕获**——最初想法来源三路(人的想法/ticket/告警);有想法的人在 Claude 陪聊中把 proto-spec 磨成 `intent.md`(用自己的话:要什么、为什么、什么约束),产品负责人审改后 commit;重复过程编码为 skills;**无需正式语言**,非工程师经 connector(如 GitHub)让 Claude 代提交;度量:首次对话→commit 时间从数周降到小时;存活率(被接受进入设计 vs 被关闭)。与传统 backlog/用户故事/refinement 会议对照:所有权不再逐手转移。

**Design:需求与设计压缩为一次会话**——产品负责人挂 `intent.md` + 组织 skills(brand/security/compliance/UX)跑一次 requirements+design pass,产出 `spec.md` 并**标记 concerns**;产品负责人不写 spec,只审:"是否解决了问题、intent 的开放问题是否回答或结转";concerns 先找政策 owner 解决再给工程;接受 spec = 触发 Build 的 plan mode play。前端例:Claude Design 出 mock → 导出到 Claude Code 构建。度量:两个 commit 间隔;build 开始后的 spec 返工(首个 plan.md commit 之后仍出现的 spec.md commit)。

**Build(五件事)**:
- **plan mode 为默认起点**:工程师给 intent+spec 让 Claude 出实现计划(点名文件/顺序/证明测试),审问("改这个会破坏什么/最险一步/被放弃的选项"),迭代到"没参与对话的工程师只看 plan 就能实现",commit 为 `plan.md`;实现偏离计划时**同 commit 更新 plan.md**(可加 hook 强制同步);有计划的实现常一次过。
- **auto mode**:计划被接受后不再逐编辑批准;当护栏成熟(调优 CLAUDE.md、skills、hooks、可测套件),routine 工作默认自动接受;监督从"盯编辑"转向"看更长自主会话后的工件";与 worktrees 结合支撑并行与 Stage 6 闭环。
- **CLAUDE.md**:`/init` 生成→砍到"新人第一天所需"(命令/约定/Claude 最常错的);checkin 入库;规则"**犯错两次就写进 CLAUDE.md**";保持一页内(每次会话全量读取,陈旧内容白占上下文)。
- **skills 作为制度知识**:为"必须一致执行的制度知识"写 skill(`.claude/skills/<name>/` 或经 plugin 组织级分发;policy owner 签核变更;测试触发;策略变更 → skill 更新 → 工程师下次会话自动拿到)。**skill 是建议性控制**——让违规罕见,不保证合规;"**必须永真**的政策后面要有确定性层(hook)"。
- **hooks 作为构建期护栏**:block 受保护路径(generated/frozen package)、保存后跑 formatter/linter、挡凭据进 diff;要快且按文件范围(重检查留 commit/PR);**要人批准的 hook 属于 Deploy 阶段的 gates**,放 build 会让人重新成为所有并行会话的关键路径。
- **并行会话与子代理**:并行会话 = 独立 Claude Code 实例 + 独立 git worktree(彼此无知,共享的只有驾驶它们的工程师;2-3 个起步,上限 = 一个人能审好的量);subagent = 会话内有界助手(独立上下文/工具限制,适合重复性工作,如"运行应用确认行为"的 verifier);`.claude/agents/*.md` 入库共享(见 [[parallel-agents]]、[[subagents]])。

**Test(两个 play)**:
- **给 Claude 反馈回路**:自验(测试/构建/截图 diff)让产出在工程师看到前就过了检查;区别于 verifier subagent(那是终检的打包方式,新鲜上下文,判决不被生成假设污染);操作:单命令收口("make test"非零退出)、命令写进 CLAUDE.md 且附健康输出例、目标可量化("test_status.py 全过"/"截图与 mock 一致"/"端点返回 200+新字段");**bug 修复先写失败测试**(复现→确认按预期原因失败→commit→只让改代码,test-file hook 挡改测试)——"修复前就存在、agent 改不了的测试 = bug 已死的证明";UI 用浏览器/截图工具闭环(2-3 轮正常);"验证是 done 的一部分"写进 CLAUDE.md 并贴输出;hook 挡住修复任务中改测试文件(替代方案 = 评审时拒收改测试的 diff)。
- **CI 中的连续 evals**(AI-native 的 stage-gate QA):20-50 个真实任务(from recent work with expected outcome)写成"prompt + 可接受标准(tests pass/lint clean/behaviour unchanged/policy followed)";**在 CLAUDE.md/skills/hooks 变更时与定时跑**——"steering 代理的配置值得和代码一样的回归测试";配置变更以 pass rate 为合并门禁;**每个生产事故写一条 eval 留在套件**(事故→回归测试)。

**Deploy(三个 play)**:
- **AI 在 PR 评审循环(双向)**:Claude 既评 incoming PR 也处理自己 PR 上的评审意见;所有 PR 得到同一组评审 pass,findings 按严重度排序,人上移一层(变更是否做了 plan 说的事/风险是否可接受);**REVIEW.md** 定义 pass(bugs/security/compliance against spec.md+plan.md)、Important vs Nit、nit 上限(≤5 条其余只报数量)、跳过清单(generated/CI 已管);**findings 本身不 approve/block**——branch protection 仍要求 code owner;severity 计数以机器可读 tally 发布;`@claude` 评论触发修复回路(managed 服务中 `@claude review` 请求新评审);给 Claude 开的 PR 再加"babysit 到 merge"的自定义 slash command(扫未决评论+失败检查→修复→推到只剩 code owner 批准);**评审发现写回 CLAUDE.md**(第二次出现的错误进文件,下个 PR 起被抓住;还标 CLAUDE.md 何时过时);每月调优(给 findings 评级、封顶 nit 量)。**分离职责保留:写码的代理无法批准自己的代码**。
- **hooks 作为审批门**:工程领导+变更管理列出必须存活的审批门(变更签核/发布授权/受保护路径编辑)→ platform engineer 表达为 hook(脚本,allow/ask/block);团队 hook 在 `.claude/settings.json`(入库),**不可协商的进 managed settings**(平台/IT 所有,工程师无法关闭);block 要自解释(原因+审批路径出现在 Claude 输出里);worked example(管制企业):permissions deny(secrets/网络)+ allow(安全内环)、`disableBypassPermissionsMode`+`allowManagedPermissionRulesOnly`(无人能放宽规则)、**sandbox**(工具级 deny 挡不住 shell 出网,OS 级域名白名单才挡;`failIfUnavailable`/`allowUnsandboxedCommands: false` 使沙箱本身成为门;credentials 块堵 `~/.ssh`/`~/.aws` 读取并剥离环境变量 secret)、`allowManagedHooksOnly`、`disableSideloadFlags`+`strictKnownMarketplaces`(一切配置只能从组织批准的 plugin 市场来)、`allowManagedMcpServersOnly`(工具面为平台方 allowlist)、`requiredMinimumVersion`;度量:每 gate 等待时间(OTel 记录时间戳+allow/block)、gate violations 到达生产(前后)。
- **CI/CD 集成与部署**:`claude -p` 进流水线做判断步骤(build 失败 triage/flaky 归纳/changelog 草稿;起步只读)→ 写步骤走既有门(lint 修复/生成文档/@claude 评论响应,一切以 PR 到达,无路径推 main);执行沙箱化(容器+网络策略+短时 scoped token,默认无生产凭据);**部署经 MCP 暴露**(deploy/status/rollback 成为按环境 scoped 的工具——部署能力是 allowlist 而非带凭据的 shell 脚本);**自治按环境分级**(dev:自由部署;prod:代理准备发布、release manager 授权、hook 强制;staging 居中);**回滚是最常演练的路径**(一条命令、定期在 staging 演;"闭环 play 会调用它,必须事先证明")。度量:无需 page 人 triage 的失败比例;DORA。

**Maintain:闭环与三形态**:
- **closing the loop**:一个确定性脚本看生产,控制带越界才调用 Claude;**检测全程无模型**(rolling mean/stddev + Western Electric 之类规则,捕慢漂移与尖峰;脚本版本控制+单测);响应分级在 `bands.yaml`(1σ 只 log、2σ 只读诊断、3σ 可行动且只经 gated routes:开 PR 进评审门/触发预批 runbook);触发层 = 定时 workflow/监控 webhook/网络内 cron;Claude 无状态跑(CI 非交互步骤或 Agent SDK 沙箱服务),因此**循环开始与结束都不需要人启动**;发现写成 Stage 1 格式的 `intent.md`(异常+证据/建议结果/受影响系统/开放问题)回到流水线;service owner/on-call **triage 队列**(fix now/schedule/dismiss),dismiss 调 band 降噪;fix ship 后补 eval;例:CI 失败率 3σ → 隔离 flaky 或开 revert PR(评审门决定);post-deploy 5xx 3σ 且有部署窗口 → 触发既有回滚;PR cycle time 漂移 → 给工程领导写报告(过程指标同样适用)。**跨阶段confidence gate**:Stage 6 无人在调用路径中,阶段之间由独立置信门(确定性检查或对抗性评审代理)决定继续还是升级给人。详见 [[control-bands]]。
- **定期代码库扫描**(Claude Security,hosted):连接仓库后定时在最新模型(文中为 Claude Mythos 5)上扫描,findings **先验证再报告**并附置信度,建议 patch 在 Claude Code on the web 里审后走 PR 评审门;一次 PR 装得下的直接修,更大的(架构性/跨服务模式)写成 `intent.md` 回 Plan;dismiss 必须给理由(否则下次又当新 finding 回来);导出 CSV/Markdown 或 webhook 保持既有 tracker/审计系统为记录源;"安全扫描是时点陈述,两半都会过期(代码每周变;每个模型代际发现上一代漏的)"。
- **Claude Tag 值班**(public beta,Slack):Claude 以自己身份作为频道成员,每条新事故有第一响应者,响应过程留在频道 = 审计链+机构记忆;频道内任何人可引导/行动;经 MCP 验证指标回基线并在 thread 确认、把 post-mortem 写进版本控制的 lessons 文件供未来调查读取;ticket/频道内被 @ 的活同样 triage(小而清晰的修 → PR 过评审门;更大 → `intent.md` 回 Plan)。

**度量框架(每个 play 的领先/滞后指标)**——文章罕见地把"怎么知道有没有用"当作 play 的一等公民:

| 阶段/play | 领先指标 | 滞后指标 |
|---|---|---|
| Plan(`intent.md`) | 首次对话→commit 的时间(git history) | 存活率(被接受 vs 关闭);首版 spec.md 之后对 intent 的改动次数 |
| Design(`spec.md`) | intent commit→spec commit 间隔 | build 开始后的需求返工(plan.md 首 commit 之后的 spec.md commit) |
| Build(plan mode) | 首轮实现即合并比例;plan 批准→merged PR 时间 | 每变更返工循环;merged diff 与 plan.md 的一致度 |
| Build(CLAUDE.md) | Claude 重复 CLAUDE.md 本应挡住的错误频率(从 git 历史看修正) | 新成员首个 merged PR 时间 |
| Build(skills) | 政策 owner 批准→skill 合并的时间 | 引用该政策的评审 findings(应向零) |
| Test(反馈回路) | agent 变更首轮 CI 成功率 | 每 PR 评审时长;change failure rate |
| Test(evals) | eval pass rate 趋势;事故→永久 eval 的时间 | CI 捕获回归 vs 生产发现回归(incident tracker) |
| Deploy(评审) | time to first review(应到分钟级);无人工触碰即解决的评论占比 | 合并前捕获的缺陷 vs 逃逸生产 |
| Deploy(hooks) | 每 gate 的等待时间(OTel 时间戳) | gate violations 到达生产(前后对比) |
| Deploy(CI/CD) | 无需 page 人即完成 triage 的 pipeline 失败占比 | DORA |
| Maintain(闭环) | band breach→triage 队列 intent.md 时间 | findings→merged fixes 比例;同类事故复发(应随 eval 累积下降) |
| Maintain(scans) | 排期覆盖仓库占比;finding→patch 进评审门时间 | 生产/外部发现的漏洞 vs 扫描发现;多轮后每轮 findings 趋势 |

**Legacy 系统与唯一事实源(sidebar,适用所有工件)**——已有 SDLC 很可能已有记录系统(Jira/带法规追溯的需求工具/Figma/变更委员会),审计与监管已接受它们,AI-native 要**绕着现有走**:对每个工件**指定唯一 source of truth**,其余只存副本或链接;三种配置:①**repo 为事实源**(markdown 为权威记录,legacy 系统引用 commit——工程主导组织最干净)②**legacy 系统为事实源**(Jira/ServiceNow 权威,markdown 是工作副本;Claude 会话开始读记录、结束经 MCP 写回)③**linkage 为最低标准**(工件记 record ID,legacy 记 commit SHA;两个事实源并存——过渡期起步点)。两种系统可共存,只要有链接或有一个被宣布为事实源。

**其他值得记录的主张**:
- "AI-native SDLC 还有别的名字:agentic SDLC / AI SDLC / agentic software development——标签不同,一回事"(术语地图)。
- plays 有**依赖图**(Prerequisites),**采纳顺序 ≠ 阶段顺序**;无入边的 play 可先行,其余先做指向它的 play——模块化渐进转型。
- 工程师角色转变的官方表述:"工程师的工作是 steering 和 reviewing 所有会话;最终是**构建和监控循环**";"人的注意力集中在 gates——审代理标记的内容,而不是每个阶段从零开始"。
- 反馈回路 ≠ verifier subagent:"反馈回路贯穿整个任务、跑很多次;verifier 是任务末尾用全新上下文打包终检的一次运行——**判决不被生成代码的假设染色**"。
- 成功镜头:"转型把人的判断保留在流程中心,并考虑大企业的治理与监管要求";收尾语:"The loop keeps running. Human judgement stays above it."
- 资源清单按推出顺序给(先控制后自动化——"gates 必须先存在,自动化才会加速通过它们")。

## 与现有 wiki 的关系

- **新建 3 个概念页**:[[artifact-chain]](提交工件链——本源最核心的独特贡献)、[[governance-as-code]](治理即代码:skill 建议层/hook 确定层/managed settings 强制层/OTel 证据层)、[[control-bands]](控制带:确定性检测+σ 分级响应+intent.md 回灌);**新建综合页** [[official-sdlc-guides]](OpenAI 三分法 vs Anthropic 工件链+治理+度量)
- 更新 [[intent-debt]](intent.md = 意图在决策时刻捕获的官方 SDLC 形态;存活率指标)、[[spec-driven-development]](Design 压缩为一次会话;接受 spec 触发 plan mode)、[[plan-mode]](plan mode 官方默认起点;plan.md 入库+同步 hook;auto mode)、[[claude-md]](官方 play:犯错两次规则/一页上限/评审发现写回)、[[skills]](制度知识 play;建议性控制定位)、[[agent-verification]](反馈回路 vs verifier subagent;先失败测试+test hook;evals 门禁配置变更)、[[pr-contract]](REVIEW.md;findings 不 approve/block;评审发现写回)、[[loop-engineering]](Anthropic 版闭环:确定性触发+置信门)、[[factory-model]](瓶颈迁移的官方诊断)、[[harness-engineering]](企业级 harness:沙箱/managed settings/OTel)、[[three-tier-boundaries]](边界可执行为 hook 的 allow/ask/block)、[[subagents]](verifier 子代理样例;并行会话 vs 子代理的官方区分)、[[parallel-agents]](worktree 并行会话;2-3 起步;上限=评审带宽)、[[conformance-testing]](evals=stage-gate QA 的 AI-native 形态)、[[agent-management]](人的注意力在 gates)、[[anthropic]]、[[claude-code]](Auto mode/Code Review 服务/Claude Tag/Claude Security/`--worktree`)
- 互证/呼应:工件链 ↔ [[process-over-prose]](退出标准与检查点的物理载体);**技能 vs 钩子双层控制** ↔ [[harness-engineering]] 的 hooks 强制层与 HumanLayer 回压;control bands ↔ [[loop-engineering]] 的"设计循环而非提示代理"(但是事件触发式、确定性检测版);worktree 并行 ↔ [[parallel-agents]] 与 [[orchestration-tax]](上限=评审率,官方措辞"practical ceiling is how many streams one person can review properly");evals ↔ [[conformance-testing]]/[[tool-evaluation]];review 分离职责 ↔ [[pr-contract]] 人类签字阵营(Anthropic 官方落在"写码者不能批准+code owner 门"),与 OpenAI 内部零人工实验的张力照旧存在
- 张力/对照:managed settings/沙箱/审核门 vs [[pi-coding-agent]] "权限弹窗 = security theater"——**两者都反对逐次人工审批**,但一条路是平台层强制配置(组织),一条路是极简+YOLO+容器兜底(个人);组织规模再现 [[minimal-vs-rich-harness]] 的"规模是学派分化自变量"

## 待办 / 后续

- **companion 文章已摄入(2026-10-15)**:①[[2026-07-21-anthropic-secures-ai-native-sdlc]](安全实现篇:8× 产出/~80% 代码/shadow mode/抽检/SIEM)②[[2026-08-18-claude-tag-first-responder-ci-cd]](值班展开篇:中位 14 分钟/617 行 skill/lessons.md/oncall-kit 开源);已回填 [[governance-as-code]]、[[control-bands]]、[[agent-identity]]、[[claude-tag]]
- 待核:作者 Louis Claxton 背景;发布日 2026-08-21(raw frontmatter)/PDF 版差异;文中模型名("Claude Mythos 5")与各功能 beta 状态(Claude Tag/Claude Security/Code Review/Claude Design)的时效
- 与 OpenAI 官方指南的逐项并排已建 [[official-sdlc-guides]];后续可补:两指南的客户案例(Cloudwalk/Sansan/Virgin vs 本文未点名客户)与量化效果的对照数据
- 开放问题已并入 topic hub:工件链在存量巨型仓库的最小可行形态;"配置即被测对象"的 eval 套件维护成本;控制带阈值(σ 分级/去噪)的跨团队标定
