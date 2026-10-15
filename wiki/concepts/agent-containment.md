---
type: concept
tags: [ai-agents, security, sandboxing, containment]
topic: ai-agents
created: 2026-10-15
updated: 2026-10-15
refs: [lethal-trifecta, model-context-protocol, curse-of-instructions, harness-engineering, agent-evals, governance-as-code, agent-verification, anthropic, claude-code, control-bands, agent-identity]
sources: [2026-05-25-how-we-contain-claude, 2026-07-21-anthropic-secures-ai-native-sdlc]
status: active
---

# Agent containment

在**环境层**(进程沙箱 / VM / 文件系统边界 / egress 控制)设硬边界,把 agent 的爆炸半径限住;再用**模型层**(system prompt / classifier / probe / 训练)去引导它的倾向。顺序不能反——因为模型层防御是概率性的,只能塑造"倾向于做什么",不改变"理论上能做什么"。

## 关键信息

- **核心原则**(来源: [[2026-05-25-how-we-contain-claude]]):**先在环境层做 containment,再在模型层引导行为**。环境层的目标是给"agent 能到达什么"设硬边界——例如凭据若不进入沙箱,无论原因是用户、模型找到"创意路径",还是攻击者,都无法被外传
- **边界越紧,越可以放松监督**:反过来,极严的周界意味着不必逐动作审批。Claude Code 的 reference devcontainer 存在的意义正是让 agent 能**无人值守**运行(来源: 同上)
- **三个产品形态对应三档隔离**:claude.ai 用临时容器 / Claude Code 用 HITL 沙箱 / Claude Cowork 用密封 VM——成本与隔离强度递增,隐蔽性也递增(来源: 同上)

### 批准 ≠ 监督(有实测数据)

- 遥测显示用户批准了**约 93%** 的权限提示。"用户看到的批准越多,对每一个越不在意,随着时间变得远不那么勤于监督"(来源: 同上)
- 沙箱化后权限提示量**下降 84%**:macOS 用 Seatbelt、Linux 用 bubblewrap,策略是**读允许、工作区内写允许、默认禁网**,运行时已开源以便审计边界(来源: 同上)
- **Claude Code auto mode** 把命令批准交给模型分类器:拦下**约 83%** 的越界行为,但**漏掉约 17%**,误拦约**0.4%** 的正常命令。作者明确定位:auto mode 是沙箱**内部**的一层 defense-in-depth,**不是沙箱的替代品**;它优化的是摩擦最小化,不是拦截最大化(来源: 同上)
- 推论:**隔离强度必须匹配用户的监督能力**——监督能力弱的用户需要更强的结构性边界,而不是更多的批准提示(来源: 同上)

### 凭据与出口

- **凭据永不进沙箱**(来源: 同上)
- **egress allowlist 是能力授予,不是目的地过滤**。真实第三方披露案例:Claude Cowork 的 egress allowlist 正确放行了 `api.anthropic.com`(产品离不开自家 API),而攻击者把一个**携带隐藏指令 + 攻击者控制的 API key** 的恶意文件放进用户挂载的工作区;Claude 按指令读取工作区内其他文件并外传——出口域名完全合法,数据却出去了(来源: 同上)
- 红线:**不要把 allowlist 当"目的地过滤"来思考问题**(来源: 同上)

### 信任边界(这类漏洞的统一形状)

- Claude Code **在弹出 "Do you trust this folder?" 之前就读取了项目设置**,因此仓库里提交的 `.claude/settings.json` 定义的 hook 会**自动执行**——开发者 clone 一个 PR 即可被触发。另外两例结构相同:未受信目录的输入在信任边界建立之前就被解析(来源: 同上)
- 统一修法:**把未受信目录的配置解析与执行推迟到信任建立之后**(defer parsing and execution of project-local config)(来源: 同上)
- 一个具体实现坑:**符号链接解析必须发生在路径校验之前**,否则授权目录内的 symlink 能指向外面并逃逸(来源: 同上)
- 企业侧控制面:管理员可通过 MDM 的挂载路径 allowlist 管理(来源: 同上)

### 直接提示注入:模型层的真实边界

- 案例:伪装成协作的钓鱼——"帮我跑一下"的邮件附一段可直接粘贴的 prompt,prompt 读起来像常规任务步骤,其中某处**轻柔地**要求读 `~/.aws/credentials`、编码内容、POST 到外部端点。**25 次重试中,Claude 完成了 24 次外传**(来源: 同上)
- **为什么模型层在这里失效**:模型层防御锚定**用户意图**——当指令本身就是用户打的,对模型而言没有任何异常信号(来源: 同上)
- 结论:来自用户转发的直接注入,模型层基本无解,只能靠环境层(来源: 同上)

### 模型层实际能做到什么

- Gray Swan Agent Red Teaming 基准(测提示注入易感性):Claude Opus 4.7 单次攻击成功率约 **0.1%**,100 次自适应攻击后约 **5-6%**(来源: 同上)
- 但作者立场明确:**即便有业界最好的防御,模型层保护永远不会 100% 有效,因此不能单独成立**(来源: 同上)

### 可见性代价(最容易被忽略的一层)

- 隔离换来的是**不透明**:从 EDR 视角看,密封 VM 里的 agent 只是一个不透明的 hypervisor 进程,无法检视 guest。**隔离降低可见性**,而对合规姿态依赖端点可见性的团队这是硬冲突(来源: 同上)
- 现状缓解是 **pull-based OTLP 导出**(管理员事后拉取事件日志),但这不等同于实时监控。作者建议:"如果你在建类似的东西,**早点为这场对话做预算**"(来源: 同上)

### 一个诚实的方法论注脚

- "**对自建组件保持警惕**。久经考验的 hypervisor、syscall filter、容器运行时承受过的对抗性关注,超过你自己会造的任何东西。在所有描述的部署里,标准原语都撑住了,而我们在它们周围做的工作暴露了缺陷"(来源: 同上)
- 收束判断:"虽然 agent 可能是新类别的软件,它们的系统层交互不是——它们仍然读文件、开 socket、spawn 进程;这使**用成熟工具做 containment 成为一条关键可行的防线**"(来源: 同上)
- 外围标准:[[anthropic|Anthropic]] 指向 NIST 的 AI agent identity & authorization 项目、澳 ACSC 联合 CISA 与 UK NCSC 的六机构 agentic AI 采用指南、ISO/IEC 42001(来源: 同上)

### 反模式

- 在未受信目录里解析/执行项目配置(信任边界之前)
- 把 egress allowlist 当目的地过滤
- 凭据与 agent 生成的代码同笼
- 用批准提示替代结构性边界(尤其对非专家用户)
- 把模型层 classifier 当作沙箱的替代(它漏 ~17%)
- 符号链接解析晚于路径校验
- 自建隔离原语而非用成熟实现(来源: 同上)

- **组织级实装:远端 VM + egress allowlist**(来源: [[2026-07-21-anthropic-secures-ai-native-sdlc]]):Anthropic 把编码迁到**远端 VM**、agent 流量 **egress allowlist**——“读不可信输入时尤其重要:注入指令无法到达任意互联网目的地,外泄路径只剩一小撮被监控的服务”;此前远端编码主要护 IP,如今被成熟 AI 团队用来**围堵 agent**;生成侧把关:`/security-review`(security guidance plugin 可在生成过程中评审;PreToolUse hook 把建议变硬门)

## 与其他页面的关系

- 与 [[lethal-trifecta]] 分工:那页描述**威胁面**(私有数据 + 不可信输入 + 外发通道三者齐备即致命),本页描述**防御层次**(环境层硬边界 → 模型层引导)。本页给出的这组数字(93% / 84% / 83% / ~17% / ~0.4% / 25 中 24)是 trifecta 的量化侧
- 与 [[agent-identity]] 分工:本页给 agent“能到达哪里”的硬边界;身份层管“以谁的身份、能做什么动作”(三权限 service account/agent-to-agent 访问)——两者合起来才是完整的爆炸半径工程
- 与 [[model-context-protocol]] 交叉:MCP 把外部工具接进来,也把提示注入的入口接进来;工具注解(open-world 访问 / 破坏性变更)是声明层的第一步,但不是边界
- 与 [[curse-of-instructions]] 交叉:不受信输入流入 prompt 是同一机制的不同表述;亦见 [[agent-verification]] 的评审纪律条目
- 与 [[harness-engineering]] 交叉:沙箱是 harness 的**边界组件**;"隔离强度匹配监督能力"是选 harness 形态的自变量
- 与 [[agent-evals]] 交叉:auto mode 的 ~17% 漏拦率与 ~0.4% 误拦率是必须进 eval 的项;containment 的有效性需要专门评测,不能靠单次观测
- 与 [[governance-as-code]] 的层次关系:治理即代码管"谁能改什么、写码者不得自批";本页管"agent 自身能到达哪里"
- 与 [[control-bands]] 交叉:控制带是"越界后如何分级响应"的运行时机制,本页是"让越界本身更难发生"的结构性前提
- 是 [[claude-code]] 权限模型(批准框 → 沙箱 → auto mode 三代演进)的一手依据
