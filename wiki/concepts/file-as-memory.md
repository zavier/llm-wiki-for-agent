---
type: concept
tags: [memory, context, architecture]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [context-engineering, agentic-memory, progressive-disclosure, long-running-agents, agent-readability, openai]
sources: [2025-10-06-file-system-is-the-new-database, 2026-08-02-effective-context-engineering-for-ai-agents, 2026-08-02-effective-harnesses-for-long-running-agents, 2026-02-11-codex-agent-first-engineering]
status: active
---

# File-as-memory

文件系统即记忆:用 Git 版本化的纯文件(Markdown/YAML/JSONL)作为代理的持久记忆层——无数据库、无向量库、无构建步骤,人机同读。

## 关键信息

- 定义与实践(来源: [[2025-10-06-file-system-is-the-new-database]]):80+ 文件 + Git 仓库 = 个人 OS;克隆到任何机器、指向任何 AI 工具即运行;零依赖、全可移植、全版本化
- **格式-功能映射**(每个格式一个理由):
  - JSONL 日志:追加式(防覆盖 bug——JSON 被代理整体重写会丢历史)、流式逐行读(不解析全文件)、行自包含;删除 = 标记 `status: archived` 保历史
  - YAML 配置:层级清晰、支持注释(给代理的注解不污染数据结构)、人机可读
  - Markdown 叙事:LLM 原生、随处渲染、Git diff 干净
  - 每个 JSONL 以 schema 头行开始(`_schema/_version/_description`),代理读数据前先知道结构
- **追加式不可妥协**:实践者的最大教训——"代理可以加数据,不能毁数据"
- **情景记忆**:experiences/decisions/failures 三日志存"判断"而非仅事实(情感权重、推理、备选方案、根因与预防)——"有你的文件 ≠ 有你的判断";failures 日志最值钱(见 [[agentic-memory]])
- **跨模块引用**:flat-file 关系模型(contact_id/pillar 跨文件 join);模块隔离加载、连接推理——"没有连接的隔离只是文件夹堆"
- 理论依据(来源: [[2026-08-02-effective-context-engineering-for-ai-agents]]):just-in-time 检索——文件系统是外部索引,镜像人类认知(书签/文件系统而非记忆全文);文件命名/目录/时间戳 = 元数据信号
- 元观察:本 wiki 自身即此类架构(index/log/refs/sources 全为文件);pi/Claude Code 的 CLAUDE.md、skills 目录同理
- **harness 实例**(来源: [[2026-08-02-effective-harnesses-for-long-running-agents]]):Claude Agent SDK 长时任务本身就是文件即记忆——`claude-progress.txt`(进度日志)、`feature_list.json`(特征清单 + passes 门禁)、`init.sh`(环境脚本)、git 历史(可回退);选 JSON 而非 Markdown 的决策与格式-功能映射同构("模型更不易改写 JSON");"每个会话从零开始"迫使记忆外置为文件读写协议(见 [[long-running-agents]])
- **仓库即记录系统**(来源: [[2026-02-11-codex-agent-first-engineering]],OpenAI):零人工代码实验把整个仓库当记忆——AGENTS.md 内容目录 + 结构化 docs/(exec-plans 版本化、design-docs 带验证状态、references 的 llms.txt);**"运行时上下文之外的一切都不存在"**(Google Docs/聊天记录/人脑不可访问),Slack 讨论必须推入仓库;执行计划是一等工件(active/completed/tech-debt 全版本化);doc-gardening 代理维持新鲜度(见 [[agent-readability]])

## 与其他页面的关系

- 理论与 [[context-engineering]] 对接;记忆内容见 [[agentic-memory]];加载机制见 [[progressive-disclosure]]
