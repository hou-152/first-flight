# Phase NN — {名称}

**Status**: `not started` / `in progress` / `completed` / `blocked` / `skipped`
**目标**: {一句话本阶段达成什么}
**前置**: {依赖的上一阶段或外部条件；无则填"无"}

## 验收判据

phase 完成 = **下面所有判据全部满足**。判据必须是可观察、可验证的：

- {如：`npm test` 通过且新增测试覆盖 Hero 组件}
- {如：`/works` 路由能正常打开，作品按 featured 排序显示}
- {如：Lighthouse Performance ≥ 90}
- {如：启用 `web-development` 的静态 HTML 跑 `verify-html.py` 达到 A 级，或框架页面完成真实浏览器 + console + 320/768/1200 响应式验证}

## Tasks

> 小 phase 用本节；大 phase 删本节，改用下面的 ## Sections（**二选一，不要并存**）。
> 任务粒度建议：每个 ≤ 半天工作量。颗粒度过粗就拆。

- [ ] {任务 1}
- [ ] {任务 2}
- [ ] {任务 3}

> **状态符号**（直接修改 `[ ]` 内的字符）：
>
> - `[ ]` 待办
> - `[~]` 进行中
> - `[x]` 已完成 — 行尾**必须**追加 evidence：`(src/auth.ts:42-58, commit a1b2c3d)`
> - `[-]` 跳过 — 行尾注明理由：`(skipped 2026-04-30: 改由 phase 03 处理)`，**只在用户明确说跳过时才标**
> - `[!]` 受阻 — 在 Notes 区写清 blocker

**中途新增的任务**追加在列表末尾，标注：

- [ ] {新增任务} (added YYYY-MM-DD: 简短原因)

## Sections

> **大 phase 才用；小 phase 删本节。** 每个 Section 是一次最小的「AI 自测 → 用户测 → 可提交」循环，颗粒度以 **用户 5 分钟内能验完** 为目标。

### Section A — {名称}

**Gate**: `pending` / `self-tested` / `user-approved` / `committed`

**自测判据**（章节做完后 AI 自己跑的检查，必须可执行）：

- {如：`npm test src/components/Hero`}
- {如：手工跑 `npm run dev`，访问 `/` 看到 Hero 区表现正常，没有 console error}

**Tasks**：

- [ ] {任务 1}
- [ ] {任务 2}

**记录**（推进闸门时填）：

- 自测：{YYYY-MM-DD：跑了什么命令 / 看到什么}
- 用户验收：{YYYY-MM-DD：通过 / 不通过 + 反馈摘要}
- Commit：{hash 或链接}

---

### Section B — {名称}

（同上结构）

## Notes

执行中的临时记录、决策、blocker 详情、参考链接。phase 完成后可酌情压缩成几行留存。
