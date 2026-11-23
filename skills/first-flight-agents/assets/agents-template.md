# {项目名} · AGENTS

> 这份文档是 Codex / Claude 进入本项目的入口。拿到项目目录后，请先读完这份文档再开始工作。

## 项目一句话

{从 BRIEF §一句话定义复制}

## 文档地图

本项目由 First Flight 生成，文档分两类：

**长期文档（项目根，跨迭代共用）：**

| 文档 | 内容 |
|---|---|
| [BRIEF.md](./BRIEF.md) | 项目长期纲领（本质、用户、价值、边界） |
| [DESIGN.md](./DESIGN.md) | 视觉与 UX 风格（Google DESIGN.md 标准 + 扩展） |
| [ARCHITECTURE.md](./ARCHITECTURE.md) | 技术栈、代码组织、部署 |
| [AGENTS.md](./AGENTS.md) | 本文件——AI 入口 + 协作规则 |

**迭代产物（`iterations/v{N}-{slug}/`，每次迭代独立）：**

| 文件 | 内容 |
|---|---|
| `iterations/v1-launch/PRD.md` | 首版功能、信息架构、目标衡量 |
| `iterations/v1-launch/CONTENT.md` | 首版内容槽填充（📝/🤖/📦），**仅 v1-launch 有** |
| `iterations/v1-launch/.plan/` | v1-launch 的 plan + phase 实施工作目录 |
| `iterations/v{N}-{slug}/PRD.md` | 后续迭代的 PRD（如有） |
| `iterations/v{N}-{slug}/.plan/` | 对应迭代的实施工作目录 |

**阅读顺序**：长期文档（BRIEF → DESIGN → ARCHITECTURE）→ 当前要做的迭代目录里的 PRD（首次看 v1-launch，后续看最新 v{N}）→ 实施时进入对应 `.plan/`。

## 项目本质边界（来自 BRIEF）

**永远会是的**：
- {复制自 BRIEF §本质边界}

**永远不做的**：
- {复制自 BRIEF §本质边界}

⚠️ 任何看似偏离这些边界的请求，请先停下来和用户确认；不要默认接受。

## 技术栈一句话（来自 ARCHITECTURE）

{复制自 ARCHITECTURE §1}

详细决策见 [ARCHITECTURE.md](./ARCHITECTURE.md)。

## 前端实施知识库

如果 ARCHITECTURE 启用了 `web-development`，写代码阶段按它作为前端执行参考：

- 静态站 / 单文件 HTML / 落地页可优先复用 `web-development/templates/starter-template.html` 或 `web-development/assets/tokens.css`
- HTML/CSS/JS、响应式、a11y、SEO、Core Web Vitals、动效和排错优先查 `web-development/references/`
- 如果本机存在 `~/.codex/skills/web-development/scripts/verify-html.py`，静态 HTML 交付前跑它；否则使用项目等价的浏览器、console、响应式断点验证并记录 evidence
- `web-development` 只管前端实现和验证；BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT 在需求、内容、依赖、视觉决策上永远优先

## 写代码前的准备

如果还没做完这些，先停下来提醒用户：

- [ ] 跑 `npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css`
- [ ] 如启用 `web-development`，优先确认 `~/.codex/skills/web-development/` 是否可用；不可用时改用项目内等价模板 / 设计令牌 / 浏览器验证方式
- [ ] 准备好环境变量（见 ARCHITECTURE §5）
- [ ] {其他 checklist 项}

## 写代码时的核心规则

### 必须遵循

1. **遵循 DESIGN.md 的 Do's & Don'ts**——尤其 Don'ts 部分（如"不要渐变背景"、"不要 stock 照片"），不论看起来多自然都不能违反

2. **CONTENT.md 的三种模式**：
   - 📝 标记的文案——**原样使用**，不要替换或"优化"
   - 🤖 标记的需求——按需求 + DESIGN voice + BRIEF 语气生成，但生成完要主动给用户看一眼
   - 📦 标记的数据源——从指定路径读取，schema 见 ARCHITECTURE

3. **代码组织**——严格按 ARCHITECTURE §7 的目录结构

4. **不要引入未在 ARCHITECTURE 中列出的依赖**——如果发现需要新依赖，先停下来和用户讨论、更新 ARCHITECTURE 再装

5. **前端实现参考 web-development，但不越权**——页面代码、CSS 模式、响应式、a11y、SEO、性能和排错可参考 `web-development`；需求边界、内容、依赖和视觉决策仍以 BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT 为准

6. **复杂开发用 phase 管理**——当改动满足任一条件时，**必须**触发 `first-flight-phases` skill：
   - 改动跨 ≥ 5 个步骤
   - 跨多个文件 / 模块
   - 跨多次会话才能完成（如"实现整个首页"）
   - 新功能（设计 + 实现 + 验证）
   - 重构

   不要一口气做完——建立 `.plan/plan.md` + `.plan/phases/NN-*.md`，每个 phase 完成后停下让用户验收。**首次开发和后续新功能都用同一套**。phases skill 内有完整规则（状态符号、Evidence 强制、Gate 流程、三种例外处理、不能自行 commit / 跳过任务）。

### 编码风格

- TypeScript strict mode
- 组件名 PascalCase
- 工具函数 camelCase
- {其他来自 ARCHITECTURE §7 命名约定}

### 交付前自检 / PR Readiness

当本次迭代准备交付、准备 PR、准备合并或准备上线时，先跑 `first-flight-phases` 的 **PR Readiness Gate**。这是迭代收口检查，不是每个 phase 都跑。

- [ ] 原始意图复核：重读 BRIEF / DESIGN / ARCHITECTURE / 当前 PRD / plan.md，确认实际完成没有偏离
- [ ] 主分支同步：检查 `git status`；需要 rebase / merge 时先确认目标分支，冲突解决后重新验证
- [ ] 对抗式 review：按 reviewer 视角检查需求漏项、scope creep、回归风险、a11y / 性能 / 安全、文档漂移
- [ ] 端到端测试：优先跑已有 E2E；没有 E2E 时手工走关键用户路径
- [ ] Evidence 汇总：记录关键文件路径、命令、测试结果、预览链接 / 截图路径（如有）
- [ ] 文档同步：代码行为、页面结构、依赖、配置或设计变化已同步到对应 spec
- [ ] `pnpm lint` / `pnpm typecheck` / `pnpm build` 全通过（按项目实际命令调整）
- [ ] `npx @google/design.md lint DESIGN.md` 通过（如改了 DESIGN）
- [ ] 如启用 `web-development`，静态 HTML 已跑 `verify-html.py`（若可用）或项目等价检查；框架项目已完成真实浏览器 + console + 320/768/1200 响应式验证
- [ ] Lighthouse Performance ≥ {目标} / Accessibility ≥ {目标}（如改了关键路径）
- [ ] PR 草稿已准备：Summary / Scope / Validation / Evidence / Risks / Rollback / Open Questions

默认只准备 PR 草稿和验证报告，不替用户 push、创建 PR 或 merge，除非用户明确要求。

### Spec Sync（按文档类型分类同步）

**核心原则**：spec 是 source of truth，代码是它的实现。但**不同类型文档同步规则不同**——把更新归到对的地方。

#### 文档分两类

**长期文档（根目录，跨迭代共用）**：
- `BRIEF.md` — 项目本质，几乎不变
- `DESIGN.md` — 视觉风格，偶尔演进
- `ARCHITECTURE.md` — 技术栈，偶尔演进
- `AGENTS.md` + `CLAUDE.md` — 协作规则

**迭代产物（iterations/v{N}-{slug}/，每次迭代一份）**：
- `PRD.md` — 本次迭代的需求规划
- `CONTENT.md` — **仅 v1-launch 有**（后续迭代不再写）
- `.plan/plan.md` + `phases/NN-*.md` — 本次迭代的实施过程

#### 三种改动 → 三种处理

**1. 改动影响长期文档（增量更新根目录）**

- 用户决定主色调整 → 更新 `DESIGN.md` YAML `colors.primary`
- 装一个新 npm 包 → 更新 `ARCHITECTURE.md` §3 依赖
- 换部署平台 / 加新第三方服务 → 更新 `ARCHITECTURE.md` §5/§6
- 协作规则要变（如"AI 中文回复"）→ 更新 `AGENTS.md`

**2. 改动影响当前迭代（更新 iterations/v{N}-{slug}/ 下文件）**

- 当前迭代里某个页面布局微调 → 更新当前迭代的 `PRD.md` §5
- 最终确认某个 🤖 AI 生成的文案（仅 v1-launch 有效）→ 更新 `iterations/v1-launch/CONTENT.md` 该槽从 🤖 改成 📝
- phase 进度变化 → 更新当前迭代的 `.plan/` 下相应文档

**3. 新的需求 / 功能要做了 —— 开新迭代，不要动旧文件！**

- 用户说"加 /blog 路由" / "改 checkout 流程" / "做暗黑模式" / "加搜索功能" 等
- → **绝对不要**修改 `iterations/v1-launch/PRD.md`（那是历史快照）
- → 触发 `first-flight-prd` skill 走"迭代"路径，自动写到新 `iterations/v{N}-{slug}/PRD.md`
- → 后续不再写 CONTENT.md（新内容靠 CMS / JSON / API 管理）
- → `first-flight-phases` skill 在 `iterations/v{N}-{slug}/.plan/` 下管理实施

#### 边界级变更 ⚠️

如果用户要做的事和 BRIEF "永远不做的事" 冲突（如 BRIEF 写"永远不做评论"但用户要加评论功能）——**停下！** 不是 Spec Sync，是 BRIEF 级变更：
- 选项 A：先和用户确认要改项目方向，更新 BRIEF.md，再开新迭代
- 选项 B：让用户收窄需求，不动 BRIEF
- 不要默认接受冲突需求

#### 判断原则

"下次 AI 看到这个项目时需要知道吗？"
- 是 → 进对应 spec（按上面三种处理判断哪个）
- 否 → 只是实现层面的微调，不必

### 用户特别强调的规则

{从用户额外规则收集}

## 工具链常用命令

```bash
# 启动开发
pnpm dev

# 类型检查 + lint
pnpm typecheck && pnpm lint

# 构建
pnpm build

# 导出 design tokens（每次改 DESIGN.md 后跑）
npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css

# 校验 DESIGN.md（含 WCAG 对比检查）
npx @google/design.md lint DESIGN.md

# 静态 HTML 质量验证（启用 web-development 且脚本可用时）
python3 ~/.codex/skills/web-development/scripts/verify-html.py path/to/file.html

# 部署
{从 ARCHITECTURE §6 提取}
```

## 在哪里找信息

| 问题 | 去哪查 |
|---|---|
| 这个项目最终长期要变成什么样？ | BRIEF.md |
| 第一版要做哪些页面 / 功能？ | PRD.md §页面结构、§信息架构 |
| 这个按钮 / 卡片应该长什么样？ | DESIGN.md §Components、§Shapes |
| 用什么色 / 字体？ | DESIGN.md YAML front matter |
| 用什么技术栈 / 库？ | ARCHITECTURE.md §3 |
| 前端实现、CSS 模式、响应式、a11y、SEO、性能、排错怎么做？ | web-development skill（按 ARCHITECTURE 启用时） |
| 这个区块应该放什么内容？ | CONTENT.md（按页面 / 区块 / 内容槽查） |
| 部署到哪？怎么部署？ | ARCHITECTURE.md §6 |
| 性能 / a11y 目标是多少？ | ARCHITECTURE.md §8 + DESIGN.md §Accessibility |

## 协作姿态

- **请向用户提问而不是默认假设**——First Flight 的设计原则是"不确定先问"
- **遇到 BRIEF 边界冲突要停下**——比"我自己判断"重要得多
- **改文档要更新对应的 spec 文件**——比如改了 page 结构要回去更新 PRD，改了配色要更新 DESIGN
- **保持文档的"权威性"**——5 份文档是 source of truth，代码是文档的实现

## 这是用 First Flight 生成的

本项目的 6 份文档（BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT / AGENTS）由 First Flight skill 系列引导生成。如需重新走 First Flight 或了解整个流程，参考 First Flight 的父 skill 文档。
