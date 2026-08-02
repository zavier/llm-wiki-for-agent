---
type: concept
tags: [ai-agents, organization, management, role-change]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [execution-graph, hive-mind, distillation-anxiety, agent-readability, alibaba, claude-code]
sources: [2026-05-08-ai-native-organization, 2026-05-14-claude-code-large-codebases]
status: active
---

# 管理塌缩 (Management Collapse)

管理职能不会消失,但会重新选择位置:传统管理者的工作内容在 AI Native 之下命运分化——一部分被系统替代、一部分变形、一部分不可替代、另有一部分是全新出现的;结论是**塌缩,不是消失**。

## 关键信息

**数据与主张**(均为二手引述,待核):Peter Pang(CREAO CTO)管人时间 60%→<10%;Block(Jack Dorsey & Roelof Botha)"永久的中层管理层不再必要"——作者认为"这个结论太粗糙"

**管理 10 件事的命运分化**:

| 类别 | 命运 |
|---|---|
| 战略传导、信息聚合、资源协调、日常决策(前四项) | **可被系统替代**(World Model 承载 alignment、自动化报告替代汇报) |
| 重大决策、冲突调解 | **变形**:重大决策从 manager 拍板下沉到离客户最近的 DRI;冲突调解总量随团队变小自然减少 |
| 激励、辅导、招聘退出、文化建设(后四项) | **不可被系统替代**(伦理上必须由人完成) |
| — | **全新出现**:意图教练、身份重建、虚无对抗——以前不需要、现在需要、几乎没人在做 |

**Architect = 新组织最高杠杆点**:设计"教 AI 怎么工作"的人——定义系统能力边界、设计 SOP、建立测试基础设施、搭建集成与 triage 系统、定义"什么叫好";本质是把组织**隐性 know-how 翻译成 AI 可消化形态**(每份 SOP/判据/架构决策直接进入 Harness 层);**必须资深**——写好的测试需要懂业务的人、SOP 需要做过的人、判据需要有品味的人、架构需要见过失败模式的人;产出被 N 个 agent 复用、被多 domain team 依赖 → 组织最稀缺的资本是"能转身投入这个角色的资深工程师"
- **Anthropic 企业落地名**(来源: [[2026-05-14-claude-code-large-codebases]]):agent manager——新兴角色,"混合 PM/工程师,专职管理 Claude Code 生态";最小可行 = **DRI**(一人拥有配置/权限策略/插件市场/CLAUDE.md 约定并保持更新);采用模式:**先基础设施投资后开放**(小团队甚至一人先接线,开发者第一次接触就 productive)→ 采用扩散;bottoms-up 热情会碎片化——没有中央化(组装+布道标准约定、精选 skills/plugins)知识保持部落化、采用平台期;受监管行业:批准 skills 清单 + 强制代码评审 + 限量初始访问,信心增长后扩大;跨职能工作组(工程+信息安全+治理)早期建立;与阿里 Architect 的对照:同一角色的两种命名(Architect 强调"设计教 AI 怎么工作",agent manager 强调"管理生态/保持更新")

**绩效失效**(开放问题):旧依据(老板目击)失效,新依据(artifact 可见 + recognition 主动)未建立;评价系统不跟着变则"口头说判断比执行值钱、KPI 还是产出量"员工不会信

**先锋形态**:3-5 人垂直功能小组(无产品/前端/后端边界)、成果评审驱动(替代需求评审驱动)、**决策权与开发权分离**("决策权在领域专家手上,开发权可以交出来")

## 与其他页面的关系

- 组织范式: [[execution-graph]];上层文化: [[hive-mind]];人侧代价: [[distillation-anxiety]]
- Architect 的产物 = [[agent-readability|AI 友好]] 化基础设施;来源: [[2026-05-08-ai-native-organization]]
