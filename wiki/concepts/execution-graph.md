---
type: concept
tags: [ai-agents, organization, governance, architecture]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [hive-mind, management-collapse, distillation-anxiety, harness-engineering, agent-verification, alibaba, subagents]
sources: [2026-05-08-ai-native-organization]
status: active
---

# Execution Graph

组织范式转换:当 AI 能行动、能调用工具、能改系统,组织不再能被 org chart 准确描述——它变成一张执行图(人/agents/数据/权限/工具/审批关系作为同等节点,节点间是"意图到行动的转化链路"而不是汇报关系)。

## 关键信息

**范式转换**(转述 Ken Huang,2026-02,二手)

- 核心问题迁移:旧问题 ownership("谁拥有这件事")→ 新问题 **routing + governance**("意图从哪里进入系统?怎么翻译成行动?什么约束让行动安全?")
- 最小单元:从"人 + 长期关系网"(粘性极高,reorg 需重建信任/依赖/身份归属,周期 6-12 个月)换成"**任务 + 上下文 + 权限 + 工具**"——大部分依赖是机器可读 artifact,不是人脑隐性关系 → **重组成本从季度级压到 week 级**,这是 AI Native 最被低估的红利:适应性速度本身的升级
- 双层叠合:柱 1(Agent Platform)建造底层 Harness 层、柱 3(Risk)守护底层、柱 2(Domain)在上层 Hive Mind 探索交付(见 [[hive-mind]])

**Platform 三柱架构**(Ken Huang)

1. **Agent Platform Group**:中央团队——runtime 标准、权限、日志、可观测、评估 harness、安全部署;"不是浪漫意义上的 AI research,是 production engineering plus governance"(Architect 角色的组织化形态)
2. **Domain Teams**:业务团队——"own outcomes rather than models",3-5 人垂直功能小组
3. **Risk and Oversight**:治理层——"**免疫系统,不是官僚刹车**";"治理做得好时不拖慢 Hive Mind,而是让它活着";"假设不会出事不是乐观,是在错误可以快速传播的世界里的疏忽"

**治理基本功 6 项**(Ken Huang):枚举 agents、权限纪律、梯度自治、日志、评估 harness、事故响应——"都不性感,但基础设施工作有复利";配套判断:**agent 名册**——"你不可能治理你叫不出名字的东西"

**Agent 是新员工类**:需 onboarding/scoping/supervision/offboarding,但与人存在**四不对称**——可无限复制、同小时既 brilliant 又 brittle、compliance-blind by default、fast enough to fail at scale;管 agent 既不是管软件也不是管人,需要第三套治理框架

## 与其他页面的关系

- 上层文化: [[hive-mind]];管理职能变化: [[management-collapse]];人侧代价: [[distillation-anxiety]]
- 底层对应:Harness 层 ↔ [[harness-engineering]];评估 harness ↔ [[agent-verification]]
- 来源: [[2026-05-08-ai-native-organization]](阿里技术);概念提出: Ken Huang(经二手转述)
