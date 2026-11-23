# First Flight · AGENTS.md

> This file makes First Flight readable by **Codex and Claude** while contributing to this repository.
>
> 这份 AGENTS.md 只面向本仓库的 Codex / Claude 协作入口。

---

## What is First Flight?

First Flight is a **spec-driven workflow that helps people build websites from 0 to 1 with Codex or Claude**. Instead of jumping into code, the user is guided through 6 markdown documents that together form a complete project specification. Then Codex or Claude can take those documents and build the site.

The 6 documents (in order):

1. **BRIEF.md** — Long-term project anchor (positioning, users, value, boundaries)
2. **PRD.md** — First version: pages, information architecture, success metrics
3. **DESIGN.md** — Visual & UX style ([Google DESIGN.md standard](https://github.com/google-labs-code/design.md) + First Flight extensions)
4. **ARCHITECTURE.md** — Tech stack, code organization, deployment
5. **CONTENT.md** — Content for each slot (📝 direct copy / 🤖 AI generation prompts / 📦 data sources)
6. **AGENTS.md** — Final entry document for Codex or Claude to build the site

**Scope**: First Flight is greenfield-only. It handles the 0→1 phase. Iteration is out of scope.

---

## How to use this repository

This repo contains **9 skills** that together form the First Flight workflow. The skills live under `skills/`. They produce two kinds of documents:

- **Long-term docs** (project root, shared across iterations): BRIEF / DESIGN / ARCHITECTURE / AGENTS — written once, basically unchanged
- **Iteration artifacts** (`iterations/v{N}-{slug}/`, fresh per iteration): PRD / CONTENT (v1 only) / `.plan/` working dir

First-time development runs Step 0 problem definition (`first-flight-grill`) and then 7 steps (BRIEF→PRD→DESIGN→ARCHITECTURE→CONTENT→AGENTS→phases). Subsequent iterations run only 2 steps (new iteration PRD + new phases), leaving long-term docs untouched.

### If you are Codex or Claude reading this file

The user has installed First Flight in this project. To help them build their website:

1. Read `skills/first-flight/SKILL.md` — this is the orchestrator skill that explains the full flow
2. Before BRIEF, run Step 0: `skills/first-flight-grill/SKILL.md` (two-way steelman on the problem itself; no file output)
3. When the user is ready to start a step, read the corresponding sub-skill:
   - `skills/first-flight-brief/SKILL.md`
   - `skills/first-flight-prd/SKILL.md`
   - `skills/first-flight-design/SKILL.md`
   - `skills/first-flight-architecture/SKILL.md`
   - `skills/first-flight-content/SKILL.md`
   - `skills/first-flight-agents/SKILL.md`
4. **When the user moves into actual coding** (after spec docs are done, or for any later feature work), trigger `skills/first-flight-phases/SKILL.md` to manage the work as `.plan/plan.md` + `phases/NN-*.md`. **Do not write code for ≥ 5 steps / cross multiple files / cross multiple sessions without phase management.**
5. Follow each sub-skill's instructions carefully — they include templates, examples, and progressive question batches

**Trigger phrases** the user might say:

For spec work (greenfield):
- "I want to build a website from scratch"
- "我想做一个网站"
- "Help me start a new website project"
- "Use First Flight to plan this site"

For phase-managed development (any complex coding):
- "Let's start building"
- "开始写代码 / 开始开发"
- "Break this into phases"
- "Plan first, then implement"

If the user is in the middle of First Flight (e.g., already has BRIEF.md but no PRD.md), skip the steps that are done and continue from the next one.

### If you are a user

See [README.md](./README.md) for Codex and Claude installation instructions.

---

## Repository layout

```
first-flight/
├── README.md                          ← Project page + install instructions
├── AGENTS.md                          ← This file (Codex / Claude contributor entry)
├── LICENSE                            ← MIT
├── .codex-plugin/                     ← Codex plugin entry
│   ├── assets/
│   │   ├── icon.svg
│   │   └── logo.svg
│   └── plugin.json
├── .claude-plugin/                    ← Claude Code plugin entry
│   ├── marketplace.json
│   └── plugin.json
├── script/                            ← Codex install / uninstall helpers
│   ├── install-codex.sh
│   └── uninstall-codex.sh
└── skills/                            ← Single source of truth for all skills
    ├── first-flight/                  ← Parent orchestrator
    ├── first-flight-grill/            ← Step 0: problem definition (two-way steelman)
    ├── first-flight-brief/            ← Spec step 1
    ├── first-flight-prd/              ← Spec step 2
    ├── first-flight-design/           ← Spec step 3 (Google DESIGN.md standard)
    ├── first-flight-architecture/     ← Spec step 4
    ├── first-flight-content/          ← Spec step 5
    ├── first-flight-agents/           ← Spec step 6
    └── first-flight-phases/           ← Implementation phase management (reusable)
```

---

## Code style / conventions for this repo

(For contributors editing the skill content itself.)

- All skill content is plain Markdown
- `SKILL.md` files must have YAML frontmatter with `name` and `description`
- Skills follow the [agentskills.io](https://agentskills.io) open standard
- Keep each `SKILL.md` under 500 lines for progressive disclosure
- Examples and templates go in `references/` and `assets/` subdirectories
- Edits should preserve the **path A (newbie) / path B (experienced)** dual-path design
- DESIGN sub-skill must stay compatible with [Google DESIGN.md spec](https://github.com/google-labs-code/design.md) (YAML frontmatter + 8 standard sections)

---

## Related standards / inspiration

- [agentskills.io](https://agentskills.io) — Open agent skills standard used by Codex and Claude
- [Google DESIGN.md](https://github.com/google-labs-code/design.md) — Visual identity format DESIGN sub-skill uses
