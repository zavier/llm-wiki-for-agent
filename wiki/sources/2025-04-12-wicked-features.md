---
type: source
tags: [ai-agents, complexity, goedecke]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-03
status: active
---

# Wicked features (2025-04-12)

- 原文: `raw/Wicked features.md`(AI 直抓版 2026-08-03;curl+pandoc 全文,未经人工裁剪核对,raw frontmatter 由抓取脚本补全)
- 类型: 个人博客文章([[sean-goedecke]]);本 wiki **第四十三篇源文档**
- 出处核实: 发布 **2025-04-12**(站点页头 post-meta 确认)
- 定位: Goedecke "部分理解"体系的**机制层**——[[2025-12-24-nobody-knows-how-software-products-work|nobody-knows]] 自述"详细版在此"、[[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]] 的"数千个 weird cases"、[[2025-06-22-pure-and-impure-engineering|pure/impure]] 的"混战复杂度"都以此为因

## 摘要

wicked features = **必须每次建任何其他功能时都考虑的需求**(新用户类型/on-prem 版/跨库分片/数据本地性/跨区域迁移/i18n)。它们像 Password Game:规则不能孤立求解,改一个解常破坏其他几个——大项目里你从用户工单/事故才知道哪些坏了,这是低估任务与新手被击穿的常见原因。大部分 wicked features 是**领域模型层的固有**(无论代码怎么重构都要回答"每个用户类型都能用这个新能力吗"),不是实现问题;最有钱的客户爱它们(on-prem/本地性/分片 → 企业高价合同),另一些是过度工程自找的。工程师的职责:阻止不必要的,限制必要的爆炸半径。

## 关键主张

- **定义**:给 todo 加图片附件是大功能但不是 wicked;同时提供 webapp + 独立可执行文件是 wicked——"must be considered every time you build any other feature"
- **连锁问题**(图像附件示例):新用户类型能用吗?on-prem 没有 S3 图片存哪?分片库的 images 表分片了吗?每个区域都有 bucket 吗?跨区域迁移自动搬图吗?新字符串翻译预算了吗?
- **Password Game 类比**:规则必须成组求解;Password Game 仁慈地即时告诉你哪些规则坏了,**大项目里你从用户工单/事故得知**——低估任务的常见原因;没待过公司的工程师甚至不知道某些 wicked features 存在("**公司老兵的价值主要因为他们熟悉全部 wicked features**")
- **固有性论证**:on-prem——"连'必须小心保持 on-prem 友好'这件事本身都是 wicked feature";新用户类型——"新能力必须适配你的用户能力框架这件事本身是 wicked";wicked 在用户流程图层面,不在实现层面;当然,笨拙实现能把任何功能变 wicked(footnote:isAttachmentRequest 标志复用 API)——两因并存
- **存在原因**:最高付费用户爱 wicked features(on-prem SaaS 对企业合同极赚钱;本地性/分片同);另一部分自找——5 个用户的公司建全量分片(工程师觉得好玩)、单一语言应用提取全部字符串(教条/看不到别的路)
- **工程师最有价值的事**:阻止不必要的 wicked features;**限制必要者的爆炸半径**——以"这会影响在建完全无关功能的开发者吗"的眼光做合理分解
- **summary 五条**:定义/复杂度与协调成本/部分不可避免(高付费企业用户)/部分自找(过度工程、教条、品味)/好工程师限制爆炸半径

## 与现有 wiki 的关系

- 新建概念页 [[wicked-features]];更新 [[theory-building]](战争迷雾的结构性原因)、[[comprehension-debt]](禁止理解的供给侧机制)、[[pure-impure-engineering]](混战复杂度来源)、[[sean-goedecke]]
- 互证:"老兵 = 熟悉全部 wicked features" ↔ [[intent-debt]] 冷启动经济学的"四年老工程师 = 意图文档"(具体内容物);"工单/事故才知道规则坏了" ↔ 认知债警告信号(犹豫变更/意外结果);Password Game 即时反馈 vs 大项目延迟反馈 ↔ [[2026-04-07-cognitive-parallel-agents|认知并行]] 的反馈延迟讨论(弱相关,不展开)
- 与 [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]] 的"成功重写 = 切块"闭合:wicked features 切不开就不能重写

## 待办 / 后续

- "wicked features 数量 × 团队规模的翻车曲线"无数据——量化开放问题(见主题页)
- 与 [[2025-02-10-engineers-who-wont-commit|take a position]] 的交互:老兵的 wicked features 知识 = 其"最有上下文者"资格的基础(未展开)
