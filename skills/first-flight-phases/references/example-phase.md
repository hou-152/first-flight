# phase 文档完整示例（Linka phase 02 · home）

延续 Linka 项目的 `.plan/plan.md`。本示例展示一个**大 phase 拆 Section**的完整形态，包含 Gate 流程。

---

# Phase 02 — home

**Status**: `in progress`
**目标**: 首页（hero + 精选作品 + 简介 + CTA 四区块）按 DESIGN 的 editorial + soft organic 风格实现，本地能跑、有合理的桌面 / 移动响应式
**前置**: phase 01 (bootstrap) 完成——项目能跑、导航存在、theme.css 已 export

## 验收判据

phase 完成 = **下面所有判据全部满足**：

- 首页 `/` 在 `pnpm dev` 下能正常访问，无 console error
- Hero / 精选作品 / 简介 / CTA 四区块按 DESIGN.md §Components 的 token 实现
- 4 个区块响应式正常（移动端 hero 上下堆叠、3 列 grid → 1 列等，符合 DESIGN §Responsiveness）
- 精选作品从 `src/content/works/` 读取 featured: true 的作品
- Lighthouse 桌面 Performance ≥ 90 / Accessibility = 100

## Sections

### Section A — Hero 区

**Gate**: `committed`

**自测判据**：

- `pnpm dev` 跑通，访问 `/` 看到 Hero 区
- 一句话定位、Linka 头像或主视觉、主 CTA 按钮三件套都在
- 桌面 + 移动（DevTools 模拟 iPhone）显示都正常
- 没有 console error、没有 layout shift

**Tasks**：

- [x] 创建 `src/components/Hero.astro` 组件 (src/components/Hero.astro:1-58, commit a1b2c3d)
- [x] 接入 `typography.h1` + `typography.body` token (commit a1b2c3d)
- [x] 主 CTA 按钮用 `button-primary` token (src/components/Hero.astro:42-52, commit a1b2c3d)
- [x] 头像图片用 Astro `<Image>` 组件优化 (src/components/Hero.astro:25-32, commit a1b2c3d)
- [x] 响应式：桌面左右分屏，移动上下堆叠 (commit a1b2c3d)

**记录**：

- 自测：2026-05-19，跑 `pnpm dev`，hero 区表现符合预期，移动端测试通过
- 用户验收：2026-05-19，通过。Linka 反馈"slogan 字号再大点"——已在 Section 同步修
- Commit：a1b2c3d

---

### Section B — 精选作品区

**Gate**: `self-tested`

**自测判据**：

- 6-8 张作品卡片显示，从 `src/content/works/` 读取 `featured: true`
- 每张卡片显示封面图 + 标题 + 类型标签
- Hover 时图片轻微 scale 1.03（符合 DESIGN §Components.card-work-hover）
- 移动端单列堆叠

**Tasks**：

- [x] 创建 `src/components/WorkGrid.astro` (src/components/WorkGrid.astro:1-42, commit b2c3d4e)
- [x] 创建 `src/components/WorkCard.astro`（卡片单元）(src/components/WorkCard.astro:1-38, commit b2c3d4e)
- [x] 从 Content Collections 读 featured 作品 (src/components/WorkGrid.astro:5-12, commit b2c3d4e)
- [x] Hover scale 动效 + prefers-reduced-motion 支持 (src/components/WorkCard.astro:20-28, commit b2c3d4e)
- [~] 响应式 3 列 → 1 列（进行中，移动端断点还在调）

**记录**：

- 自测：进行中，等响应式调好后跑

---

### Section C — 简介区 + CTA 区

**Gate**: `pending`

**自测判据**：

- 简介区显示 Linka 一段话介绍（从 CONTENT.md 的 🤖 需求生成）+ 3-5 个合作品牌 logo
- CTA 区一句话引导文案 + "开始合作"按钮跳 `/contact`
- 全部用 DESIGN.md 定义的 token

**Tasks**：

- [ ] 创建 `src/components/AboutSection.astro`
- [ ] 接入 brands.json 数据源（schema 见 ARCHITECTURE §4）
- [ ] 创建 `src/components/CTASection.astro`
- [ ] 简介文案：用 🤖 模式按 CONTENT.md §首页 简介区的生成需求写
- [ ] 给用户预览 AI 生成的简介文案，确认后再写入

## Notes

- 2026-05-19：Linka 反馈 hero slogan 太小——已在 Section A 改完，DESIGN.md 的 `typography.h1.fontSize` 也跟着从 `3.5rem` 调到 `4rem`（spec sync 完成）
- 2026-05-19：Section B 响应式断点用 DESIGN §Responsiveness 的 `md: 768` 切分，符合标准
- 待办：精选作品区显示 6 张还是 8 张？目前默认 6 张，让 Linka 上线后看效果再调
