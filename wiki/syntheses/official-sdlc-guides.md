---
type: synthesis
tags: [ai-agents, sdlc, comparison, official]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [artifact-chain, governance-as-code, control-bands, process-over-prose, spec-driven-development, agent-management, pr-contract, agent-verification, factory-model, management-collapse, comprehension-debt, wicked-features, agent-identity, claude-tag]
sources: [2026-08-02-building-ai-native-engineering-team, 2026-08-21-ai-native-sdlc-playbook, 2026-02-11-codex-agent-first-engineering, 2026-05-03-agent-skills, 2026-01-13-good-spec-for-ai-agents, 2026-07-21-anthropic-secures-ai-native-sdlc, 2026-08-18-claude-tag-first-responder-ci-cd]
status: active
---

# 官方 SDLC 指南对比:OpenAI 三分法 vs Anthropic 工件链

综合结论:**两份官方 SDLC 全流程指南(OpenAI 2026-08-02 / Anthropic 2026-08-21)共享同一副六阶段骨架与同一条人机分界(代理做一审实现,人 own 方向与判断),但组织心智不同**——OpenAI 以"每阶段 Delegate/Review/Own 三分法"为骨架(任务分配视角),Anthropic 以"提交工件链 + 门 + 治理执行"为骨架(过程状态机视角);治理/合规的执行细节(Anthropic 的独有章节)与逐阶段度量框架(Anthropic 独有)是把两份文档区分开的最大增量。

## 骨架对照

| 维度 | OpenAI 官方指南([[2026-08-02-building-ai-native-engineering-team]]) | Anthropic playbook([[2026-08-21-ai-native-sdlc-playbook]]) |
|---|---|---|
| 阶段 | Plan / Design / Build / Test / Review / Document / Deploy&maintain | Plan / Design / Build / Test / Deploy / Maintain |
| 组织心智 | **任务三分法**:每阶段 Delegate(机械多步)/ Review(人验证)/ Own(方向/所有权) | **工件链 + 门**:每阶段提交工件触发下阶段(`intent.md→spec.md→plan.md→diff→PR→incident`) |
| 强制机制 | 几乎不涉及(hooks/managed settings/沙箱无) | **核心章节**:skill 建议层→hook 确定层→managed settings 强制层→OTel 证据层(见 [[governance-as-code]]) |
| 度量 | 引用能力时长(METR 2h17m);checklist 为主 | **每个 play 配领先/滞后指标**(git 时间戳/返工/首轮合并率/eval pass rate/DORA/breach→intent.md) |
| 测试 | 测试 = 事实源;独立会话;TDD 官方背书 | 同左 + **evals 门禁配置变更**(CLAUDE.md/skills/hooks 回归测试) |
| 评审 | 委派首轮评审;**own 最终评审与合并**;gold-standard PR 评估集 | findings 不 approve/block;**写码者不能批准**;code owner 门 + severities tally;REVIEW.md |
| 文档配置 | AGENTS.md(迭代解锁 agentic loops)+ PLAN.md + docs/ | CLAUDE.md(犯错两次规则)+ skills + `intent.md/spec.md/plan.md/REVIEW.md` |
| 自治边界 | 人 own 合并与签字;内部实验另说 | 代理行动到生产闸口,**不能穿过**;具名发布授权;按环境分级自治 |
| 闭环 | Deploy&maintain:日志/事故 triage(人 own 新发事故/敏感变更) | **Stage 6 全闭环**:确定性检测(控制带)→`intent.md` 回灌→Claude Tag 值班/定时扫描(见 [[control-bands]]) |
| 案例 | 客户案例(Cloudwalk/Sansan/Virgin Atlantic) | Applied AI 内部+客户实践;companion 两篇已摄入(安全实现/值班全流程) |
| 版本特征 | PDF;发布日待核;偏"对外采用指南" | Web+PDF;2026-08-21;偏"完整 playbook+治理" |

## 综合论点

**共同底线(两份官方文件互证,可信度最高的一层)**:①六阶段全流程进入 AI 协助范围;②代理是**一审实现者**,人保留方向/所有权/最终判断("AI 不消除对判断的需求",见 [[agent-management]]);③测试先于实现/独立会话生成,测试是应用功能的**事实源**;④外部系统经 MCP 连接;⑤**官方对外立场比各自内部实验保守**:OpenAI 官方要人 own 合并,内部在跑零人工代码;Anthropic 官方给满治理门,内部用 Claude Tag 值班+托管评审服务(见下"张力")。

**分歧的实质**:OpenAI 的骨架回答"**每阶段哪些事可以交出去、哪些必须留下**"(管理问题);Anthropic 的骨架回答"**阶段之间传什么、什么算接受、控制在哪里强制**"(过程与治理问题)——两者不互斥,合起来接近一个完整答案:任务粒度用三分法分配,过程粒度用工件链承载,控制用分层执行落地(本 wiki 三页合读:[[agent-management]] + [[artifact-chain]] + [[governance-as-code]])。

**与 wiki 其他流程框架的对齐**:两份官方版与 Osmani 的 SDLC 六阶段([[2026-05-03-agent-skills]] 的 Define/Plan/Build/Verify/Review/Ship)、GitHub Spec Kit 四阶段门禁流([[spec-driven-development]])同构——**六阶段骨架已是跨来源共识**;"过程胜过散文"(退出标准/检查点)在三处各有形态:skill 工作流、门禁流、[[artifact-chain|提交工件]]。

## 支持与反证

- 支持工件链:[[process-over-prose]](工作流以证据终止——工件是其物理形态);[[intent-debt]](意图在决策时刻捕获;"冷启动经济学"支持 `intent.md` 一次写、每会话读)
- 支持三分法:[[agent-management]](委派三档与六步操作系统;OpenAI 官方版此前仅有二手转述,官方一手后可信度上升)
- 保留:两份指南都**没有逐阶段的效果数据**;Anthropic 的指标框架是"怎么测"而非"测得多少";OpenAI 的采用案例是营销性自述(见其源页待核项)
- 未解张力(部分解除):①OpenAI 同公司两种声音(对外 own 合并 vs 内部零人工)②**Anthropic 侧已有一半答案**:companion 两篇(安全实现/值班)显示内部自治与治理是**配对**的——产出高自动化,**信任靠 shadow mode/抽检/SIEM/身份边界重建**,不是“少治理”;剩下的问题变成该实装(平台能力/文化/成本)对外的可复制性

## 开放问题

- 工件链与三分法**能否互译**:Anthropic 的 delegate 粒度为"阶段+工件",OpenAI 为"任务+字段"——同一工程团队同时用会发生什么(提示词起点、评审对象、度量口径三套如何对齐)
- **官方指南 vs 内部实验**的适用边界:官方保守立场是"客户就绪度"折价,还是"内部实验其实不 generalize"的证据?(两份文件都不回答)
  - **部分更新(2026-10-15)**:companion 两篇确认内部实装是“高自动化 + 高治理”配对,且依赖平台能力;落差问题收窄为**可复制性**(见 [[2026-07-21-anthropic-secures-ai-native-sdlc]]、[[2026-08-18-claude-tag-first-responder-ci-cd]])
- 逐阶段指标的可比性:Anthropic 的 git 时间戳类指标在 monorepo/多仓库/外包混编团队的失真边界
- **存量巨型代码库**的适配:两份指南的示范都在产品团队尺度;工件链在数十年遗留仓的最小可行形态未讨论(与 [[wicked-features]]、[[comprehension-debt]] 的开放问题合流)
- 术语统一:agentic SDLC / AI SDLC / agentic software development / AI-native SDLC(playbook 自列别名)——行业是否收敛到一词

## 相关

- 源页:[[2026-08-02-building-ai-native-engineering-team]]、[[2026-08-21-ai-native-sdlc-playbook]]、[[2026-07-21-anthropic-secures-ai-native-sdlc]]、[[2026-08-18-claude-tag-first-responder-ci-cd]]
- 过程层:[[artifact-chain]]、[[spec-driven-development]]、[[process-over-prose]];治理层:[[governance-as-code]]、[[control-bands]]
- 人机分工:[[agent-management]]、[[pr-contract]]、[[agent-verification]];组织演进:[[factory-model]]、[[management-collapse]]
