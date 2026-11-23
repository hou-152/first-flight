---
name: first-flight-phases
description: 用 plan.md + phase 子文档管理复杂开发任务，强制 AI 边做边更新进度，每个 phase 完成后停下来让用户验收——避免 AI 一口气做完导致失控。当用户开始写代码、改动 ≥ 5 步骤 / 跨多文件 / 跨多次会话时务必触发这个 skill。当用户说"分阶段做"、"按 phase 管理"、"plan 一下再做"、"先列计划再开工"、"break this down into phases"，或者刚做完 First Flight 的 6 份 spec 文档准备进入开发实施阶段时，请使用这个 skill。**首次开发和后续新功能迭代都适用**——只要任务复杂到需要中途让用户看进度，就走这套。这是 First Flight 的开发实施层 skill，跟前 6 个 spec 文档 skill（greenfield only）不同，phases skill 可以反复使用。
---

# First Flight · Phases

帮用户用 **plan.md + phase 子文档** 的方式管理复杂开发任务，让 AI 边做边更新进度，**每个 phase 完成停下来让用户验收**，避免一口气做完导致失控。

这个 skill 跟 First Flight 前 6 个 sub-skill（BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT / AGENTS）不同：
- 前 6 个：**只用一次**，生成 0→1 的 spec 文档
- 本 skill：**反复使用**——首次开发可以用、后续每次加新功能也可以用

## 何时触发

**必须用**：
- 任务 ≥ 5 个步骤
- 跨多个文件 / 模块
- 跨多次会话才能完成
- 新功能（涉及设计 + 实现 + 验证）
- 重构

**不要用**：
- 单文件、改动 < 100 行的小修
- 显然 10 分钟能搞定的事

## 核心原则（**绝对不能违反**）

1. **AI 不能自行跳过任务** —— 只在用户明确说"跳过这个"才能标 `[-]`
2. **AI 不能自行新增任务** —— 任务在执行中冒出来时，先告诉用户，确认后再加
3. **AI 不能替用户 commit** —— 即使章节验收通过，也由用户自己提交
4. **每个 phase 必须可独立验收** —— phase ≠ "一次会话"，phase = "一个里程碑"
5. **完成必须有 evidence** —— `[x]` 行尾必须附文件路径:行号 / commit hash / 命令

## 文档结构

**每个迭代有自己的 `.plan/`**，不放在项目根：

```
project-root/
├── BRIEF.md / DESIGN.md / ARCHITECTURE.md / AGENTS.md  (长期文档，跨迭代共用)
└── iterations/
    ├── v1-launch/
    │   ├── PRD.md
    │   ├── CONTENT.md
    │   └── .plan/                        ← 实施 v1-launch 的工作目录
    │       ├── plan.md
    │       ├── phases/
    │       │   ├── 01-<slug>.md
    │       │   ├── 02-<slug>.md
    │       │   └── ...
    │       └── archive/                  ← 整体方向不对时把老 plan 移到这里
    └── v2-{slug}/
        ├── PRD.md
        └── .plan/                        ← 实施 v2 的工作目录
            └── ...
```

**自动定位当前迭代**：skill 启动时找最新的 `iterations/v{N}-{slug}/`（按 N 最大判断），把 `.plan/` 落在那里。如果用户明确切换到某个迭代（如"现在做 v2 的实施"），按用户说的来。

**plan.md 是稳定的航图**——只在 scope 变化时更新。日常状态变化**不在 plan.md 里**——在各 phase 文档里。

**phase 文档是活跃的状态跟踪**——任务进度、evidence、blocker 都在这里。

## 整体流程

```
Step 0   读 plan.md（如果已存在）+ 当前活跃 phase 文档
   ↓
Step 1   起 plan.md（新任务）/ 跳过（继续旧任务）
   ↓
Step 2   拆 phase 子文档
   ↓
Step 3   执行：边做边更新（状态符号 + evidence）
   ↓
Step 4   处理三种例外（跳过 / 新增 / 受阻）
   ↓
Step 5   phase 完成 → 同步 plan.md 总览表
   ↓
Step 6   进阶：大 phase 拆 Section（如需要）
   ↓
Step 7   迭代收口：PR Readiness Gate（准备交付 / PR / 合并前）
```

## Step 0：会话开始先同步

**任何时候开始一个会话或捡起一个任务**：

1. 先读当前迭代的 `iterations/v{N}-{slug}/.plan/plan.md`（如果你不清楚当前迭代是哪个，先 `ls iterations/` 找最新的）
2. 找到当前活跃的 phase 文档（`Status: in progress` 那个）
3. 读这个 phase 文档
4. **以文档为真相源**——如果你的记忆和文档冲突，相信文档

不读直接干 = 一定会偏。

## Step 1：起 plan.md（新任务）

如果当前迭代的 `.plan/plan.md` 不存在，用 `assets/plan-template.md` 创建一份在 `iterations/v{N}-{slug}/.plan/plan.md`。包含 6 个部分：

1. **背景** —— 3-5 行说清"为什么做这件事"
2. **范围** —— 做什么 / 不做什么（明确写下来防 scope creep）
3. **阶段总览** —— 表格列出所有 phase 的 slug + 一句话目标 + 状态
4. **关键决策** —— 为什么这么拆，未来回头看时最需要
5. **Open Questions** —— 未拍板的事
6. **PR Readiness Gate** —— 迭代准备交付 / PR / 合并前的收口检查

**先在对话里给用户预览 plan.md**，确认后再写文件。

## Step 2：拆 phase 子文档

每个 phase 一份 `iterations/v{N}-{slug}/.plan/phases/NN-<slug>.md`：
- `NN` 用两位数字（`01`、`02`、…）保证文件按字典序就是执行序
- slug 短小可读：`hero-section`、`migrate-auth`、`works-list`
- 每个 phase 必须**可独立验收**——文档里写明"验收判据"
- **phase ≠ "一次会话"**——一个 phase 跨多次会话是常态

用 `assets/phase-template.md` 创建。

**任务粒度建议**：每个任务 ≤ 半天工作量。颗粒度过粗就拆。

## Step 3：执行——边做边更新

### 状态符号

直接修改 markdown checkbox 里的字符：

- `[ ]` 待办
- `[~]` 进行中（开始一个任务时改这个）
- `[x]` 已完成 —— **行尾必须追加 evidence**：`(src/auth.ts:42-58, commit a1b2c3d)`
- `[-]` 跳过 —— 行尾注明理由：`(skipped 2026-04-30: 改由 phase 03 处理)`，**只在用户明确说跳过时才标**
- `[!]` 受阻 —— 在 phase 文档的 Notes 区写清 blocker

> 注：除 `[ ]` 和 `[x]` 外，其它符号在编辑器里不会渲染成 checkbox，但仍然清晰可读——这是有意的。

### 完成的标准

**没有 evidence 的"完成"不算完成。** 改 `[x]` 时**必须**附：
- 文件路径:行号（如 `src/components/Hero.tsx:1-45`）
- commit hash（如 `commit a1b2c3d`）
- 关键命令（如 `npm test -- Hero.test.tsx`）

evidence 是给"未来的 AI / 用户"看的——让他们能验证"这件事真的做了"。

## Step 4：三种例外的处理

### 跳过 `[-]`

**只有用户明确说"跳过这个"才能标。** AI **不能自行跳过任务**。

如果觉得某个任务可以跳——告诉用户："我建议跳过任务 X，因为 Y。要跳吗？" 等用户确认后再标。

行尾注明跳过理由：`[-] 实现 logout 按钮 (skipped 2026-05-19: 用户决定挪到 phase 03)`

### 新增

任务在执行中冒出来时，**先告诉用户、确认后再加**。

加到对应 phase 的 Tasks 末尾，标注：

```
- [ ] 修 hover 时图片闪烁 (added 2026-05-19: 实现后发现的视觉 bug)
```

如果新任务属于另一个 phase 的范畴，加到那边而不是当前 phase。

### 受阻 `[!]`

把任务标 `[!]`，phase 头部 `Status` 改 `blocked`，**Notes 区写清楚 blocker**（什么阻塞、需要什么解才能继续）。

然后**告诉用户** "Phase NN 受阻，blocker 是 X"，让用户决定下一步（解 blocker / 跳过这个 phase / 调整 plan）。

## Step 5：phase 完成——同步 plan.md 总览表

phase 内所有任务都是 `[x]` 或 `[-]` 后：

1. 把 phase 文档头部 `Status` 改为 `completed`
2. **同步更新 plan.md 阶段总览表里的状态**
3. **告诉用户** "Phase NN 完成"，并提示下一步

## Step 6：进阶——大 phase 拆 Section

当一个 phase 任务多到**无法在一次自测 / 用户验收里覆盖**时，把 tasks 按里程碑拆成「章节 (Section)」。每个章节是一次最小的「AI 自测 → 用户测 → 可提交」循环。

**颗粒度判据**：理想章节 = **用户 5 分钟内能验完**。验收 > 15 分钟说明章节本身该再拆。

### 章节闸门 (Gate) 的四个状态

```
pending → self-tested → user-approved → committed
```

**强制顺序，不能跳**：

1. **pending** —— 还在做或刚开始
2. **self-tested** —— AI 完成章节内 tasks 并跑通"自测判据"
3. **user-approved** —— 用户实测通过，本章节正式过关
4. **committed** —— 代码已 commit，AI 在记录里写上 hash

### 章节流程

1. AI 完成章节所有 tasks（`[x]` 全部就位）
2. **AI 自测**：按章节"自测判据"逐项检查。失败回到第 1 步修。
3. 自测通过 → Gate 改为 `self-tested` → **主动告诉用户 "X 章节自测完成，请测试"**，附上具体测试方式（怎么启动、看什么、点哪里、预期结果），让用户不需要回头翻代码就能验。
4. 用户测试反馈：
   - **通过** → Gate 改 `user-approved` → **起草 commit message** 让用户提交，提交后由用户告诉 AI commit hash，Gate 改 `committed`
   - **不通过** → Gate 退回 `pending`，按反馈在章节 Tasks 末尾追加修复任务（`[ ] (added YYYY-MM-DD: 用户反馈：xxx)`），继续做

### 章节级硬规则

- **不要在章节未到 `committed` 就开始下个章节** —— 除非用户明确说"先放着，做下一章"。并行时在两边 Gate 行注明并行原因。
- **不要替用户 commit** —— 即便 Gate 已 `user-approved`。AI 起草 commit message，用户自己跑 `git commit`。
- **不要把章节做太大** —— 验收时间是信号，超过 15 分钟就拆。

## Step 7：迭代收口——PR Readiness Gate

这个 Gate **只在整个迭代准备交付、准备开 PR、准备合并或准备上线前跑**。不要把它塞进每个 phase；日常 phase 只需要自己的验收判据 + evidence。

触发条件：
- 用户说"准备 PR / 准备合并 / 准备上线 / 收口 / 最后检查一下"
- 或者当前迭代所有 phase 都已 `completed` / `skipped`，下一步明显是交付

### 十项收口检查

1. **理解原始意图**：重读 BRIEF / DESIGN / ARCHITECTURE / 当前 PRD / plan.md，复述本迭代原始目标、明确不做的事、实际完成的范围。发现偏离 BRIEF 或 PRD 时先停下来问用户。
2. **同步最新主分支**：先看 `git status`。如果工作区有未提交或用户改动，不要直接 rebase / merge。需要同步主分支时，先确认目标分支，再按项目习惯执行 rebase 或 merge。
3. **解决合并冲突**：如果发生冲突，不能只让文件"能编译"；还要检查冲突附近的业务逻辑、路由、样式和测试是否仍符合 PRD。
4. **对抗式 review**：以 reviewer 视角找问题，重点看需求漏项、scope creep、回归风险、a11y / 性能 / 安全、死代码、文档漂移。发现问题就修；不能修的写进风险。
5. **端到端测试**：优先跑项目已有 E2E；没有 E2E 时，手工走关键用户路径。记录启动命令、访问路径、预期结果、实际结果。
6. **前端真实层验证**：如果 ARCHITECTURE 启用了 `web-development`，静态 HTML 跑 `python3 ~/.codex/skills/web-development/scripts/verify-html.py <file.html>`；框架项目至少做真实浏览器交互、console 零错误、320/768/1200 响应式断点检查。不要用 curl/API 通过代替网页可用。
7. **记录 evidence**：汇总关键文件路径:行号、命令、测试结果、预览链接、截图路径（如有）。没有 evidence 的"完成"不算完成。
8. **更新文档**：代码行为、页面结构、依赖、配置或设计发生变化时，同步更新对应 spec（PRD / DESIGN / ARCHITECTURE / AGENTS / phase 文档）。
9. **lint 和静态检查**：跑项目约定的 lint / typecheck / build；如果改了 DESIGN.md，跑 design lint；如果改了关键路径，跑 Lighthouse 或同等检查。
10. **准备 PR**：起草 PR 内容，包括 Summary、Scope、Validation、Evidence、Risks / Rollback、Open Questions。默认只准备草稿，不替用户创建 PR、push 或 merge，除非用户明确要求。

### 收口输出

Gate 跑完后，在对话里给用户一份短报告：

```
PR Readiness Gate:
- 原始意图：...
- 本次实际完成：...
- 验证：...
- Evidence：...
- 风险 / 未决：...
- PR 草稿：...
```

如果任一项失败，不能说"可以合并"。要明确写：卡在哪、需要补什么、下一步怎么验证。

## 验证机制

任意时刻：

- 打开当前迭代的 `.plan/plan.md`，能在 30 秒内回答"做到哪了？下一步是什么？有哪些卡点？"
- 跑 `grep -E "^\- \[(\s|~)\]" iterations/v*/.plan/phases/NN-*.md` 列出所有未完成任务，结果非空时即"还没干完"
- `plan.md` 阶段总览状态 = 各 phase 文档头部 `Status`——两者不一致 → 文档漂移，需手动对齐
- 准备交付 / PR / 合并前，必须能给出 PR Readiness Gate 的验证报告；没有报告就还没收口
- 启用 `web-development` 的前端页面任务，必须能给出 verify-html 或真实浏览器 + console + 断点验证 evidence；没有 evidence 就还没收口

## 回滚机制

plan/phase 文档是状态记录，没有"操作回滚"概念。但**规划本身可能要重来**：

- 发现整体规划方向不对：**写新一版 `plan.md`**，把旧版移到当前迭代的 `.plan/archive/plan-YYYY-MM-DD.md`；phases 同理移入 `.plan/archive/phases/`
- 如果整个迭代方向都错了：考虑放弃当前 `iterations/v{N}-{slug}/`，新起一个 `iterations/v{N+1}-{new-slug}/`，让用户跑一次 first-flight-prd 写新 PRD
- **不要**原地大幅删改 plan.md —— 会丢失"原本打算怎么做"的历史，未来复盘没素材

## 写作风格守则

- plan.md 和 phase 文档**都是给"未来的 AI / 用户"看的** —— 写清楚、写具体
- 任务描述用动词开头："实现 Hero 区组件" 比 "Hero 区" 好
- 验收判据必须**可观察、可验证**："`npm test` 通过且新增测试覆盖 Hero" 比 "Hero 工作正常" 好
- evidence 必须**具体到行号 / hash** —— "改了首页" 不算
- 受阻时 Notes 写**完整描述**：什么阻塞、卡在哪、需要什么解、有没有 workaround

## 参考

- `assets/plan-template.md` —— plan.md 模板
- `assets/phase-template.md` —— phase 文档模板
- `references/example-plan.md` —— 完整 plan.md 示例（Linka 作品集首次开发）
- `references/example-phase.md` —— 完整 phase 文档示例（含 Section + Gate）
