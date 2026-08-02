---
type: concept
tags: [ai-agents, software-engineering, paradigm, mental-model]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [addy-osmani, ai-agent-spec, agent-verification, agentic-systems, spec-driven-development, conformance-testing, multi-agent-systems, comprehension-debt, harness-engineering, agents-md]
sources: [2026-02-25-factory-model-coding-agents, 2026-03-14-comprehension-debt, 2026-03-26-code-agent-orchestra]
status: active
---

# Factory model

工厂心智模型:自主代理时代软件工程的范式框架——你的工作不是写代码,而是**建造生产你软件的工厂**;软件第三纪元(从写指令到定义意图)的实操化表述。

## 关键信息

**框架**(来源: [[2026-02-25-factory-model-coding-agents]])

- 核心张力:写代码已剧变,软件工程本质没变——差距所在是故事所在;历史是抽象之弧(bits→…→分布式系统→编排写代码的系统,Grady Booch "软件第三纪元")
- 三代 AI 编码工具:①加速自动补全(你驱动)②同步代理(你持上下文、逐轮协作)③自主代理(spec 进、结果出,你定义结果 + 审结果)——当前处于第三代
- 工厂 = 代理舰队:每个代理有任务、工具带(仓库/测试运行器/部署脚本/文档)、上下文(spec/架构决策/既有约束)、反馈回路;工厂属性映射:质量控制、流程文档、输入精确性、**环境可靠性(工厂停摆论)**
- 生产现实:激进采用的组织里,合并 PR 的相当部分已来自云端自主代理(二手引述,待核)

**两条推论**(本文最具操作性的主张)

1. **Spec 是杠杆**:舰队规模(20-50 代理并行)下,平庸 vs 优秀几乎全由 spec 质量决定——模糊想法乘法式放大(含糊需求各自偏一点,架构错误传遍舰队);spec = 产品思维的外显,不是 prompt(见 [[ai-agent-spec]])
2. **验证是瓶颈,不是生成**:生成已不缺,缺的是置信地知道输出正确;测试后写则测的是"实现恰好做的事";UI 验证脆弱;环境抖动在并行规模下系统化(见 [[agent-verification]])

**杠杆的边界**(来源: [[2026-03-14-comprehension-debt]]):spec 与测试都必要但不充分——spec→代码有海量隐式决定(两个工程师实现同一 spec 差异巨大),"详细到能完全描述程序的 spec ≈ 非可执行语言的程序";测试无法覆盖没想到的行为;AI 更新几百条测试匹配新行为时,唯一能回答"改动必要吗"的是人的理解(见 [[comprehension-debt]])

**配套纪律**:红/绿 TDD 近乎强制(测试先于实现是防"测错东西"的唯一可靠手段,见 [[conformance-testing]]);人工审查 = 安全系统而非可选开销;代码库投资测试——"仅凭文档+commit 历史,新工程师能理解代码为何如此结构吗"(文档 = 代理的训练材料,见 [[agents-md]])

**高杠杆工程师六能力**:系统思维、问题分解、架构判断、spec 清晰度、输出评估品味(不可自动化)、编排技能(重定向 vs 重新派任务)

**流水线操作化**(来源: [[2026-03-26-code-agent-orchestra]],演讲版):工厂六步——**Plan**(带验收标准的 spec;spec 是杠杆)→ **Spawn**(建团队派活)→ **Monitor**(每 5-10 分钟解阻塞,别 hover)→ **Verify**(验证是瓶颈)→ **Integrate**(合并分支)→ **Retro**(更新 AGENTS.md 复合学习);实务:WIP 上限(3-5 代理甜点)、终止标准(3+ 卡死即停重派)、异步查岗、一文件一主人(见 [[multi-agent-systems]]);**谱系**:六步最早以"编排操作系统"形态出现于 [[2026-01-08-coding-agents-manager]](Plan like a manager → Spawn → Monitor async → Verify aggressively → Integrate carefully → Retro)——管理技能迁移的操作手册见 [[agent-management]]

## 与其他页面的关系

- 范式背景: [[agentic-systems]];spec 侧: [[ai-agent-spec]]、[[spec-driven-development]]
- 验证侧: [[agent-verification]]、[[conformance-testing]];规模化: [[multi-agent-systems]]、[[parallel-agents]]
- 与 [[harness-engineering]] 互补:harness 是"怎么造",factory model 是"为何如此造"
