# LLM Wiki

基于 [karpathy 的 LLM Wiki 模式](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)落地的个人知识库脚手架。

**核心思想**:不用 RAG 那种"每次现查现拼",而是让 LLM 增量维护一份持续编译、互相引用的 markdown wiki。你负责找资料和提问,LLM 负责摘要、交叉引用、记账——知识复利增长。

## 目录结构

```
llm-wiki/
├── AGENTS.md          # ★ schema:LLM 维护 wiki 的"工作合同"(三个工作流都在这)
├── raw/               # 不可变原始资料,只属于你,LLM 只读
├── wiki/
│   ├── index.md       # 全库目录(内容导向)
│   ├── log.md         # 只追加流水账(时间导向)
│   ├── entities/      # 实体页:人、组织、产品、作品
│   ├── concepts/      # 概念页:想法、术语、方法
│   ├── sources/       # 来源页:每个 raw 文件对应一页,YYYY-MM-DD-slug.md
│   ├── syntheses/     # 综合页:跨来源的论点/对比
│   ├── answers/       # 沉淀下来的问答
│   ├── _templates/    # 页面模板(复制即用)
│   └── _examples/     # 示例页(咖啡主题演示,可删)
└── scripts/lint.sh    # 结构体检:孤儿页、断链、index 漂移等
```

## 快速开始

```bash
cd ~/code/llm-wiki
pi "读取 AGENTS.md,然后告诉我 wiki 当前状态"        # 或 Claude Code / Codex / Cursor
```

以后的工作流就三句话(具体步骤 AGENTS.md 里都有):

| 操作 | 对 agent 说 |
|---|---|
| **摄入** | `摄入 raw/<文件>,先和我讨论要点,再更新 wiki 并追加 log` |
| **查询** | `根据 wiki 回答:<问题>(给出引用)` |
| **体检** | `运行 scripts/lint.sh 并修复问题,再手动检查矛盾/过期/孤儿概念` |

## 使用建议

- **Obsidian 打开 `wiki/` 目录**:用 graph view 看页面间连接,双链跳转阅读。wiki 就是一堆 markdown,任何编辑器都能用。
- **答案回填**:好问答别留在聊天记录里——让 agent 存成 `wiki/answers/` 页面,探索也复利。
- **矛盾处理**:新资料推翻旧说法时,旧页标 `status: superseded` 并链接新页,不静默改写历史。
- **版本历史免费送**:整个目录就是 git 仓库,已初始化。

## 定制

- schema 在 `AGENTS.md`,觉得约定不顺就改,LLM 会照新约定干活。
- 页面模板在 `wiki/_templates/`,新增页面类型照抄一个。
- `wiki/_examples/` 是演示页,看完可整个删掉。
- 规模大了(几百页后)再考虑加搜索(qmd 之类),初期 index.md 完全够用。

## 三条纪律(AGENTS.md 中固化)

1. `raw/` 不可变 —— LLM 永远不碰它
2. `log.md` 只追加 —— 历史不改写
3. 摄入时同步更新所有相关页面与 index —— 靠 lint 兜底防漂移
