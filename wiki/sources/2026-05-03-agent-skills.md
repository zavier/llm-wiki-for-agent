---
type: source
tags: [ai-agents, skills, engineering-discipline, addy-osmani]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
status: active
---

# Agent Skills (2026-05-03)

- 原文: `raw/Agent Skills.md`
- 类型: 技术博客([[addy-osmani]],发布于 **2026-05-03**,frontmatter 已标注)
- 备注: 本 wiki 第二十五篇源文档;Osmani 的开源项目 **agent-skills**(github.com/addyosmani/agent-skills,MIT,**27K+ stars**)的设计思想文——"README 没写的那部分":每个设计选择为什么存在、如何映射标准 SDLC 与 Google 工程实践、不装也能偷走什么;wiki 中 Osmani 的 agent-skills 原文(此前仅有人手转述与 Anthropic 官方版)

## 摘要

AI 编码代理的默认行为是走最短路径到"完成"——不问你有没有 spec、不先写测试、不检查信任边界、不关心 PR 在评审者眼里什么样;这与每个资深工程师职业生涯学会避免的失败模式相同。**资深工程师的工作大部分不显现在 diff 里**:显性化假设、写 spec、拆成可评审的块、选无聊的设计、留下正确的证据、把改动缩小到人能审——代理跳过这些,因为奖励信号指向"任务完成"而非"任务完成且设计文档存在"。所以必须把资深工程师脚手架重新钉回去。核心区分:**skill 不是参考文档,是工作流**(带检查点与退出标准);"过程胜过散文、工作流胜过参考、带退出标准的步骤胜过没有它们的文章"——这解释了为什么那么多"AI 规则"仓库实际没用:规则是散文。

## 关键主张

**skill 的定义**:带 frontmatter 的 markdown 文件,情境需要时注入上下文——介于 system-prompt 片段与 runbook 之间;**不是**"关于测试你该知道的一切",而是代理要遵循的步骤序列,检查点产生证据,以定义好的退出标准结束;"把 2,000 字测试最佳实践散文放进去,代理读了、生成像样的文本、跳过实际测试;放工作流进去(先写失败测试→跑→看它失败→写最少代码→跑→看它过→重构),代理有东西可做,你有东西可验证"

**SDLC 六阶段 + 7 条斜杠命令**(仓库 20 个 skill):Define(`/spec`)、Plan(`/plan`)、Build(`/build`,垂直切片)、Verify(`/test`)、Review(`/review`)、Ship(`/ship`)、`/code-simplify` 贯穿底部;与所有健康组织的循环同构——Google:design doc → review → implementation → readability review → launch checklist;Amazon:working-backwards memo + bar raiser;**新东西是:代理默认跳过大多数阶段**;复杂功能可能激活 11 个 skill、小 bug 修复 3 个——路由器(`using-agent-skills` 元 skill)决定哪个适用;"工作流缩放到实际范围,而非假定范围"

**五个承重设计原则**:

1. **Process over prose**:工作流可被代理执行,散文不能;人类团队同理(200 页手册没人读,带检查点的小工作流会真跑)
2. **反合理化表格**(项目中最独特的设计):每个 skill 含一张"代理(或累了的工程师)可能用来跳过工作流的常见借口 + 书面反驳"表——"任务太简单不需要 spec" → "验收标准仍然适用。五行可以,零行不行";"我以后再写测试" → "'以后'是承重词。没有以后。先写失败测试";"测试过了,发吧" → "通过的测试是证据,不是证明。你查运行时了吗?验证用户可见行为了吗?有人类读 diff 吗?";**原理:LLM 极擅长合理化**——会产出听起来合理的段落解释为什么这个任务不需要 spec;**反合理化表格是对代理还没说的谎言的预写反驳**;对人类团队同样有效——工程腐烂大多不是有人选择做坏工作,而是人们接受听起来合理的跳过理由
3. **验证不可妥协**:每个 skill 以具体证据终止(测试过/构建干净/运行时 trace 显示预期行为/评审者签字);"看起来对"永远不够;与 Anthropic harness 恢复、Cursor planner/worker/judge 分裂、长时代理可恢复同源——**代理是生成器,你需要一个独立信号说工作完成了**
4. **渐进披露**:别在会话开始加载全部 20 个 skill,按阶段激活(元 skill 路由器);"每个加载进上下文的 token 都在某处降低性能"——"渐进披露是把 20 个 skill 的库塞进 5K token 槽位而不毒化井水的方式"(见 [[progressive-disclosure]])
5. **范围纪律**:元 skill 编码不可妥协条款——"**只碰叫你碰的东西**":别重构相邻系统、别删你不完全理解的代码、别擦过 TODO 就决定重写文件;"范围纪律是代理 PR 能否合并或被拆掉的最大单一决定因素";对应 Google 评审规范(评审者会拦截做多于一件事的 PR)

**Google DNA**(skills 浸透《Software Engineering at Google》实践):Hyrum's Law(api-and-interface-design:每个可观察行为都会被某人依赖);测试金字塔 ~80/15/5 + **Beyoncé Rule**(test-driven-development:"如果你喜欢它,就该给它上个测试";基础设施改动不抓 bug,测试才抓);**测试里 DAMP 优先于 DRY**(测试代码应读起来像规格说明,哪怕牺牲重复);~100 行 PR + Critical/Nit/Optional/FYI 严重级标签(code-review-and-quality,来自 Google 评审规范;"大 PR 不被评审,被橡皮图章");**Chesterton's Fence**(code-simplification:不理解为什么在那就不移除);主干开发 + 原子提交(git-workflow-and-versioning);Shift Left + 特性开关(ci-cd-and-automation:尽早抓问题,部署与发布解耦);**代码即负债**(deprecation-and-migration:每行留下的都要永久维护,偏好更小表面积);"前沿模型读过'Hyrum's Law'这个短语,但凌晨 3 点设计你的 API 时不会应用它。skill 是确保它会的方式"

**三种用法**:①市场安装(`/plugin marketplace add addyosmani/agent-skills`;斜杠命令自动激活,推荐入门)②把 markdown 丢进任意工具(.cursor/rules/、Gemini CLI、Codex、Aider、Windsurf、OpenCode——"工具不重要,底层工作流才重要")③**当 spec 读**(不装也成立:code-review-and-quality 的五轴框架、test-driven-development 解决"要不要先写测试"争论、元 skill 的五个不可妥协)——作者推荐从第三模式开始:挑 4-5 个贴近你当前痛点的 skill,决定要强制哪些工作流,再装运行时

**不装也偷得走的模式**:反合理化作为团队实践(写下团队对自己说的谎:"发版后再修测试""改动太小不需要设计文档""没事,我们有监控"——配对反驳,放进 AGENTS.md 或工程 wiki);process over prose 用于内部文档(2,000 字的"我们怎么做 X"→ 转成带检查点的工作流,缩到 400 字而且人真会跑);验证作为硬退出标准("产出证据"是每个任务的退出步骤;证据 = 绿测试/截图/日志/评审批准;没有它任务不算完成);渐进披露用于任何规则书(别写 50 页手册,写小路由器指向正确的小章节)

**五条不可妥协**(元 skill 提炼,明天就能进任何 AGENTS.md):①建之前显性化假设(静默持有的错误假设是最常见失败模式)②需求冲突时停下问,别猜 ③该顶回去就顶回去(代理/工程师不是 say-yes 机器)④偏好无聊明显的方案,聪明是昂贵的 ⑤只碰叫你碰的东西——"五行的值得维护的工程文化"

**在 harness 中的位置**:skills 是 harness 的一层(与 AGENTS.md 滚动规则书、hooks 确定性执行、工具、会话日志持久记忆并列,各司其职;skills 干的是"资深工程师流程"的活);**对长时代理比对话式更重要**——长运行放大每个捷径:10 分钟会话跳过测试 = 一个 bug;30 小时会话跳过测试 = 结束时没人记得原始意图的调试考古项目;"运行越长,资深脚手架越要强制执行而非建议";**可移植性**:同一 SKILL.md 在 Claude Code/Cursor(rules)/Gemini CLI/Codex 都能用——"写一次工作流,运行时来执行",这是 markdown+frontmatter 格式买来的、定制 prompt 工程买不到的东西

**收尾**:AI 编码代理是"极其能干的初级工程师,对 diff 之外的工作没有直觉";资深工程工作(显性化假设、控制改动尺寸、写 spec、留证据、拒绝合并无法评审的东西)恰恰是代理除非你让它不可能跳过否则必跳过的部分;**"工作日益变成把纪律编码成代理无法说服自己绕开的东西"**;"即便工程师是模型,资深工程师的那部分工作也不再可选"

## 与现有 wiki 的关系

- 新建概念: [[process-over-prose]](工作流 vs 散文)、[[anti-rationalization-tables]](借口→反驳表,从 [[cognitive-surrender]] 的反制条目升格)
- 更新了 [[skills]](Osmani 项目 + 六阶段 SDLC + 路由器 + 可移植性)、[[cognitive-surrender]](反合理化表格链接)、[[agents-md]](五条不可妥协)、[[harness-engineering]](层级分工)、[[long-running-agents]](运行越长越要强制)、[[ai-feature-implementation-loop]]
- 关键互证:反合理化表格 = [[cognitive-surrender]] 中"反合理化表格"反制的完整版(公开样例集,部分回答开放问题);验证作为硬退出标准 ↔ [[agent-verification]] 回压/HumanLayer 验证上下文效率/[[factory-model]] 验证是瓶颈;渐进披露 5K 槽位 ↔ [[progressive-disclosure]] 与 [[curse-of-instructions]];范围纪律 ↔ [[three-tier-boundaries]] 的 Boundaries 区域与 [[plan-mode]];SDLC 六阶段 ↔ [[spec-driven-development]] 四阶段与 [[ai-agent-spec]] 六大区域;"代理默认跳过大多数阶段" ↔ [[ai-feature-implementation-loop]] 失败模式表;"senior 工作不显现在 diff" ↔ [[comprehension-debt]] 与 [[intent-debt]](承重 why);Hyrum's Law/DAMP/Chesterton 等 = 把 [[addy-osmani]] 与 Google 工程文化接回 wiki

## 待办 / 后续

- agent-skills 仓库演进(20 skill → ?;采用数据);反合理化表格的团队采用实证;Beyoncé Rule/DAMP 的代理化落地效果
- 五条不可妥协与 OpenAI 四败因/ETH 反证的兼容性(短而强制 vs 长而忽略)
