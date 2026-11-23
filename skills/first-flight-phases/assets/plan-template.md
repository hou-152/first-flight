# {一句话目标：完成 X 后世界变成什么样}

> 文件位置：`iterations/v{N}-{slug}/.plan/plan.md`
> 配套 skill：first-flight-phases
> 本 plan 文档是**稳定航图**，状态跟踪在各 phase 文档（同目录的 `phases/NN-*.md`）里。

## 背景

{3-5 行说清"为什么做这件事"。包括触发原因、当前痛点、不做的代价。}

## 范围

**做：**

- {在范围内的事 1}
- {在范围内的事 2}
- {在范围内的事 3}

**不做：**

- {明确排除的事 1，写下来是为了避免后期 scope creep}
- {明确排除的事 2}

## 阶段总览

| #  | 阶段 slug         | 一句话目标       | 状态         |
|----|-------------------|------------------|--------------|
| 01 | {slug}            | {…}              | not started  |
| 02 | {slug}            | {…}              | not started  |
| 03 | {slug}            | {…}              | not started  |

> 状态值：`not started` / `in progress` / `completed` / `blocked` / `skipped`
>
> 详细任务、evidence、blocker 在各 phase 文档（`phases/NN-<slug>.md`）里，**不在本表里展开**。

## 关键决策

记录"为什么这么拆"——未来回头看 plan 时最需要的信息。

- **YYYY-MM-DD**：选了 X 而非 Y，因为 Z。
- **YYYY-MM-DD**：…

## Open Questions

未拍板的事。开工前能解决的就解决，剩下的标注预期在哪个 phase 解决。

- [ ] {未决问题 1} — 预期在 phase NN 解决
- [ ] {未决问题 2}

## PR Readiness Gate

> 只在本迭代准备交付 / PR / 合并 / 上线前跑；不是每个 phase 都跑。
> 详细规则见 `first-flight-phases` 的 Step 7。

**状态**：`not started` / `passed` / `blocked`

- [ ] 原始意图复核：BRIEF / DESIGN / ARCHITECTURE / 当前 PRD / plan.md 已重读，实际完成范围没有偏离
- [ ] 主分支同步：已检查 `git status`；需要 rebase / merge 时已确认目标分支并处理冲突
- [ ] 对抗式 review：已按 reviewer 视角检查需求漏项、scope creep、回归风险、a11y / 性能 / 安全、文档漂移
- [ ] 端到端测试：已有 E2E 已跑；没有 E2E 时已手工走关键用户路径
- [ ] 前端真实层验证：如启用 `web-development`，静态 HTML 已跑 `verify-html.py`；框架项目已完成真实浏览器、console、320/768/1200 响应式断点检查
- [ ] Evidence 汇总：关键文件路径、命令、测试结果、预览链接 / 截图路径已记录
- [ ] 文档同步：PRD / DESIGN / ARCHITECTURE / AGENTS / phase 文档中需要更新的都已同步
- [ ] 静态检查：lint / typecheck / build / design lint / Lighthouse（按本次改动需要）已跑
- [ ] PR 草稿：Summary / Scope / Validation / Evidence / Risks / Rollback / Open Questions 已准备

**收口记录**：
- 原始意图：
- 实际完成：
- 验证：
- Evidence：
- 风险 / 未决：
- PR 草稿：

## 关联

> 路径相对当前文件位置 `iterations/v{N}-{slug}/.plan/plan.md`：

- 长期文档（项目根）：[BRIEF.md](../../../BRIEF.md) / [DESIGN.md](../../../DESIGN.md) / [ARCHITECTURE.md](../../../ARCHITECTURE.md) / [AGENTS.md](../../../AGENTS.md)
- 当前迭代 PRD（同目录的父级）：[PRD.md](../PRD.md)
- 首版 CONTENT（仅 v1-launch 有，路径按所在迭代调整）：`../../v1-launch/CONTENT.md`
