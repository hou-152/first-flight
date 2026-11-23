# AGENTS.md 完整示例（接续 Linka 个人作品集）

基于前 5 份文档机械生成 + 用户特别强调的协作规则。

---

# Linka · AGENTS

> 这份文档是 Codex / Claude 进入本项目的入口。拿到项目目录后，请先读完这份文档再开始工作。

## 项目一句话

独立设计师 Linka 的个人作品集网站，向潜在客户和招聘方展示她的品牌设计与插画作品。

## 文档地图

本项目由 First Flight 生成，文档分两类。**长期文档先读、迭代产物按需读**：

**长期文档（项目根）：**

| 文档 | 内容 |
|---|---|
| [BRIEF.md](./BRIEF.md) | 长期纲领：editorial 气质作品集站，B 端委托方为目标 |
| [DESIGN.md](./DESIGN.md) | 杂志阅读 + 温和有机预设；YAML token 含完整色彩 / 字体 / spacing |
| [ARCHITECTURE.md](./ARCHITECTURE.md) | Astro 5 + Radix Primitives + Tailwind v4 + Cloudflare Pages |
| [AGENTS.md](./AGENTS.md) | 本文件 |

**当前迭代产物（`iterations/v1-launch/`）：**

| 文件 | 内容 |
|---|---|
| `iterations/v1-launch/PRD.md` | 5 个页面（首页 / 作品列表 / 作品详情 / 关于 / 联系）+ 信息架构 + 90 天获 ≥5 份咨询的目标 |
| `iterations/v1-launch/CONTENT.md` | 每个内容槽用 📝 / 🤖 / 📦 三种模式之一标记 |
| `iterations/v1-launch/.plan/` | v1-launch 实施过程（plan.md + phases/） |

## 项目本质边界（来自 BRIEF）

**永远会是的**：
- Linka 个人作品 + 设计思路的展示空间
- 面向 B 端委托方
- 以"风格识别 + 信任建立"为目标

**永远不做的**：
- 第三方设计师入驻
- 设计素材售卖
- 课程社区
- 用户互动评论

⚠️ 任何看似偏离这些边界的请求，请先停下来和用户确认；不要默认接受。

## 技术栈一句话（来自 ARCHITECTURE）

Linka 用 Astro 5 + Radix Primitives（手搓样式）+ Tailwind v4 + Cloudflare Pages 搭建，作为完全静态生成（SSG）的作品集站点。

详细决策见 [ARCHITECTURE.md](./ARCHITECTURE.md)。

## 写代码前的准备

如果还没做完这些，先停下来提醒用户：

- [ ] 跑 `npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css`
- [ ] 注册 Formspree、Cloudflare Pages、Plausible、Turnstile 账号；keys 放 `.env.local`
- [ ] 域名 `linka.design` 解析到 Cloudflare Pages
- [ ] 装 Node 22 + pnpm
- [ ] `pnpm create astro@latest linka -- --template minimal --typescript strict --install`
- [ ] 装依赖：`pnpm add @astrojs/tailwind tailwindcss@next @astrojs/mdx @astrojs/react @radix-ui/react-dialog @radix-ui/react-tabs`
- [ ] （可选）购买 Tiempos Headline + Söhne 字体授权；未购买前用 Crimson Pro + Inter 替代

## 写代码时的核心规则

### 必须遵循

1. **遵循 DESIGN.md 的 Do's & Don'ts**——尤其 Don'ts。Linka 的 Don'ts 包括：
   - ❌ 不要渐变背景（任何地方）
   - ❌ 不要 stock 照片
   - ❌ 不要 emoji 装饰
   - ❌ 不要 hero 视频 / 动画背景
   - ❌ 不要 carousel / slider
   - ❌ 不要弹窗 / 模态框（联系表单除外，但用 Radix Dialog 不要自己写）
   - ❌ 不要荧光色 / neon
   - ❌ 不要全大写英文标题
   - ❌ 不要 3D / glassmorphism / neumorphism

2. **CONTENT.md 的三种模式**：
   - 📝 直接文案——**原样使用**，不要"优化"成营销话术
   - 🤖 AI 生成需求——按需求 + DESIGN voice + BRIEF 语气生成，生成完主动给用户看
   - 📦 数据源——从 `src/content/works/` 等指定路径读取，schema 见 ARCHITECTURE §4

3. **代码组织**——严格按 ARCHITECTURE §7：
   - 内容文件在 `src/content/`
   - 页面在 `src/pages/`（Astro file-based routing）
   - UI 组件在 `src/components/ui/`，业务组件在 `src/components/`
   - layouts 在 `src/layouts/`
   - 样式 `src/styles/`（含 `theme.css` 从 DESIGN export）

4. **不要引入未在 ARCHITECTURE 中列出的依赖**——如果需要新库，先停下来和用户讨论、更新 ARCHITECTURE 再装

5. **复杂开发用 phase 管理**——Linka 项目里这些场景必须触发 `first-flight-phases` skill：
   - 实施任何一个完整页面（hero + 各区块跨多文件 + 响应式调试 + 自测）
   - 把 6 份 spec 落地成首版上线（典型的"跨多次会话"任务）
   - 后续新功能（如未来要加 `/blog` 路由——但 Linka 的 BRIEF 边界排除了这个，所以发生时要先确认）

   走 phase 管理时建立 `.plan/plan.md` + `.plan/phases/NN-*.md`，每个 phase 完成停下让 Linka 验收。**不要一口气做完整个网站**。phases skill 内有完整规则。

### 编码风格

- TypeScript strict mode
- 组件名 PascalCase（`WorkCard.astro` / `ContactForm.tsx`）
- 工具函数 camelCase（`formatYear.ts`）
- 内容文件 kebab-case（`brand-stripe-redesign.mdx`）
- 路由 segment kebab-case（`/works/brand-stripe-redesign`）
- 优先 `.astro`，仅交互组件用 `.tsx`（React island）

### 交付前自检 / PR Readiness

当本次迭代准备交付、准备 PR、准备合并或准备上线时，先跑 `first-flight-phases` 的 **PR Readiness Gate**。这是迭代收口检查，不是每个 phase 都跑。

- [ ] 原始意图复核：重读 BRIEF / DESIGN / ARCHITECTURE / 当前 PRD / plan.md，确认实际完成没有偏离
- [ ] 主分支同步：检查 `git status`；需要 rebase / merge 时先确认目标分支，冲突解决后重新验证
- [ ] 对抗式 review：按 reviewer 视角检查需求漏项、scope creep、回归风险、a11y / 性能 / 安全、文档漂移
- [ ] 端到端测试：已有 E2E 已跑；没有 E2E 时已手工走首页 → 作品列表 → 作品详情 → 联系表单路径
- [ ] Evidence 汇总：记录关键文件路径、命令、测试结果、预览链接 / 截图路径（如有）
- [ ] 文档同步：改动符合 PRD 的页面结构；如新增页面，先更新 PRD
- [ ] `pnpm typecheck` / `pnpm build` 通过
- [ ] `npx @google/design.md lint DESIGN.md` 通过（如改了 DESIGN）
- [ ] Lighthouse Performance ≥ 95 / Accessibility = 100（如改了关键路径）
- [ ] PR 草稿已准备：Summary / Scope / Validation / Evidence / Risks / Rollback / Open Questions

默认只准备 PR 草稿和验证报告，不替用户 push、创建 PR 或 merge，除非用户明确要求。

### Spec Sync（保持文档和代码同步）

**核心原则**：BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT 是 source of truth，代码是它们的实现。当你写代码过程中发现决策变化时，**主动同步更新对应 spec**——避免改动只活在本次对话里，下次 session 失效。

**典型例子**：

- Linka 说"作品详情页加一个'下一件作品'导航" → PRD.md §5 信息架构 `/works/[slug]` 区块更新
- Linka 说"主色我想再暖一点，靠近 #2A1F1A" → DESIGN.md YAML `colors.primary` 变更 + 跑 `npx @google/design.md export` 重新生成 theme.css
- 装 `astro-icon` 因为发现需要 SVG 图标系统 → ARCHITECTURE.md §3 依赖更新 + §7 代码组织加 `src/icons/`
- Linka 最终确认了首页 slogan 是"用画讲故事" → CONTENT.md hero §slogan 从 🤖 改为 📝 + 写入文字
- 决定不做 `/contact` 页（改成在 footer 直接放邮箱）→ PRD.md §4 删除 + §5 删除 + CONTENT.md 对应内容槽删除

**判断**："下次 AI 看到项目时需要知道吗？"是 → 进 spec。否 → 不必。

**遇到 BRIEF 边界冲突**（如 Linka 说"加一个素材商店"）→ ⚠️ **停下**，先和 Linka 确认这是 BRIEF 级变更。BRIEF 里明确"永远不做：设计素材售卖"，要么更新 BRIEF（重审项目方向），要么收窄需求。

### 用户特别强调的规则

- 中文回复，代码注释用英文
- 任何 npm 包变更前先和我商量
- 字体相关的实现先用 Crimson Pro + Inter 替代，等 Linka 确认买字体后再切

## 工具链常用命令

```bash
# 启动开发
pnpm dev

# 类型检查
pnpm astro check

# 构建（同时跑类型检查）
pnpm build

# 预览构建产物
pnpm preview

# 导出 design tokens
npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css

# 校验 DESIGN.md
npx @google/design.md lint DESIGN.md

# 部署（Cloudflare Pages 自动，推 main 即部署；预览见 PR Cloudflare 自动评论）
git push origin main
```

## 在哪里找信息

| 问题 | 去哪查 |
|---|---|
| 这个项目最终长期要变成什么样？ | BRIEF.md |
| 第一版要做哪些页面 / 功能？ | PRD.md §页面结构、§信息架构 |
| 这个按钮 / 卡片应该长什么样？ | DESIGN.md §Components、§Shapes |
| 用什么色 / 字体？ | DESIGN.md YAML front matter |
| 用什么技术栈 / 库？ | ARCHITECTURE.md §3 |
| 这个区块应该放什么内容？ | CONTENT.md（按页面 / 区块 / 内容槽查） |
| 部署到哪？怎么部署？ | ARCHITECTURE.md §6 |
| 性能 / a11y 目标是多少？ | ARCHITECTURE.md §8 + DESIGN.md §Accessibility |
| 表单怎么处理？ | ARCHITECTURE §5（Formspree）+ CONTENT §5（字段标签和 placeholder） |

## 协作姿态

- **请向用户提问而不是默认假设**——First Flight 的设计原则是"不确定先问"
- **遇到 BRIEF 边界冲突要停下**——比如有人提"加付费下载笔刷"，立刻指出和 BRIEF "永远不做：设计素材售卖" 冲突
- **改文档要更新对应的 spec 文件**——比如改了 page 结构要回去更新 PRD，改了配色要更新 DESIGN
- **保持文档的"权威性"**——6 份文档是 source of truth，代码是文档的实现

## 这是用 First Flight 生成的

本项目的 6 份文档（BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT / AGENTS）由 First Flight skill 系列引导生成。如需重新走 First Flight 或了解整个流程，参考 First Flight 的父 skill 文档。
