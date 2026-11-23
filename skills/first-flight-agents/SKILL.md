---
name: first-flight-agents
description: First Flight 系列的第 6 步（最后一步）——基于已生成的长期文档（BRIEF / DESIGN / ARCHITECTURE）和当前迭代文档（iterations/v{N}-{slug}/PRD.md，v1 还需要 CONTENT.md）自动生成 AGENTS.md（通用 AI 入口文档，兼容 Codex / Claude 等 agent）+ CLAUDE.md（一句话指向 AGENTS.md）。当用户已经走完 CONTENT.md 准备进入最后一步、或者说"帮我生成 AGENTS.md / 让 AI 能上手这个项目 / wrap up the First Flight"时，请务必使用这个 skill。这是 First Flight 流程的第 6 步（BRIEF → PRD → DESIGN → ARCHITECTURE → CONTENT → **AGENTS**），但生成前必须先跑源文档发现和生成质量门禁。
---

# First Flight · AGENTS

帮用户产出 `AGENTS.md`（+ 一行的 `CLAUDE.md`）——**这是 First Flight 流程的最后一步，把前面 5 份文档串起来给 AI 用**。

## AGENTS.md 是什么

**AGENTS.md 是 AI agent 进入项目的入口文档**。当用户把项目目录交给 Codex、Claude 或其他兼容 agent 时，agent 应该首先读 AGENTS.md，理解项目结构、读其他文档的顺序、写代码时该遵循什么规则。

沿用 AGENTS.md 文件名约定：
- 项目根目录的 AGENTS.md = AI 入口
- CLAUDE.md = 一行内容指向 AGENTS.md（保持 Claude Code 的优先识别）

## 与其他文档的分界

- **AGENTS.md**（这个 skill 的输出）：项目简介 + 文档清单 + 阅读顺序 + 写代码时的核心规则 + 工具链命令
- **CLAUDE.md**（同时生成）：一行 `本项目以 AGENTS.md 为准。请先读 AGENTS.md。`
- **AGENTS.md 不是**：另一份 BRIEF 或 PRD（不要重复前 5 份的内容）；它**只是地图**，告诉 AI 去哪儿找信息

## 这一步几乎不需要新提问

到这一步，用户已经回答了所有实质问题。AGENTS.md 的内容**几乎完全可以从前面的 First Flight 文档机械生成**——不需要再批量提问，但不能在源文档缺失或路径不清时自行脑补。

只需要问 **1 个轻量问题**：

> AGENTS.md 是 AI 进入项目的入口。我会基于你之前的 5 份文档自动生成。在生成前，你有没有特别想强调的规则？例如：
> - "禁止在 BRIEF 边界之外发挥"
> - "所有新功能必须先更新 PRD 再写代码"
> - "交付前必须跑 PR Readiness Gate"
> - "中文回复，代码注释用英文"
>
> 没有的话我直接生成。

记下用户的额外规则（可能 0-5 条），写进 AGENTS.md 的"协作规则"章节。

## 整体流程

```
Step 0   源文档发现 + 生成质量门禁
   ↓
Step 1   读 BRIEF + DESIGN + ARCHITECTURE + 当前迭代 PRD（v1 还读 CONTENT）
   ↓
Step 2   问用户 1 个轻量问题：有没有特别想强调的协作规则
   ↓
Step 3   机械生成 AGENTS.md + CLAUDE.md 预览
   ↓
Step 4   生成质量检查 → 用户确认 → 写文件
```

## Step 0：源文档发现 + 生成质量门禁

先发现项目文档位置，再生成。不要假设 `PRD.md` / `CONTENT.md` 在项目根目录。

**必须读取：**
- 根目录长期文档：`BRIEF.md` / `DESIGN.md` / `ARCHITECTURE.md`
- 当前迭代 PRD：默认取 `iterations/v{N}-{slug}/PRD.md` 中 N 最大的一份；用户明确指定迭代时按用户指定
- CONTENT：仅 `v1-launch` 必须读取 `iterations/v1-launch/CONTENT.md`；后续迭代通常没有 CONTENT，不要新造

**缺失处理：**
- 缺 `BRIEF.md` / `DESIGN.md` / `ARCHITECTURE.md` / 当前迭代 `PRD.md`：停止，不生成完整 AGENTS，告诉用户缺哪个上游文档
- 首次开发缺 `iterations/v1-launch/CONTENT.md`：停止，让用户先跑 `first-flight-content`
- 后续迭代缺 CONTENT：正常继续，并在 AGENTS 里说明 CONTENT 只适用于 v1
- 任何要复制进 AGENTS 的项目事实找不到来源：不要猜，写成用户需要确认的问题或停止询问

**模板权威顺序：**
1. `assets/agents-template.md` 是生成 AGENTS.md 的结构源
2. 本 SKILL.md 的内联模板用于解释规则；若和 asset 冲突，以 asset 为准
3. `references/example-agents.md` 只用于校准语气和粒度，不能覆盖当前模板、路径或项目事实

**生成前建立 source map：**

```text
项目一句话 <- BRIEF.md
本质边界 <- BRIEF.md
技术栈 / checklist / 命令 <- ARCHITECTURE.md
设计规则 / Do's & Don'ts <- DESIGN.md
当前迭代范围 <- iterations/v{N}-{slug}/PRD.md
内容槽规则 <- iterations/v1-launch/CONTENT.md（仅 v1）
用户特别规则 <- 本轮对话
```

## AGENTS.md 模板

```markdown
# {项目名} · AGENTS

> 这份文档是 Codex / Claude 进入本项目的入口。拿到项目目录后，请先读完这份文档再开始工作。

## 项目一句话

{从 BRIEF §"一句话定义"复制}

## 文档地图

本项目由 First Flight 生成，文档分两类。**长期文档先读、迭代产物按需读**：

**长期文档（项目根，跨迭代共用）：**

| 文档 | 内容 | 字数 |
|---|---|---|
| [BRIEF.md](./BRIEF.md) | 项目长期纲领（本质、用户、价值、边界） | ~{字数} |
| [DESIGN.md](./DESIGN.md) | 视觉与 UX 风格（Google DESIGN.md 标准 + 扩展） | ~{字数} |
| [ARCHITECTURE.md](./ARCHITECTURE.md) | 技术栈、代码组织、部署 | ~{字数} |
| [AGENTS.md](./AGENTS.md) | 本文件——AI 入口 + 协作规则 | - |

**迭代产物（`iterations/v{N}-{slug}/`）：**

| 文件 | 内容 |
|---|---|
| `iterations/v1-launch/PRD.md` | 首版功能、信息架构、目标衡量 |
| `iterations/v1-launch/CONTENT.md` | 首版内容（仅 v1） |
| `iterations/v{N}-{slug}/.plan/` | 各迭代的 plan + phase 实施目录 |

## 项目本质边界（来自 BRIEF）

**永远会是的**：
- {复制自 BRIEF §本质边界}

**永远不做的**：
- {复制自 BRIEF §本质边界}

⚠️ 任何看似偏离这些边界的请求，请先停下来和用户确认；不要默认接受。

## 技术栈一句话（来自 ARCHITECTURE）

{复制自 ARCHITECTURE §1}

详细决策见 [ARCHITECTURE.md](./ARCHITECTURE.md)。

## 前端实施知识库（来自 ARCHITECTURE）

如果 ARCHITECTURE 启用了 `web-development`，写代码阶段按它作为前端执行参考：

- 静态站 / 单文件 HTML / 落地页可优先复用 `web-development/templates/starter-template.html` 或 `web-development/assets/tokens.css`
- HTML/CSS/JS、响应式、a11y、SEO、Core Web Vitals、动效和排错优先查 `web-development/references/`
- 如果本机存在 `~/.codex/skills/web-development/scripts/verify-html.py`，静态 HTML 交付前跑它；否则使用项目等价的浏览器、console、响应式断点验证并记录 evidence
- `web-development` 只管前端实现和验证；BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT 在需求、内容、依赖、视觉决策上永远优先

## 写代码前的准备（来自 ARCHITECTURE §12 checklist）

如果还没做完这些，先停下来提醒用户：

- [ ] 跑 `npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css` 把 DESIGN tokens 导成 Tailwind v4 theme
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
6. **复杂开发用 phase 管理**——改动 ≥ 5 步骤 / 跨多文件 / 跨多次会话时，**必须**触发 `first-flight-phases` skill，建立 `.plan/plan.md` + `.plan/phases/NN-*.md`，每个 phase 完成后停下让用户验收。**不要一口气做完**。phases skill 内有完整规则（状态符号、Evidence 强制、Gate 流程、三种例外处理、不能自行 commit / 跳过任务）。**首次开发和后续新功能都用同一套**。

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

### Spec Sync（按文档类型分类同步 —— 关键改动！）

**核心原则**：spec 是 source of truth，但**不同类型文档同步规则不同**。把更新归到对的地方。

#### 文档分两类（生成 AGENTS.md 时要解释清楚）

**长期文档**（根目录，跨迭代共用）：BRIEF / DESIGN / ARCHITECTURE / AGENTS / CLAUDE
**迭代产物**（`iterations/v{N}-{slug}/`，每次迭代一份）：PRD / CONTENT（仅 v1）/ `.plan/` 工作目录

#### 三种改动 → 三种处理

1. **改动影响长期文档** → 增量更新根目录文件（如主色调整 → DESIGN; 装新包 → ARCHITECTURE）
2. **改动影响当前迭代** → 更新 `iterations/v{N}-{slug}/` 下文件（如当前迭代页面微调 → 当前迭代的 PRD.md）
3. **新需求 / 新功能** → **开新迭代**！不要动 `iterations/v1-launch/PRD.md`，触发 first-flight-prd skill 写新一份 `iterations/v{N+1}-{slug}/PRD.md`

#### 边界级变更

用户要做的事和 BRIEF "永远不做的" 冲突（如要加评论功能，BRIEF 说永远不做评论）：
- ⚠️ 停下，不是普通 Spec Sync 是 BRIEF 级变更
- 选项：要么更新 BRIEF 重审项目方向；要么收窄需求；不要默认接受

#### 判断原则

"下次 AI 看到这个项目时需要知道吗？" 是 → 进对应 spec；否 → 实现层面微调，不必。

### 用户特别强调的规则
{从 Step 1 收集的用户额外规则}

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

# 部署（platform-specific）
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

本项目的 6 份文档（BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT / AGENTS）由 [First Flight](https://github.com/...) skill 系列引导生成。如需重新走 First Flight 或了解整个流程，参考 First Flight 的父 skill 文档。
```

## CLAUDE.md 内容（一行）

```markdown
# CLAUDE.md

本项目以 [AGENTS.md](./AGENTS.md) 为准。请先读 AGENTS.md 再开始工作。
```

## Step 4：生成质量检查 + 预览 + 写文件

把 AGENTS.md 内容展示给用户预览：

> 这是基于你前面 5 份文档自动生成的 AGENTS.md。看一下，有没有要调整的？

**预览前必须自检：**

- 源文档齐全：长期文档 + 当前迭代 PRD + v1 CONTENT（如适用）
- 文档地图没有把 `PRD.md` / `CONTENT.md` 错放到项目根目录
- AGENTS 正文没有残留 `{...}`、`{{TODO}}`、示例项目名或示例路径
- 相对链接从项目根能打开；当前迭代路径指向真实 `iterations/v{N}-{slug}/`
- `web-development` 只在 ARCHITECTURE 启用时出现；出现时包含“实现/验证 only + source-of-truth 优先级 + 不可用 fallback”
- 用户额外规则逐条写入，没有弱化或改写成泛泛规则
- CLAUDE.md 只有一行指向 AGENTS.md

**写文件 checkpoint：**
- 预览后必须等用户明确同意再写 `./AGENTS.md` + `./CLAUDE.md`
- 如果用户说“只预览 / 先别写 / 不要落文件”，停在预览，不写文件
- 写完后告诉用户实际写入路径和下一步命令

## Step 5：完结庆祝

```
> 🎉 First Flight 完成！
>
> 你的项目目录现在有了完整的 First Flight 文档：
> ```
> {项目名}/
> ├── BRIEF.md
> ├── DESIGN.md
> ├── ARCHITECTURE.md
> ├── AGENTS.md
> ├── CLAUDE.md
> └── iterations/
>     └── v1-launch/
>         ├── PRD.md
>         ├── CONTENT.md
>         └── .plan/
> ```
>
> **接下来你要做的事**：
>
> 1. 把这个文件夹移到你的代码项目目录
> 2. 跑 ARCHITECTURE §12 的 checklist（注册账号、装 Node、初始化 framework 等）
> 3. 跑 `npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css`
> 4. 把项目交给 Codex、Claude 或其他兼容 agent，让它先读 AGENTS.md 然后开始写代码
>
> 如果在写代码过程中发现 spec 需要改，**回来更新对应的 .md 文件**——它们是 source of truth。
>
> 祝起飞顺利 ✈️
```

## 写作风格守则

- AGENTS.md 是**地图**，不是**内容**——绝对不重复其他文档已经说过的事
- 每条规则都要**可执行**——"遵循 DESIGN" 不够，"遵循 DESIGN.md 的 Do's & Don'ts，尤其 Don'ts" 才够
- 对 AI 用**第二人称指令**（"请你 / 不要"），不要用"开发者应该"——AGENTS.md 是给 AI 看的
- 给出**具体命令**——`pnpm dev` 比"启动开发环境"好

## 参考

- `assets/agents-template.md`——AGENTS.md 模板
- `assets/claude-template.md`——CLAUDE.md 一行模板
- `references/example-agents.md`——Linka 作品集完整 AGENTS 示例
- AGENTS.md 文件名约定——Codex / Claude 进入项目时的入口文档格式
