---
type: concept
tags: [testing, ai-agents, contracts]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [simon-willison, spec-driven-development, ai-agent-spec, long-running-agents, factory-model, agents-md, agent-verification, claude-md]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-02-25-factory-model-coding-agents, 2026-08-02-building-ai-native-engineering-team]
status: active
---

# Conformance testing

语言无关的一致性测试套件(常为 YAML):规定期望输入/输出,任何实现必须全部通过——从 spec 直接导出的契约。

## 关键信息

- 比临时单元测试更严格:用例直接源于 spec,可跨实现复用;是"API 契约"而非"顺手测试"(来源: [[2026-01-13-good-spec-for-ai-agents]])
- 建议把一致性标准写进 spec 的 Success 节:"必须通过 conformance/api-tests.yaml 的全部用例"
- 由 [[simon-willison]] 倡导;与健壮测试套件一起构成"代理的超能力"——失败即可快速反馈迭代
- 在 [[spec-driven-development]] 中作为任务验收的客观标准,配合门禁流使用
- 自验证的加强版:spec 里写"这些样例输入应产生这些输出",代理可实际执行验证
- **可执行特征清单**(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]]):Anthropic 长时任务 harness 把端到端特征写成 JSON 清单(200+ 条,每条含 category/description/steps),初始全标 `passes: false`,代理只允许翻 passes 字段——"It is unacceptable to remove or edit tests";选 JSON 而非 Markdown 是刻意的(模型更不易改写 JSON);这是一致性测试的**清单化形态**:验收标准与代码库同库、逐条可翻转、防删改(见 [[long-running-agents]])
- **红/绿 TDD 近乎强制**(来源: [[2026-02-25-factory-model-coding-agents]]):舰队规模下"优化通过测试的代理会找到通过测试的办法;测试写于实现之后,测的往往是**实现恰好做的事,而非它应该做的事**"——测试先于实现是防"测错东西"的唯一可靠手段;"告诉代理用 red/green TDD 是任务开始时最高杠杆的指令之一";与 Willison 测试套件=代理超能力、SWE-bench 实证同源(见 [[factory-model]])
- **测试即事实源 + 独立会话**(来源: [[2026-08-02-building-ai-native-engineering-team]],OpenAI 官方):"定义高质量测试常是**让 agent 建功能的第一步**"——测试是应用功能的事实源,agent 跑套件按输出迭代;落地:**测试作独立步骤实现**(与功能实现分开会话),**验证新测试在功能实现前先失败**(TDD 官方背书);AGENTS.md 设覆盖指南、给 agent 覆盖率工具示例(见 [[spec-driven-development]])

## 与其他页面的关系

- 概念出处与倡导者: [[simon-willison]]
- 在 [[ai-agent-spec]] 中属于原则 4(自检);验收场景见 [[spec-driven-development]]
- 与 [[llm-as-a-judge]] 分工:前者管客观对错,后者管主观好坏
