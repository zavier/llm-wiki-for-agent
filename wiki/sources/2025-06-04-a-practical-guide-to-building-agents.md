---
type: source
tags: [ai-agents, orchestration, guardrails, agentic-systems]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
status: active
---

# A practical guide to building agents (2025-06-04)

- 原文: `raw/A practical guide to building agents.md`
- 类型: OpenAI 商业指南 PDF(面向产品与工程团队的 agent 搭建入门;cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf)
- 备注: 剪藏未标注原始发布日期,文件名归档为 2025-06-04,**待核实**;原文含多段 Agents SDK 代码示例,剪藏在提取时格式有损,正文按语义摘要

## 摘要

OpenAI 官方 agent 搭建指南:先定义什么才算 agent(LLM 驱动工作流执行与决策、动态选工具、在 guardrails 内动作),再给识别高价值用例的判据,然后用"Model / Tools / Instructions 三组件 + Orchestration + Guardrails"搭出可靠 agent。编排上主张先最大化单 agent、必要时才拆多代理(manager / decentralized 两模式),护栏上强调分层防御、工具风险分级与人类介入。

## 关键主张

- **agent 定义**:agent 是"独立替用户完成任务"的系统;它用 LLM 管理工作流执行与决策,能识别工作流何时完成、必要时主动纠偏、失败时停下并把控制权交还用户;有各种工具与外部系统交互(取上下文 + 采取行动)并依当前状态动态选工具,始终在明确 guardrails 内;workflow 是完成用户目标必须执行的步骤序列;**简单 chatbot、单轮 LLM、情感分类器不算 agent**
- **何时建 agent**: 优先传统自动化(确定性/规则式)受阻的场景——复杂决策(客服退款审批)、难维护的规则(供应商安全审查)、重非结构化数据(家庭保险理赔);拿不准时确定性方案可能已足够;类比:规则引擎是清单,LLM agent 像老练调查员
- **三大核心组件**:**Model**(驱动推理与决策)、**Tools**(可调用的外部函数/API)、**Instructions**(明确的行为准则与 guardrails)
- **选模型三原则**: 先用最强模型给每类任务建原型建立 baseline,再换小模型验证是否仍达标——① 建 evals 建立性能基线 ② 用最好的模型达成准确率目标 ③ 在可行处用小模型优化成本与延迟;不要让原型过早受限于小模型
- **工具三类型**:**Data**(取上下文:查库/CRM/读 PDF/搜网)、**Action**(采取行动:发邮件/更新 CRM/移交工单)、**Orchestration**(agent 本身作为其他 agent 的工具);每个工具都应有标准定义、良好文档、充分测试、可复用
- **工具过载的真正变量是重叠**: 关键不在数量而在相似/重叠程度;"一些实现能管好 **>15** 个定义清晰、彼此不同的工具,另一些则在 **<10** 个重叠工具时就挣扎";若改善命名/参数/描述无效,就拆多 agent
- **instructions 最佳实践**: 用现有 SOP/客服脚本/政策文档做 LLM 友好化的 routine;提示模型把密集资源拆成更小更清晰的步骤;每步对应具体动作或输出;捕获 edge cases(信息不全/意外问题)用条件分支;可用 **o1 或 o3-mini** 从现有文档自动生成指令
- **single-agent 优先**: 增量加工具、保持复杂度可控、简化评测与维护;每个编排都需要 "run" 概念=循环直到 exit condition(工具调用、特定结构化输出、错误、达到最大轮数);用带 policy 变量的 prompt template 管理复杂度,而非维护一堆单独 prompt
- **何时拆多代理**: ① **Complex logic**——prompt 含大量条件分支、模板难扩展 ② **Tool overload**——工具相似/重叠导致选择困难;先尽量最大化单个 agent 能力
- **多代理两模式**:**Manager (agents as tools)**——中央 manager 用工具调用协调专职 agent,适合同一时刻只要一个 agent 控制工作流并与用户对话;**Decentralized (handoffs)**——对等 agent 之间单向移交执行与最新对话状态,适合 triage/无需中央控制的场景;多代理可建模为图(manager=工具调用边;decentralized=handoff 边);声明式图 vs 非声明式(Agents SDK 是 code-first)
- **guardrails 分层防御**: 单一 guardrail 几乎不可能足够;组合 LLM-based、rules-based(regex/blocklist/输入长度)与 OpenAI Moderation API;类型含 relevance classifier、safety classifier、PII filter、moderation、tool safeguards、rules-based protections、output validation;目标是数据隐私风险(防 system prompt 泄漏)与声誉风险
- **工具风险分级**: 按 read-only vs write、可逆性、所需账号权限、财务影响给每个工具评 **low / medium / high**;据此触发自动化动作——高风险执行前暂停做 guardrail 检查或升级人工
- **人类介入两触发**: ① **超过失败阈值**(重试/动作数上限)② **高风险动作**(敏感、不可逆、高风险,如取消订单、大额退款、付款)应在置信度建立前需人工监督;部署早期尤其重要,有助于发现失败、暴露 edge cases、建立评测循环

## 与现有 wiki 的关系

- 更新 [[openai]](官方 agent 搭建指南,与 Codex/AGENTS.md 并列的官方方法论)
- 与 [[agentic-systems]] 对照:OpenAI 的 workflows vs agents 区分与 Anthropic 的分类同源;[[agentic-workflow-patterns]] 的 orchestrator-workers ↔ manager pattern
- 更新 [[agent-computer-interface]](工具三类型 + 标准定义 + 文档/测试)
- [[multi-agent-systems]]:manager/decentralized 两模式的官方版本;[[subagents]]:agent as tool
- [[three-tier-boundaries]]:guardrails 的 low/medium/high 可映射到 allow/ask/deny;[[governance-as-code]]:高风险工具暂停/升级=审批门
- [[agent-verification]]:模型选择第 1 步就是建 evals 建立 baseline
- [[lethal-trifecta]]:按任务复杂度/成本权衡模型、失败阈值与人类介入
- [[model-context-protocol]]:工具/computer-use 是连接外部系统的路径

## 待办 / 后续

- 核实原始发布日期(剪藏未标注)
- 剪藏中 Agents SDK 代码示例格式破损,如需引用需对照 PDF 原文
- 可与 [[2026-08-02-building-effective-ai-agents]] 做官方指南对比(OpenAI workflow/agent 三分法 vs Anthropic 五工作流模式)
- 工具风险评级(低/中/高)可与 [[three-tier-boundaries]]、[[governance-as-code]] 合成更细的分级表
