---
title: "AI writes code faster. Your job is still to prove it works."
source: "https://addyosmani.com/blog/code-review-ai/"
author:
  - "[[Addy Osmani]]"
published: 2026-01-07
created: 2026-08-02
description: "AI did not kill code review. It made the burden of proof explicit. Ship changes with evidence like manual verification and automated tests, then use review f..."
tags:
  - "clippings"
---
**AI did not kill code review. It made the burden of proof explicit. Ship changes with evidence like manual verification and automated tests, then use review for risk, intent, and accountability. Solo developers lean on automation to keep up with AI speed, while teams use review to build shared context and ownership.**

If your pull request doesn’t contain evidence that it works, you’re not shipping faster - you’re just moving work downstream.

By early 2026, [over 30% of senior developers](https://www.infoworld.com/article/4049949/senior-developers-let-ai-do-more-of-the-coding-survey.html) report shipping mostly AI-generated code. The challenge? AI excels at drafting features but falters on logic, security, and edge cases - [making errors 75% more common in logic alone](https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report). This splits workflows: solos “vibe” at inference speed with test suites as backstops, while teams demand human eyes for context and compliance. Done right, both treat AI as an accelerator, but verification - who, what, and when - defines the difference.

As I’ve said before: if you haven’t seen the code do the right thing yourself, it doesn’t work. AI amplifies this rule, not excuses it.

## How developers use AI for review

- **Ad-hoc LLM checks**: Paste diffs into Claude, Gemini or GPT for quick bug/style scans before committing.
- **IDE integrations**: Tools like Cursor, Claude Code, or Gemini CLI for inline suggestions and refactors during coding.
- **PR bots and scanners**: GitHub Copilot or custom agents to flag issues in PRs; pair with static/dynamic analysis like Snyk for security.
- **Automated testing loops**: Use AI to generate and run tests, enforcing coverage >70% as a gate.
- **Multi-model reviews**: Run code through different LLMs (e.g., Claude for generation, a security-focused model for audit) to catch biases.

The workflow and mindset differ dramatically depending on whether you’re solo or working in a team where others maintain your code.

## Solo vs. Team: A quick comparison

![Solo vs Team Code Review](https://addyosmani.com/assets/solo-team.jpg)

## Solo Devs: Shipping at “inference speed”

**Solo developers increasingly “trust the vibe” of AI-generated code - shipping features rapidly by reviewing only the key parts and relying on tests to catch issues.**

This workflow treats coding agents as powerful interns that can handle massive refactors largely on their own. As [Peter Steinberger admits](https://blog.kilo.ai/p/senior-engineers-use-ai-now): *“I don’t read much code anymore. I watch the stream and sometimes look at key parts, but most code I don’t read.”* The bottleneck becomes [inference time](https://steipete.me/posts/2025/shipping-at-inference-speed) - waiting for the AI to generate output - not typing.

**There’s a catch: perceived speed gains vanish without strong testing practices.** Build those first. If you skip review, you don’t eliminate work - you defer it. The developers who succeed with AI at high velocity aren’t the ones who blindly trust it; they’re the ones who’ve built verification systems that catch issues before they reach production.

That isn’t to say solos throw caution to the wind. The responsible ones employ **extensive automated testing as a safety net** - aiming for high coverage (often >70%) and using AI to generate tests that catch bugs in real-time. Modern coding agents are surprisingly good at designing sophisticated end-to-end tests.

**For solos, the game-changer is language-independent, data-driven tests.** If comprehensive, they let an agent build (or fix) implementations in any language, verifying as it goes. I start projects with a spec.md the AI drafts, approve it, then loop: write → test → fix.

Crucially, solo coders still do **manual testing and critical reasoning** on the final product. Run the application, click through the UI, use the feature yourself. When higher stakes are involved, read more code and add extra checks. And despite moving fast, fix ugly code when you see it rather than letting the mess accumulate.

Even in this bleeding-edge paradigm: [*your job is to deliver code you have proven to work*](https://simonwillison.net/2025/Dec/18/code-proven-to-work/)*.*

## Teams: AI shifts review bottlenecks

**In team settings, AI is a powerful assistant for code review, but *cannot replace* the human judgment needed for quality, security, and maintainability.**

When multiple engineers collaborate, the cost of mistakes and longevity of code are much higher concerns. Teams have started using AI-based review bots for an initial pass on PRs, but they still require a human to sign off. As [Greg Foster of Graphite](https://devclass.com/2025/03/19/graphite-debuts-diamond-ai-code-reviewer-insists-ai-will-never-replace-human-code-review/) puts it: *“I don’t ever see \[AI agents\] becoming a stand-in for an actual human engineer signing off on a pull request.”*

**The biggest practical problem isn’t that AI reviewers miss style issues - it’s that AI increases volume and shifts the burden onto humans.** [PRs are getting larger](https://jellyfish.co/blog/ai-assisted-pull-requests-are-18-larger/) (~18% more additions as AI adoption increases), [incidents per PR are up ~24%, and change failure rates up ~30%](https://www.cortex.io/post/ai-is-making-engineering-faster-but-not-better-state-of-ai-benchmark-2026). When output increases faster than verification capacity, review becomes the rate limiter. As Foster notes: *“If we’re shipping code that’s never actually read or understood by a fellow human, we’re running a huge risk.”*

In teams, AI floods volume, so enforce incrementalism: break agent output into digestible commits. Human sign-off isn’t going away - it’s evolving to focus on what AI misses, like roadmap alignment and institutional context that AI can’t grasp.

### Security: AI’s predictable weaknesses

**One area where [human oversight](https://addyosmani.com/agentic-engineering/human-in-the-loop/) is absolutely non-negotiable is security.** [Approximately 45% of AI-generated code contains security flaws](https://www.veracode.com/blog/ai-generated-code-security-risks/). [Logic errors appear at 1.75× the rate of human-written code, and XSS vulnerabilities occur at 2.74× higher frequency](https://dl.acm.org/doi/10.1145/3716848).

Beyond code issues, [agentic tooling and AI-integrated IDEs have created new attack paths](https://www.tomshardware.com/tech-industry/cyber-security/researchers-uncover-critical-ai-ide-flaws-exposing-developers-to-data-theft-and-rce) - prompt injection, data exfiltration, even RCE vulnerabilities. AI expands attack surfaces, so hybrid approaches win: AI flags, humans verify.

**Rule: If code touches auth, payments, secrets, or untrusted input, treat AI as a high-speed intern and require a human threat model review plus a security tool pass before merge.**

### Review as knowledge transfer

**Code review is also how teams share system context. If AI writes the code and nobody can explain it, on-call becomes expensive.**

When a developer submits AI-generated code they don’t fully understand, they’re breaking the knowledge transfer mechanism that makes teams resilient. If the original author can’t explain why the code works, how will the on-call engineer debug it at 2 AM?

[The OCaml maintainers’ rejection of a 13,000-line AI-generated PR](https://devclass.com/2025/11/27/ocaml-maintainers-reject-massive-ai-generated-pull-request/) crystallizes this issue. The code wasn’t necessarily bad, but no one had bandwidth to review such a huge change, and reviewing AI-generated code is *“more taxing”* than reviewing human code. The lesson: **AI can flood you with code, but teams must manage volume to avoid a review bottleneck.**

### Making AI review tools work

User experiences with AI review tools are decidedly mixed. On the positive side, teams report catching 95%+ of bugs in some cases - null pointer exceptions, missing test coverage, anti-patterns. On the negative side, some developers dismiss AI review comments as “text noise” - generic observations that add no value.

**The lesson: AI review tools require thoughtful configuration.** Tune sensitivity levels, disable unhelpful comment types, and establish clear opt-in/opt-out policies. Properly configured, [AI reviewers can catch 70-80% of low-hanging fruit](https://graphite.dev/guides/what-is-ai-code-review), freeing humans to focus on architecture and business logic.

Many teams encourage **smaller, stackable pull requests** even if AI could do a giant change all at once. [Commit early and often](https://medium.com/@addyosmani/my-llm-coding-workflow-going-into-2026-52fe1681325e) - treat each self-contained change as a separate commit/PR with clear messages.

Importantly, **teams maintain a hard line of human accountability.** No matter how much AI contributed, a human must take responsibility. As an old IBM training saying goes: *“A computer can never be held accountable. That’s your job as the human in the loop.”*

## The PR Contract: What authors owe reviewers

**Whether solo or in a team, the emerging best practice is to [treat AI-generated code as a helpful draft](https://addyo.substack.com/p/treat-ai-generated-code-as-a-draft) that *must* be verified.**

The most successful teams have converged on a simple framework:

### PR Contract

1. **What/why**: Intent in 1-2 sentences.
2. **Proof it works**: Tests passed, manual steps (screenshots/logs).
3. **Risk + AI role**: Tier and which parts were AI-generated (e.g., high=payments).
4. **Review focus**: 1-2 areas for human input (e.g., architecture).

This isn’t bureaucracy - it’s respect for reviewer time and a forcing function for author accountability. If you can’t fill this out, you don’t understand your own change well enough to ask someone else to approve it.

### Core Principles

**Insist on proof, not promises.** Make “working code” the baseline. Prompt AI agents to execute code or run unit tests after generation. Demand evidence: logs, screenshots, results. **No PR goes up without either new tests or a demo of the change working.**

**Use AI as first-pass reviewer, not final arbiter.** Treat AI review output as advisory - a dialog where one AI writes code, another reviews it, and the human orchestrates fixes. Think of AI reviews as spellcheck, not an editor.

**Focus human review on what AI misses.** Does the change introduce a security hole? Does it duplicate existing code (a common AI flaw)? Is the approach maintainable? **AI triages the easy stuff; humans tackle the hard stuff.**

**Enforce incremental development.** Break work into small pieces - easier for AI to produce and for humans to review. Small commits with clear messages serve as checkpoints. **Never commit code you can’t explain.**

**Maintain high testing standards.** [Those who get the most out of coding agents](https://medium.com/@addyosmani/my-llm-coding-workflow-going-into-2026-52fe1681325e) have strong testing practices. Ask AI to draft tests - it’s good at generating edge-case tests you might not think of.

## Looking Ahead: The bottleneck has moved

**AI is transforming code review from line-by-line gatekeeping into higher-level quality control - but human judgment remains the safety-critical component.**

What we’re seeing is workflow evolution, not elimination. Code reviews now involve reviewing a *conversation* or *plan* between AI and author as much as the code diff itself. The human reviewer’s role becomes more like an editor or architect: focusing on what’s important and trusting automation for mundane checks.

For solo developers, the path ahead is exhilarating - new tools will further streamline development. Even then, the wise developer will “trust but verify.”

In larger teams, expect growing emphasis on AI governance. Companies will formalize policies about AI contributions, requiring sign-offs that code was reviewed by an employee. Roles like “AI code auditor” will emerge. Enterprise platforms will evolve to offer better multi-repository context and custom policy enforcement.

**No matter the advances, the core principle remains**: code review ensures software meets requirements, is secure, robust, and maintainable. AI doesn’t change those fundamentals - it just changes how we get there.

The bottleneck moved from writing code to proving it works. The best code reviewers in the age of AI will embrace this shift - letting AI accelerate the mechanical work while holding the line on accountability. They’ll let AI **accelerate** the process, never **abdicate** it. As engineers are learning, it’s about [*“proof over vibes”*](https://blog.kilo.ai/p/senior-engineers-use-ai-now) in coding.

Code review isn’t dead but it’s becoming more **strategic**. And whether you’re a solo hacker deploying at 2 AM or a team lead signing off a critical system change, one truth holds: the *human* is ultimately responsible for what the AI delivers.

Embrace the AI, but never forget to **double-check the work.**

---

*I’m excited to share I’ve released a new [AI-assisted engineering book](https://beyond.addy.ie/) with O’Reilly. There are a number of free tips on the book site in case interested.*