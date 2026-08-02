---
type: concept
tags: [ai-agents, complexity, engineering-culture, failure-mode]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-03
refs: [theory-building, comprehension-debt, pure-impure-engineering, intent-debt, distillation-anxiety, sean-goedecke]
sources: [2025-04-12-wicked-features, 2025-12-24-nobody-knows-how-software-products-work, 2025-06-22-pure-and-impure-engineering, 2026-07-11-in-defense-of-not-understanding-your-codebase]
status: active
---

# Wicked features

"影响每个其他功能"的需求:建任何其他功能都必须考虑它(新用户类型/on-prem/分片/数据本地性/跨区域迁移/i18n……)。大系统"禁止理解"、"不可重建"、"战争迷雾"的结构性机制;也是 impure 工程"混战"复杂度的来源。

## 关键信息

**定义与例证**(来源: [[2025-04-12-wicked-features]])

- 区分:给 todo 加图片附件是大功能但不是 wicked;同时提供 webapp + 独立可执行文件是 wicked——"must be considered every time you build any other feature"
- 连锁问题示例:新用户类型能用吗/on-prem 没有 S3 图片存哪/分片库的 images 表分片了吗/每个区域都有 bucket 吗/跨区域迁移自动搬图吗/新字符串翻译预算了吗
- **Password Game 类比**:规则不能孤立求解,改一个解常破坏其他几个;Password Game 即时告诉你哪些规则坏了,**大项目里从用户工单/事故才知道**——低估任务的常见原因;新手工程师甚至不知道某些 wicked features 存在

**固有还是实现问题?**

- 大部分是**领域模型层的固有**:on-prem——"连'必须小心保持 on-prem 友好'这件事本身都是 wicked feature";新用户类型——"新能力必须适配你的用户能力框架这件事本身是 wicked";无论代码怎么重构,用户流程图层面的问题必须回答
- 笨拙实现也能把任何功能变 wicked(isAttachmentRequest 标志复用 API)——两因并存,不能全推给"skill issue"

**存在原因**:最有钱的用户爱 wicked features(on-prem/数据本地性/分片 → 企业高价合同);另一部分自找(5 个用户的公司建全量分片=工程师觉得好玩;单一语言应用提取全部字符串=教条/看不到别的路)

**工程师的职责**:阻止不必要的 wicked features;限制必要者的**爆炸半径**——"以'这会影响在建完全无关功能的开发者吗'的眼光做合理分解"

## 与其他页面的关系

- [[theory-building]]:战争迷雾/无人理解的结构性原因——wicked features 的交互行为无法被文档捕获,代码库成为唯一可靠答案源
- [[comprehension-debt]]:理解力差距的**供给侧机制**——系统复杂到禁止理解;onboarding 慢(veterans = 熟悉全部 wicked features 的人)
- [[pure-impure-engineering]]:impure 工程"混战"的附带复杂度来源;纯工程师低估 impure 难度的原因
- [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]]:"数千个无法重实现的 weird cases"的机制——不可重建论成立的原因;重写=切块可行的前提是能切得开 wicked features
- [[intent-debt]]:公司老兵 = 熟悉全部 wicked features 的人——冷启动经济学里"意图文档"的具体内容物;wicked features 的交互行为常无自觉意图(涌现,见 [[2025-12-24-nobody-knows-how-software-products-work|nobody-knows]])
- [[distillation-anxiety]]:wicked features 知识是最难显性化的隐性知识(从不在任何文档里)——AI 时代新人(含代理)无法"问老兵"时的暴露面
- 实体: [[sean-goedecke]]
