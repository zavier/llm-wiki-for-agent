---
type: entity
tags: [organization, agent-tools, coding-agent]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [claude-code, openai, anthropic, harness-engineering, tool-evaluation]
sources: [2026-04-30-cursor-agent-harness-improvement]
status: active
---

# Cursor

Anysphere 的 AI 编码 IDE/智能体产品(Composer、云端智能体、子智能体);与 [[claude-code]]、Codex 并列的主流编码代理阵营。

## 关键信息

- 身份:AI 优先的代码编辑器与编程智能体(Cursor IDE);Composer 模式、云端智能体(cloud agents)、子智能体(subagents)、automations
- 技术立场:框架工程是智能体成功的关键,未来只会更重要;多智能体编排将内建于框架
- 工程实践:双层评测(离线 CursorBench + 在线 A/B)、**Keep Rate** 在线质量指标、按模型定制工具格式(OpenAI patch vs Anthropic str_replace)、工具错误分类与异常检测告警(见 [[tool-evaluation]])
- 与 Anthropic/OpenAI 的关系:三方互为产品与工程实践参照;Cursor 同时支持两家模型并按各自训练格式定制框架——是"模型-harness 耦合"的最佳实证
- 关联文章:Auto-review 管控智能体自主性、云端智能体经验、autoinstall 自举 Composer

## 与其他页面的关系

- 实践细节: [[2026-04-30-cursor-agent-harness-improvement]];框架理论: [[harness-engineering]]
- 竞品对照: [[claude-code]]、[[openai]]
