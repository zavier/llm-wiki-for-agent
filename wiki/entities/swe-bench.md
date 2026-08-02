---
type: entity
tags: [benchmark, ai-agents, coding]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [agentic-systems, agent-computer-interface, agent-verification, tool-evaluation]
sources: [2026-08-02-building-effective-ai-agents, 2025-09-11-writing-effective-tools-for-ai-agents]
status: active
---

# SWE-bench

代码智能体基准:基于真实 GitHub issue 的软件工程任务集;Anthropic 的编码代理可仅凭 PR 描述解决其 Verified 子集。

## 关键信息

- SWE-bench Verified:人工验证的基准子集;Anthropic 编码代理可仅凭 pull request 描述解决真实 GitHub issue(来源: [[2026-08-02-building-effective-ai-agents]])
- 任务形态:涉及多文件修改,任务相关文件数与改动性质取决于任务——正是 [[agentic-workflow-patterns|orchestrator-workers]] 的典型场景
- 为何编码是代理最佳应用:答案可被自动化测试验证、可迭代、问题空间结构化、产出可客观度量
- 工具优化实证:构建 SWE-bench 代理时 Anthropic"花在优化工具上的时间 > 整体 prompt";典型失误是相对路径在代理移出根目录后出错 → 改为强制绝对路径后"使用得完美无缺"(见 [[agent-computer-interface]])
- 局限:自动化测试验证功能,人类审查仍必要——确保与更广泛的系统需求对齐
- 工具描述实证(来源: [[2025-09-11-writing-effective-tools-for-ai-agents]]):Sonnet 3.5 在**精确微调工具描述**后达 SWE-bench Verified SOTA——"评测 + 描述提示工程"比换模型更直接的提升路径(见 [[tool-evaluation]])

## 与其他页面的关系

- 用例上下文: [[agentic-systems]]、[[agentic-workflow-patterns]]
- 工具设计: [[agent-computer-interface]];验证驱动: [[agent-verification]]
