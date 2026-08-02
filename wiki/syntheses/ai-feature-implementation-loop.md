---
type: synthesis
tags: [ai-agents, workflow, implementation]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [ai-agent-spec, spec-driven-development, three-tier-boundaries, conformance-testing, context-engineering, lethal-trifecta]
sources: [2026-01-13-good-spec-for-ai-agents]
status: active
---

# 让 AI 更好实现功能:从 spec 到落地的闭环

综合结论:让 AI 高质量实现功能的关键不是"更聪明地提问",而是把功能拆成「规范 → 计划 → 小任务 → 自检 → 反馈」的闭环,在每个环节消除歧义、控制上下文、锁定验收标准。

## 综合论点

基于 [[2026-01-13-good-spec-for-ai-agents]],AI 实现功能失败的四个主因:

| 失败主因 | 表现 | 对应解法 |
|---|---|---|
| 模糊输入 | 含糊的 what/why,spec 太 vague | 六区域清单 + goal-oriented 愿景(见 [[ai-agent-spec]]) |
| 过载输入 | 巨型 prompt 触发指令诅咒 | 模块化任务 + 扩展 TOC/切片上下文(见 [[context-engineering]]) |
| 无验收标准 | 无法判断"做对没有" | 测试 + [[conformance-testing]],spec 里写 Success 节 |
| 无反馈回路 | 一次生成、不迭代 | 门禁流 + 失败即修正 spec([[spec-driven-development]]) |

落地闭环(每层都有具体动作):

1. **规范层** — 高层愿景先行,AI 扩写;六区域齐全;[[three-tier-boundaries|三层边界]] 限定行为;注入领域知识("products-categories 是多对多,别让 AI 猜")
2. **计划层** — Plan Mode 只读规划,先对齐架构/风险/测试策略,无歧义后才允许写码
3. **任务层** — 拆成可独立测试的小任务("建注册端点并校验邮箱"),一次只喂一个任务 + 相关 spec 切片 + 全局约束
4. **质量层** — 自验证清单 + 一致性测试 + [[llm-as-a-judge]] 查主观质量;人始终是 exec in the loop
5. **反馈层** — 测试失败 → 修正 spec 或 prompt → 重新同步代理;spec 是活文档,版本化维护

## 支持与反证

- **支持**:GitHub 2,500+ 配置文件实证("太模糊"是头号失败原因);"curse of instructions"实验(指令越多遵循越差);[[simon-willison]] 的长期实践(一致性测试、测试套件=代理超能力、管理隐喻)
- **反证 / 未解决**:
  - 并行多代理有协调成本与写冲突风险,收益数据尚以轶事为主("出奇有效,但精神上很累")
  - LLM-as-a-Judge 与自验证均非万无一失,可能共同盲区;文章承认"not foolproof"
  - 过度规范对简单任务有负面影响——"spec 详细度要匹配任务复杂度"这条经验规则尚无量化依据

## 开放问题

- "curse of instructions" 原始论文的适用范围:任务规模/指令数量到多少开始显著衰减?是否存在拐点数据
- 好 spec 的合理长度与 token 预算:有没有经验值(如 5k vs 20k 的收益对比)?
- 单代理 + 摘要 TOC vs 多代理并行:对典型项目规模的实测成本/质量对比
- spec-driven 四阶段对大型存量代码库(非绿地)的适配:门禁流的变体实践
- "测试先行"是否等于把 TDD 完整搬给代理:边界在哪(见 [[spec-driven-development]] 的 TDD 类比)
