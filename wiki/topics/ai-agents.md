---
type: topic
tags: [ai-agents, spec-writing, research]
created: 2026-08-02
updated: 2026-08-02
status: active
---

# AI Agents(规范驱动开发研究)

追踪"如何让 AI 编码代理高质量、可预期地实现功能"——spec 写作、上下文工程、验收与反馈闭环。

## 核心页面

- [[ai-agent-spec]] — spec 写作框架:五原则 + 六区域清单
- [[spec-driven-development]] — 四阶段门禁流程(Specify → Plan → Tasks → Implement)
- [[ai-feature-implementation-loop]] — 综合:从 spec 到落地的五层闭环
- [[conformance-testing]] — 验收的客观标准
- [[context-engineering]] — 上下文切片与模块化
- [[2026-01-13-good-spec-for-ai-agents]] — 首篇源文档(Addy Osmani)

## 当前状态 / 进展

- 已摄入 1 份源文档;综合页完成:"失败四主因 → 五层落地闭环"
- 实证基础:GitHub 2,500+ 配置文件分析、curse of instructions 研究
- 相关实体:[[addy-osmani]]、[[simon-willison]]、[[github]]、[[anthropic]]

## 开放问题

- "curse of instructions"原始论文的适用范围与实验规模待核实
- GitHub 2,500+ agents.md 分析的六区域统计口径待核
- 并行多代理的协调成本与写冲突——收益目前以轶事为主
- LLM-as-a-Judge 与自验证的共同盲区问题未解
- 过度规范的量化边界("spec 详细度 vs 任务复杂度")未定

## 相关主题

- 暂无其他主题;新主题起步时可复用本主题的页面类型与模板
