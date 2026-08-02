---
type: concept
tags: [ai-agents, skills, workflow, engineering-discipline, documentation]
topic: ai-agents
created: 2026-08-02
updated: 2026-08-02
refs: [skills, anti-rationalization-tables, progressive-disclosure, curse-of-instructions, agents-md, spec-driven-development, ai-agent-spec, addy-osmani]
sources: [2026-05-03-agent-skills]
status: active
---

# Process over prose

过程胜过散文:写给代理(和人)的指导应该是**可执行的工作流**——步骤序列、检查点、证据、退出标准——而不是参考性文章;一条把"有用的 skill/规则文件"与"漂亮的 markdown"区分开的原则,也解释了为什么许多"AI 规则"仓库实际没用。

## 关键信息

**核心区分**(来源: [[2026-05-03-agent-skills]],Osmani):skill/规则文件 = 工作流("先写失败测试 → 跑 → 看它失败 → 写最少代码 → 跑 → 看它过 → 重构"),**不是**参考文档("关于测试你该知道的一切");"把 2,000 字测试散文放进去,代理读了、生成像样的文本、**跳过实际测试**;放工作流进去,代理有东西可做,你有东西可验证";"**过程胜过散文、工作流胜过参考、带退出标准的步骤胜过没有它们的文章**"

**SDLC 六阶段**(仓库 20 个 skill 的组织):Define(`/spec`)→ Plan(`/plan`)→ Build(`/build`,垂直切片)→ Verify(`/test`)→ Review(`/review`)→ Ship(`/ship`);与所有健康组织的循环同构(Google:design doc → review → implementation → readability → launch checklist;Amazon:working-backwards memo + bar raiser);**代理默认跳过大多数阶段**——skill 路由器(元 skill)按阶段激活,"工作流缩放到实际范围,而非假定范围"(复杂功能 11 个 skill,小 bug 修复 3 个)

**适用范围**:不止代理——人类团队同样(200 页手册没人读,带检查点的小工作流人真会跑);内部文档(2,000 字"我们怎么做 X"→ 转成 400 字带检查点的工作流);规则书/runbook/事故 playbook 一律适用

**配套机制**:

- **验证不可妥协**:每个工作流以具体证据终止(测试过/构建干净/运行时 trace/评审签字),"看起来对"永远不够;"代理是生成器,你需要独立信号说工作完成了"(见 [[agent-verification]])
- **渐进披露**:别把整个库塞进上下文——路由器按需激活;"20 个 skill 的库塞进 5K token 槽位而不毒化井水"(见 [[progressive-disclosure]])
- **范围纪律**:“只碰叫你碰的东西”——不重构相邻系统、不删不完全理解的代码(见 [[three-tier-boundaries]])
- **反合理化表格**:每工作流配借口→反驳表,防跳过(见 [[anti-rationalization-tables]])

**五条不可妥协**(元 skill 提炼,可直接进任何 AGENTS.md):①建之前显性化假设(静默的错误假设是最常见失败模式)②需求冲突时停下问,别猜 ③该顶回去就顶回去(不是 say-yes 机器)④偏好无聊明显的方案(聪明是昂贵的)⑤只碰叫你碰的东西——"五行的值得维护的工程文化"(见 [[agents-md]])

## 与其他页面的关系

- 载体: [[skills]]、[[agents-md]];披露: [[progressive-disclosure]];风险对照: [[curse-of-instructions]](散文式规则 = 指令过多反无效的形态)
- 流程: [[spec-driven-development]]、[[ai-agent-spec]];防跳过: [[anti-rationalization-tables]]
- 倡导者: [[addy-osmani]];来源: [[2026-05-03-agent-skills]]
