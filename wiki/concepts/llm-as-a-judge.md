---
type: concept
tags: [evaluation, llm]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, anthropic, agentic-workflow-patterns, tool-evaluation, multi-agent-systems, self-reflection, context-anxiety, pr-contract, agent-verification]
sources: [2026-01-13-good-spec-for-ai-agents, 2026-08-02-building-effective-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents, 2026-08-02-how-we-built-our-multi-agent-research-system, 2023-06-23-llm-powered-autonomous-agents, 2026-08-02-harness-design-for-long-running-apps, 2026-01-07-ai-code-review, 2026-06-15-agentic-code-review]
status: active
---

# LLM-as-a-judge

用第二个 LLM(或独立 prompt)评审第一个代理的输出,针对难以自动测试的主观标准:代码风格、可读性、架构模式遵循。

## 关键信息

- 适用场景:语法检查覆盖不到的**语义/主观评估**(来源: [[2026-01-13-good-spec-for-ai-agents]])
- 典型用法:"对照我们的风格指南审查这段代码,标记违规";评审反馈要么被采纳、要么触发重写
- 与自验证互补:自验证(把输出对照 spec 要求清单逐项核对)抓"遗漏",judge 抓"主观质量"
- 循环化形态(来源: [[2026-08-02-building-effective-ai-agents]]):evaluator-optimizer 工作流——生成-评估-反馈循环迭代;适用条件:有清晰评估标准 + 迭代有可测收益(见 [[agentic-workflow-patterns]])
- Anthropic 等团队已证实其对手写评估的有效性(同源引用)
- verifier 角色(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]]):[[tool-evaluation|工具评测]]中 Claude 可作结果判分(精确字符串比较的进阶版)——但避免过度严格的 verifier(格式/标点/合法变体误杀正确回答)
- 生产级 rubric(来源: [[2026-08-02-how-we-built-our-multi-agent-research-system]]):Claude Research 用**单次 LLM 调用**输出 0.0-1.0 分 + pass/fail,评估 事实准确性/引用准确性/完整性/来源质量/工具效率——比多 judge 更一致、更贴人工判断;评测"立即小样本启动"(约 20 条真实查询,提示微调 30%→80%);人工测试抓自动化漏掉的(早期偏好 SEO 内容农场,加来源质量启发式修正);有明确答案的用例 judge 最有效(见 [[multi-agent-systems]])
- **早期反证**(来源: [[2023-06-23-llm-powered-autonomous-agents]],ChemCrow 2023):LLM 自评 GPT-4 ≈ ChemCrow,人类专家评审却显示 ChemCrow 大幅领先——深度专业领域 LLM"不知道自己的缺陷",无法判断结果正确性;用 LLM 评自己的输出在专业领域有系统性盲区,需要领域专家人工评审兜底
- 与 [[self-reflection]] 区分:judge = 独立主体评审;自反思 = 同主体反思轨迹
- **独立评估器胜过自评**(来源: [[2026-08-02-harness-design-for-long-running-apps]]):让代理评价自己的工作,它会自信地夸奖平庸结果(主观任务尤甚)——"把干活的和评分的分开"是强杠杆;独立评估器仍是 LLM、仍偏宽松,但"把独立评估器调成多疑远比让生成器批判自己可行"(Anthropic Labs 的 GAN 式 generator-evaluator 实证,见 [[agentic-workflow-patterns]])
- 评估器校准法(来源: [[2026-08-02-harness-design-for-long-running-apps]]):few-shot 评分样例 + 详细分数分解对齐人类偏好、减少跨迭代漂移;评估器带 Playwright MCP **操作活页面**再打分(截图/点击),比评静态快照更准;评估器质量要专门调优——开箱即用的 Claude 是差劲 QA:发现真问题后"说服自己不严重"而放行、测试表面化不探边界;调优 = 读日志找与人类判断的分歧 → 更新 QA prompt,多轮迭代
- **评估器价值边界**(来源: [[2026-08-02-harness-design-for-long-running-apps]]):评估器不是固定开关——任务在模型可靠 solo 能力内时是纯开销,在能力边界外才有真实提升;模型换代后要重新评估(Opus 4.5 → 4.6 时评估器从每 sprint 必评降为终评一次)
- **评估器盲区与模态限制**(来源: [[2026-08-02-harness-design-for-long-running-apps]]):"Claude 听不见"——DAW 的音乐品味反馈环失效;与浏览器自动化看不到原生 alert 模态框同族:验证器感知受模型输入模态限制(见 [[context-anxiety]]、[[agent-verification]])
- **评审器异质性:对抗性评审的实证**(来源: [[2026-06-15-agentic-code-review]],Osmani 转述非厂商实验):4 个评审器并行(CodeRabbit/Sentry Seer/Greptile/Cursor BugBot),146 真实 PR/679 findings/3.5 周——**617 个标记位置 93.4% 恰好只被一个工具抓到、6% 两个、几乎无三个、四个一个都没有**;每个强在不同类别(Greptile 正确性/架构近零假阳性;CodeRabbit 网最广+一键修复;Seer 生产故障严重性)——"四份同模型 = 一个评审员加更大的发票";厂商基准(有立场):CodeRabbit Martian F1 ~49% precision 最好 recall;Greptile ~82% vs 44% bug-catch(假阳性更多);Anthropic Code Review <1% 发现被工程师标错 + 内部实质评审率 16%→54%;"没有单一最佳"——高端场景跑两个性格不同的(互补对:Greptile+Seer),solo 一个好评审器+真测试;每个基准都特定于某代码库,在自己代码上测量;隐含原则:**异质性是强于同源规模的杠杆**——与 maker/checker 分裂同族,但进一步:不是"多一个评审",而是"多一类盲区覆盖"(见 [[agent-verification]])
- **AI 评审工具的现实**(来源: [[2026-01-07-ai-code-review]]):体验两极——有的团队抓到 95%+ bug,有的视为"文本噪音";需认真配置(灵敏度、关无用评论类型、opt-in/opt-out);配置得当可抓 70-80% 低垂果实(Graphite,二手);多模型评审(生成与审计用不同模型)抵消偏差;定位 = 一审非终审(spellcheck 非编辑),人类签字不可替代(见 [[pr-contract]])
- 是 [[ai-agent-spec]] 质量门的一环;可用便宜/小模型承担评审角色以降本

## 与其他页面的关系

- 见 [[ai-agent-spec]] 原则 4;实践方: [[anthropic]]
- 与 [[conformance-testing]] 分工:一致性测试管"对错",judge 管"好坏"
