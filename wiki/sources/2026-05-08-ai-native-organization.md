---
type: source
tags: [ai-agents, organization, management, alibaba]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# AI Native 时代——研发组织何去何从 (2026-05-08)

- 原文: `raw/AI Native 时代 —— 研发组织何去何从.md`
- 类型: 技术公众号长文(阿里技术,**发布于 2026-05-08**,frontmatter 已标注);阅读时长 25 分钟
- 作者: [[xu-xiaobin]];发布方: [[alibaba]]
- 备注: 本 wiki 第二十篇源文档;**首个中文原创源**(前两篇中文为英文译文)与**首个组织设计视角**;内容大量转述第三方案例与文献([1]-[6] 引用),全部数据为内部访谈/调研,均待核实;文中图片 URL 触发安全警告(疑似 exfiltration 参数),图片未提取,仅文本入录

## 摘要

从"组织为什么存在"的底层问题出发:两千年组织演化史(罗马军团嵌套 → 普鲁士总参谋部 → 铁路组织图 → Taylor)本质上都在解决同一件事——**信息怎么路由**,核心约束是人的管理跨度(3-8 人);所有组织设计(康威定律、人月神话、manager 评价制)都是"人的协作物理学"的镜像。AI 是新协作主体(与人镜像反面:无沟通衰减、无需激励、无 context switching 成本),以人形约束为前提的设计前提开始失效。据此提出:**Org Chart → Execution Graph** 范式转换、**Harness 层 + Hive Mind 层**双层组织、**管理塌缩**(非消失)、**Architect 角色**、**Platform 三柱架构**、**蒸馏焦虑**,并给出三案例与五条关键判断。

## 关键主张与数据

**内部访谈数据**(4 位深度使用 AI 的工程师,二手,待核)

- 写代码占比 30%→5%;与 Agent 对话占比 5%→60%;查问题时间下降一半以上;纯编码效率 **10×** 但**端到端需求交付只提升 2-3×**——瓶颈不在编码本身;同日迭代案例:上午 10 点上线新功能、中午 A/B、下午 3 点按数据下线、5 点上线更好版本(过去需 6 周)
- 先锋团队形态:3-5 人垂直功能小组(无产品/前端/后端边界)、需求评审驱动 → **成果评审驱动**、**决策权与开发权分离**(决策权在领域专家,开发权交出)
- 反例:同一 3 人小组两阶段对照——有自主权项目士气行业前沿,转入他人主导项目(贡献关键但汇报不提名字)后士气崩塌——**"可见性 ≠ 被看见"**(commit 都在 ≠ 管理者念名字)

**大规模 AI 化调研**(数百条原声,内部,二手,待核):所有岗位所有层级提及频次最高、断崖式领先的是**"系统打通与数据整合"**,不是模型能力——员工当**"人肉中间件"**(从各系统手动导出数据喂给 AI 再搬回);结论:新瓶颈不是 AI 能力不够,是**系统的信息形态不够**("信息形态的人形偏置");工程师同事归纳 **AI 友好 5 维度**:测试完备性、环境完备性、架构合理性(无循环依赖、无跨服务隐式调用)、端到端测试可执行性、文档充分性——"能用是因为人聪明,不是因为它 AI 友好"

**组织范式**(转述 Ken Huang《What is an Agentic AI Native Organization?》,2026-02):组织最小单元从"人+长期关系网"换成"**任务+上下文+权限+工具**"(机器可读 artifact);核心问题从 ownership("谁拥有这件事")变成 **routing + governance**("意图从哪进入、怎么翻译成行动、什么约束保证安全");reorg 成本从季度级(6-12 个月)压到 **week 级**;Agent 是新员工类——需 onboarding/scoping/supervision/offboarding,**四不对称:可无限复制、同小时既 brilliant 又 brittle、compliance-blind by default、fast enough to fail at scale**

**Platform 三柱架构**(Ken Huang):①Agent Platform Group——中央团队,runtime 标准/权限/日志/可观测/评估 harness/安全部署("production engineering plus governance,不是浪漫的 AI research")②Domain Teams——own outcomes rather than models,3-5 人垂直小组 ③Risk and Oversight——**"免疫系统,不是官僚刹车"**("不出事是乐观主义,是疏忽——错误可以快速传播的世界里");6 项基本功:枚举 agents、权限纪律、梯度自治、日志、评估 harness、事故响应——"都不性感,但基础设施工作有复利"

**管理塌缩(不是消失)**:Peter Pang(CREAO CTO)管人时间 60%→<10%(二手);Block(Jack Dorsey & Roelof Botha)"永久的中层管理不再必要";传统管理 10 件事命运分化——前四项可被系统替代(战略传导/信息聚合/资源协调/日常决策),重大决策下沉到离客户最近的 DRI、冲突调解随团队变小自然减少,后四项不可替代(激励/辅导/招聘退出/文化建设),**新出现三类:意图教练、身份重建、虚无对抗**;**Architect 是最高杠杆点**——设计教 AI 怎么工作的人(定义能力边界/设计 SOP/建测试基础设施/集成与 triage/"什么叫好"),把组织隐性 know-how 翻译成 AI 可消化形态,必须资深(懂业务/做过/有品味/见过失败模式),产出被 N 个 agent 复用

**双层组织**:底层极度结构化的 **Harness 层**(代码/测试/流水线/文档/世界模型,越结构化越好,AI 主导)+ 上层极度松散的 **Hive Mind 层**(对话/试错/idea 涌现/Yes-and,越松散越好,人主导);Anthropic 案例——精密 Harness 之上运行混乱文化,"结构化是为了释放无结构的协作"(转述 Yegge《The Anthropic Hive Mind》,2026-02,二手)

**三类工作三种治理**(death of ego 的边界):执行类——杀防御性 ego、全透明;优化类——抑制 ego、留批判空间;创新类——**保护生产性 ego**(半私密、不强制广播);一刀切 = 执行高效率 + 创新死亡;生产性 ego 五要素(数月级注意力锚点、"我的"、skin in the game、死胡同期顽固、反共识、凌晨 2 点执着);**AI 无自我连续性(transformer stateless)——创新工作是人的不可替代领域**

**蒸馏焦虑**(自嘲:"把自己蒸馏完,就在组织里没位置了"):员工写 SOP/教 AI 流程 = 知识导出到组织资产,感觉是合作、结构上接近替代;三个后果——①培养断裂(day 1 写代码路径断裂,入门级岗位消失 → 全行业不招 day 1 → 三五年后 senior 池枯竭 = 产业级灾难)②蒸馏焦虑破坏转型(员工藏匿关键知识,而 Harness 工作恰恰需要"说出隐性约定";最优秀的人先走)③行业负反馈环(互相用 AI 替代 → death of expertise 方向互加速);缓解方向:明确 AI 红利分享方式(扩展边界 vs 收缩团队)、真实的"接住"机制、诚实分类岗位变化、评价系统跟着变

**未解决**(作者自认无答案):AI 信任度两难——CR/缺陷分析等高风险环节"**不敢全信、人工又扛不住**";绩效失效——旧依据(老板目击)失效、新依据(artifact 可见 + recognition 主动)未建立;3-5 人小团队是临时最优还是终态(可能的三个临时条件:探索者效应/过渡期人形需求/审稿层价值);**AI 知识资产继承**——员工调教好的 agent 人走时怎么办,无公司有完整方案

**关键判断**:Harness 工作是复利本金(早投入 vs 晚投入是指数差距;失败信号越多 Harness 优化越快 = 飞轮);AI Native 不是又一次 reorg,而是让组织**未来不再需要痛苦的 reorg**(Execution Graph 复利);解决 Architect 激励问题(被威胁的资深工程师 → 被赋能的 Architect:给身份/给权力/给资源);分辨节点类型(执行节点全透明、创新节点保护);**开始做 agent 名册——"你不可能治理你叫不出名字的东西"**

## 引用的外部文献(潜在后续源,均未入库)

- [1] Jack Dorsey & Roelof Botha, *From Hierarchy to Intelligence*, Block Inside, 2026-03
- [2] Conway, *How Do Committees Invent?*, Datamation, 1968
- [3] Brooks, *The Mythical Man-Month*, 1975
- [4] Ken Huang, *What is an Agentic AI Native Organization?*, Substack, 2026-02
- [5] Peter Pang, *Why Your "AI-First" Strategy Is Probably Wrong*, X, 2026-04
- [6] Steve Yegge, *The Anthropic Hive Mind*, Medium, 2026-02

## 与现有 wiki 的关系

- 新建实体: [[xu-xiaobin]]、[[alibaba]];新建概念: [[execution-graph]]、[[hive-mind]]、[[management-collapse]]、[[distillation-anxiety]]
- 更新了 [[agent-readability]](AI 友好 5 维度 + 人形偏置)、[[harness-engineering]](组织尺度 Harness 层 + 复利)、[[comprehension-debt]](人扛隐性成本)、[[anthropic]](Hive Mind 文化,二手)、[[ai-feature-implementation-loop]](组织层)
- 关键互证:编码 10× vs 端到端 2-3× ↔ Osmani"验证是瓶颈,不是生成"(瓶颈在编码之外);"系统信息形态" ↔ [[agent-readability]] 与 [[comprehension-debt]];AI 友好 5 维度 = 可读性三级阶梯的落地清单;信任度两难 ↔ [[pr-contract]] 阵营分歧的第三方中间观察;AI 知识资产继承 ↔ [[file-as-memory]]/[[agentic-memory]] 的组织侧开放问题;蒸馏焦虑 ↔ [[comprehension-debt]](理解力价值的反面:知识转移的成本);Agent 四不对称 ↔ [[cognitive-surrender]] 的治理侧
- **归因差异记录**:文中称"OpenAI 在 2026 年初提出 Harness Engineering"(二手引述)——与 HumanLayer 的"Viv Trivedy 命名"说并存,归因待核实(概念本体无争议)

## 待办 / 后续

- 核实内部数据(访谈 30%→5%、调研断崖第一、Peter Pang 60%→10%)——均为转述,无一手出处
- 跟进 Block / Ken Huang / Peter Pang / Yegge 四篇文献(已有完整引用信息,可作后续 raw 源);"AI Native · 目录"系列是否继续
- Agent 名册与 6 项基本功在公开文献中的落地案例;AI 知识资产继承的行业方案
