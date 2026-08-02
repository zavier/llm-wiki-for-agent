---
type: source
tags: [ai-agents, decision-making, goedecke]
topic: ai-agents
created: 2026-08-03
updated: 2026-08-03
status: active
---

# Engineers who won't commit (2025-02-10)

- 原文: `raw/Engineers who won't commit.md`(AI 直抓版 2026-08-03;curl+pandoc 全文,未经人工裁剪核对,raw frontmatter 由抓取脚本补全)
- 类型: 个人博客文章([[sean-goedecke]]);本 wiki **第四十一篇源文档**
- 出处核实: 发布 **2025-02-10**(站点页头 post-meta 确认);URL slug 为旧名 `taking-a-position`,页面 H1 为现名 "Engineers who won't commit"——[[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]] 引用的 "taking a position" 即此文
- 定位: "带着部分正确的理论工作"的操作技能篇;也是 [[pure-impure-engineering|impure 工程文化]] 的行为规范

## 摘要

当你是房间里最有上下文(或技术/权力)的人,你必须 take a position——即使只有 55-60% 信心。不表态不是谨慎,是懦弱:你把决策推给经理,并默许最终被做出的决定(最坏情况:weakest-but-loudest 工程师趁机推一个糟糕透顶的主意)。经理对错误判断宽容,但"错太多"会失去信任。例外:信任破裂的环境(估算落空会被 PIP)不批评沉默。

## 关键主张

- **义务触发条件**:"房间内最有上下文/技能/机构权力的人"必须表态;与同级技术同事讨论时随意
- **不表态的三重代价**:①逼上下文更少的人自己猜(随机猜测)②最坏情况 weakest-but-loudest 工程师趁机推糟糕主意 ③经理被迫做本该你负责的技术决策——"不表态 = 默许最终被做出的决定"
- **动机分析**:不肯表态常不是理性谨慎,而是**病理性害怕犯错**(公开出错会难受很久);这种恐惧有用(逼自己努力正确),但也使给出可能大错的 educated guess 变得情感困难——看清它的本质:懦弱
- **纠错成本被低估**:经理自己天天做 educated guess,对错误技术判断宽容("错误方向至少给你信息/迭代基础");真正毁信任的是**错得太多**("being right a lot")或一次性大错(事故方案造成更严重事故)
- **聪明的回避**:估算场景——不给估算,经理只会叹气然后自己猜;但信任破裂的公司(估算落空有真实不公平后果)里,回避是理性防御,不批评
- **summary 五条**:不表态=默许最终决定 / 极端情况把技术决策推给经理 / 决策越难越应接受不确定性 / 仅适用于功能正常的环境 / 害怕是真实的但还是要做
- 工作 vs 工作外(脚注):工作内为 TypeScript 辩护(~60% 信心);工作外对"强类型是否更好"不下立场——表态义务限于被付钱的语境

## 与现有 wiki 的关系

- 更新 [[cognitive-surrender]]:第三路径(take a position)一手化,并补一种区分——surrender = 无独立观点(决策缺席),non-committal = 有观点但拒绝承担(责任缺席)
- 更新 [[theory-building]]("带着部分正确的理论工作"的技能侧)、[[sean-goedecke]]
- 呼应 [[2026-07-11-in-defense-of-not-understanding-your-codebase|in-defense]]:"如果你称职,那个人就是你"的出处即本文+confidence 系列
- 可发展与 [[pr-contract]] 对照:表态义务 = 决策者侧的担责义务(评审侧证据义务的镜像);暂不展开

## 待办 / 后续

- 无强待核项;可考虑与 [[agent-management]] 对照:"代理不表态/全盘表态"两种失败模式(未展开)
