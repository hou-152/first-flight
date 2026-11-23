---
name: first-flight
description: First Flight 的总入口和流程导览——「建站元技能」plugin 里的核心 0→1 工作流，帮人从 0 到 1 把网站搭建出来的 spec-driven skill 系列。当用户说"我想做一个网站但不知道从哪开始"、"帮我搭一个个人 / 公司 / 产品网站"、"想用 AI 帮我把网站做出来"、"我有个网站的想法，怎么开始"、"want to build a website from scratch / start a new site"，或者用户描述了一个**尚未启动**的网站项目、需要先理清楚一系列文档才能让 AI 接手开发时，请务必使用这个 skill。First Flight **只服务于"第一次起飞"——从零搭起一个网站**，不处理已有项目的迭代。它会引导用户依次产出：Step 0 问题定义（双向钢人论证）→ BRIEF（长期纲领）→ PRD（首版功能与信息架构）→ DESIGN（视觉风格）→ ARCHITECTURE（技术选型）→ CONTENT（内容填充）→ AGENTS（AI 入口文档）。完成后用户复制这 6 份文档到自己的代码项目里，就可以让 AI 全自动开始搭网站。
---

# First Flight

First Flight 是一套帮普通人（不一定是开发者）和 AI 协作把网站**从 0 搭到 1** 的 spec-driven skill 系列。

它的核心假设：**对 AI 来说，'写代码'的瓶颈早已不是代码本身，而是'用户到底想要什么'**。所以 First Flight 把"想清楚"这一步拆成 Step 0 问题定义 + 6 份文档，每份都用一个专门的子 skill 通过对话产出。用户拿着这 6 份文档去自己的项目里，AI 就能全自动开始干活。

## 什么时候用 First Flight

**用**：
- 用户想做网站但完全不知道从哪开始
- 用户脑子里有想法，但不知道怎么和 AI 讲清楚
- 用户准备和 AI 协作开发网站，但项目还没启动
- 用户说"帮我做个网站"这种宽泛的需求

**不用**：
- 用户已经有上线的网站、想做迭代 / 加功能（First Flight 不管这个）
- 用户只问技术问题（如"Vue 怎么写 ...")
- 用户已经有完整 spec、只是想找人写代码

## 整体流程

```
═══ 首次开发（项目 0→1，每个新项目一次）═══════════════════════
┌─────────────────────────────────────────────────────────┐
│  STEP 0 · 问题定义（双向钢人论证）确认要解决的问题本身成立 │
│  ↓                          → first-flight-grill         │
│  STEP 1 · BRIEF.md          长期纲领（项目本质）          │
│  ↓                          → first-flight-brief         │
│  STEP 2 · PRD.md            首版功能 + 信息架构 + 目标    │
│  ↓                          → first-flight-prd           │
│  STEP 3 · DESIGN.md         视觉与 UX 风格                │
│  ↓                          → first-flight-design        │
│  STEP 4 · ARCHITECTURE.md   技术选型 + 代码组织           │
│  ↓                          → first-flight-architecture  │
│  STEP 5 · CONTENT.md        每个内容槽要填什么            │
│  ↓                          → first-flight-content       │
│  STEP 6 · AGENTS.md + CLAUDE.md   AI 入口文档            │
│  ↓                          → first-flight-agents        │
│  STEP 7 · plan.md + phases  分 phase 实施 v1-launch     │
│                             → first-flight-phases        │
└─────────────────────────────────────────────────────────┘
═══ 后续迭代（v2 / v3 / ...，每次新功能或重构）═════════════
┌─────────────────────────────────────────────────────────┐
│  STEP 1 · PRD.md            本轮迭代要做的事              │
│  ↓                          → first-flight-prd（迭代模式）│
│  STEP 2 · plan.md + phases  分 phase 实施                 │
│                             → first-flight-phases         │
│  • BRIEF/DESIGN/ARCHITECTURE/AGENTS 不动（长期文档）       │
│  • CONTENT 不再写（迭代时内容靠 CMS / JSON / API）        │
└─────────────────────────────────────────────────────────┘
```

**Spec 阶段**（Step 0 + 6 个 sub-skill）：每一步的产出是下一步的输入。这个顺序的理由：
- **PRD → DESIGN**：产品需求定下来后，自然进入"它长什么样"
- **DESIGN → ARCHITECTURE**：设计风格 / UI 模式（比如要不要用 bento grid、要不要复杂动效）会影响 UI 框架选型，进而影响架构
- **ARCHITECTURE → CONTENT**：架构定了内容怎么存（flat MD / CMS / JSON），再来填内容才知道往哪里放
- **CONTENT → AGENTS**：内容是最后才补充的（也最容易后期再改），最后用 AGENTS.md 把所有文档串起来给 AI 用

**开发实施阶段**（phases sub-skill）：spec 文档完成后用户开始写代码时启用。**强制 AI 边做边更新进度，每个 phase 完成停下来让用户验收**，避免一口气做完导致失控。**首次开发和后续新功能都用同一套**——所以 phases skill 是反复使用的工具，跟 spec skill 不同生命周期。

AGENTS.md 把所有 spec 文档 + phases skill 规则串起来，用户复制整个文件夹到自己的代码项目里，AI 就有了完整上下文。

## 两种使用模式：交互式 vs 非交互（batch）

First Flight 支持两种模式：

### 交互式模式（默认）
通过对话依次走 6 步，skill 引导你回答问题，最终生成填好的文档。适合：
- 不太确定细节，想被引导思考
- 希望对话过程本身帮你理清思路
- 第一次做这种 spec 文档

### 非交互 / batch 模式
你给一段对项目的描述，AI 一次性生成 6 份**带占位符 + 明显 TODO 标注**的初稿骨架。你打开 IDE 自己继续填写 / 调整。适合：
- 已经知道自己要什么、想快速起步
- 习惯边写边想、IDE 比对话舒服
- 想要先有个完整 spec 骨架再迭代

**batch 模式触发短语**：用户说"非交互"、"我自己填"、"直接给模板"、"不要走对话流程"、"batch mode"、"先给空骨架"、"我用 IDE 改"、"我不想一步步聊" 等。

**模式选择**：
- 用户**未明说**——父 skill 在第一次回应时**显式问一下**：要走交互流程还是 batch 一次性出骨架？默认建议交互。
- 用户**已明说 batch**——直接进 batch，不再问。

## 入口逻辑：先识别首次还是迭代

**任何时候被激活，第一件事是检查 `./iterations/` 目录**：

- **不存在 / 空** → 这是首次开发，走完整 8 步流程（GRIL→BRIEF→PRD→DESIGN→ARCHITECTURE→CONTENT→AGENTS→phases）
- **存在且有 v{N}-{slug}/ 目录** → 项目已经走过 First Flight，这次是**迭代**——走简化流程（只跑 PRD 迭代版 + phases）

**用户说什么压过自动检测**：如果用户明确说"这是首次"（即使 iterations/ 存在）、或"这是迭代"（即使 iterations/ 不存在），尊重用户。但要提示对方注意可能的覆盖风险。

### 首次开发：完整 8 步

Step 0（`first-flight-grill`）不产文件——只在对话中形成一页"问题定义"，作为 BRIEF 的输入锚点。正式文件产出位置：
```
project/
├── BRIEF.md              ← 根目录（长期文档）
├── DESIGN.md             ← 根目录（长期文档）
├── ARCHITECTURE.md       ← 根目录（长期文档）
├── AGENTS.md             ← 根目录（长期文档）
├── CLAUDE.md             ← 根目录（长期文档）
└── iterations/
    └── v1-launch/        ← 默认名，可改
        ├── PRD.md        ← 首版 PRD
        ├── CONTENT.md    ← 首版内容（仅首次需要）
        └── .plan/        ← 实施 v1-launch 的 phase 工作目录
            ├── plan.md
            └── phases/
```

### 后续迭代：精简 2 步

读已有的长期文档（BRIEF/DESIGN/ARCHITECTURE/AGENTS）作为锚点，**不再生成 CONTENT.md**（迭代时内容应由 CMS / JSON / API 等管理，CONTENT.md 反而是负担）。

文件产出位置：
```
project/
├── ...（长期文档保持不变）
└── iterations/
    ├── v1-launch/        ← 历史保留，不动
    │   └── ...
    └── v2-{slug}/        ← 本次迭代
        ├── PRD.md        ← 迭代版 PRD（读 v1 的 PRD 作锚点）
        └── .plan/        ← 实施本次迭代的 phase 工作目录
```

**迭代命名约定**：`v{N}-{slug}`。N 是已存在迭代数 + 1（如已有 v1-launch、v2-blog，新一轮叫 v3）。slug 用户给（如 `checkout-redesign`），没给就追问，避免起 `iteration` 这种空名。

### 长期文档何时改？

只有"项目级"变更才改根目录文档：
- BRIEF：本质边界要扩 / 缩（罕见，且应该停下问用户）
- DESIGN：色彩 / 字体 / 组件风格调整
- ARCHITECTURE：加 / 换 npm 包、改部署平台
- AGENTS：协作规则 / 强调项变化

不要把"v2 要做的页面 / 内容"这种**迭代级**变化塞回 BRIEF 或 DESIGN——它们归当次迭代的 PRD。

## 这个父 skill 的工作（交互模式）

当用户用一个**宽泛的"想做网站 / 加新功能"诉求**激活这个 skill 时：

1. **检测 iterations/**——判断首次还是迭代
2. **简短解释当前路径**——告诉用户走的是首次还是迭代分支
3. **展示对应流程简图**——首次 8 步 / 迭代 2 步
4. **询问模式 + 准备开始**——首次时问交互 / batch，迭代时直接走交互

**关键原则**：父 skill 本身**不做任何具体的内容生成**（交互模式下）——它只是导览和入口。所有实际工作都在子 skill 里（首次 7 个：grill + 6 个 spec 子 skill；迭代 1 个：prd）。

### 父 skill 的开场白模板 —— 首次开发（iterations/ 不存在）

> 听起来这是个全新的网站项目。我来用 First Flight 这套流程帮你把它做出来。
>
> First Flight 是一套引导你**从 0 到 1 搭建网站**的方法——先确认问题成立，再通过 6 份文档 + 1 个开发管理流程，把你脑子里的想法整理清楚，然后 AI 就能按 phase 把网站做出来。流程是：
>
> 0. **GRIL** —— 双向钢人论证：先确认你真正要解决的问题，再决定要不要建站
> 1. **BRIEF** —— 项目长期纲领（这是什么、给谁、为什么做）
> 2. **PRD** —— 首版要做的页面、信息架构、目标
> 3. **DESIGN** —— 视觉与 UX 风格
> 4. **ARCHITECTURE** —— 技术选型与代码组织
> 5. **CONTENT** —— 每个页面上要放什么内容
> 6. **AGENTS** —— 把上面 5 份串起来给 AI 用
> 7. **plan + phases** —— 分阶段实施（每个 phase 完成你来验收）
>
> 文件会放在你项目根目录（长期文档）和 `iterations/v1-launch/`（这次首发的产物）。后续要做 v2 / v3 时，会另起 `iterations/v{N}-{slug}/`，长期文档不动。
>
> 有两种走法：
>
> **A. 交互流程**（推荐）—— 一件一件来，每一步通过对话回答问题，每一步完成都能停下来检查。
>
> **B. 一次性骨架**（batch）—— 你给我一段对项目的描述，我一次生成 6 份带 TODO 标注的初稿，你打开 IDE 自己改。
>
> 想走哪种？

如果用户选 A 或未指明（默认 A），立即切换到 `first-flight-grill` skill（先做 Step 0 问题定义，再进 brief）。
如果用户选 B 或之前已明说"我自己填 / batch"，进入下方"batch 模式工作流"。

### 父 skill 的开场白模板 —— 迭代（iterations/v1+ 已存在）

> 我看到你的项目已经有 First Flight 的产物（{已存在的迭代名}）。这次是要做新一轮迭代对吗？
>
> 我会读现有的 BRIEF / DESIGN / ARCHITECTURE / 上一份 PRD 作为锚点，然后引导你写 **本次迭代的 PRD**——不会动那些长期文档。本次迭代将放在 `iterations/v{N+1}-{你给的 slug}/`。
>
> CONTENT 这一步**不会再走**——首版上线后，新内容应该通过 CMS / JSON / API 等方式管理，不再用 CONTENT.md 文档。
>
> PRD 写完后会自动接 phases skill，按 phase 实施这次迭代。
>
> 这次迭代你想叫什么？给我一个简短的 slug（比如 `blog` / `checkout-redesign` / `i18n`）。

收到 slug 后，立即切换到 `first-flight-prd` skill（它会自动检测迭代场景）。

## batch 模式工作流（父 skill 直接处理，不走子 skill 对话）

batch 模式下父 skill 自己包办整套骨架生成，**不**调起子 skill 的对话流程（Step 0 问题定义以骨架中的一节占位体现）。

### Step 1：让用户给一段项目描述

> 给我一段对项目的描述就行——不用结构化，想到哪写到哪。我会基于它给你一份 6 份文档的初稿骨架，需要你填的地方会用 `{{TODO: ...}}` 显眼标出来。
>
> 至少告诉我：项目是什么、给谁、长什么样的网站类型（个人 / 公司 / 产品 / 博客 / 等等）就行，其他细节我帮你猜默认值，你后面 IDE 里改。

### Step 2：基于描述初划 6 份骨架

读子 skill 的 `assets/*-template.md` 作为基础结构。把用户描述中明确的信息**直接填进去**，不确定的位置**用 `{{TODO: ...}}` 标注**。

**TODO 标注的写法**：

```markdown
## 一句话定义
{{TODO: 一句话讲清楚"网站类型 + 给谁 + 解决什么"。30-50 字。
  我从你的描述里推测可能是 "XXX"，但请确认。}}

## 长期成功的样子
{{TODO: 长期跑顺以后这个网站扮演什么角色？1 年以上的时间尺度。
  例子方向：成为接客户时拿得出手的第一名片 / 主要获客入口 / 等}}
```

**填写策略**：
- 用户描述里有明确信息（如"个人作品集"、"我是设计师"）→ 直接写
- 标准默认值（如 Astro 静态作品集栈、Editorial 预设、Tailwind v4）→ 直接写默认
- 真正需要用户思考 / 选择的（长期成功、具体 KPI、具体 do's & don'ts、域名、第三方账号等）→ `{{TODO: ...}}` 标注
- AI 能基于推断给候选的 → 给 2-3 个候选让用户挑：`{{TODO: 主色候选 #2563EB / #1D4ED8 / #0F172A，挑一个或给你想要的 hex}}`

### Step 3：6 份骨架一次性写到目录（按新结构！）

写入位置严格按"长期文档在根 + 迭代产物在 iterations/v1-launch/"分配：

**根目录（5 份长期文档）：**
- `BRIEF.md`
- `DESIGN.md`
- `ARCHITECTURE.md`
- `AGENTS.md`
- `CLAUDE.md`

**`iterations/v1-launch/` 目录（2 份迭代产物）：**
- `PRD.md`
- `CONTENT.md`

全部含 `{{TODO}}` 标注。

### Step 4：生成 WHERE-TO-START.md 导航

最后多写一份 `WHERE-TO-START.md`：

```markdown
# 你的 First Flight 骨架已就绪

文件分两层：
- **根目录**：BRIEF / DESIGN / ARCHITECTURE / AGENTS / CLAUDE（长期文档，项目生命周期一直用）
- **iterations/v1-launch/**：PRD.md + CONTENT.md（首版迭代产物）

按这个顺序填写：

1. **BRIEF.md** ← 最重要，先填。决定后面所有方向
2. **iterations/v1-launch/PRD.md** ← 决定页面 / 信息架构 / 目标
3. **DESIGN.md** ← 视觉与 UX。YAML front matter 里的 token 可以用 `npx @google/design.md lint` 校验
4. **ARCHITECTURE.md** ← 技术栈。不确定可以保留默认
5. **iterations/v1-launch/CONTENT.md** ← 内容填充。看着 PRD 的信息架构填
6. **AGENTS.md** ← 几乎不用改，是给 AI 看的入口

每份文档里的 `{{TODO: ...}}` 是必须你来回答的问题。其他默认值我都先填了，你觉得不合适可以改。

填完后，把整个文件夹交给 Codex 或 Claude，让它读 AGENTS.md 然后开始按 phase 写代码。
```

### Step 5：完结提示

> 6 份骨架已经生成在你的项目目录。打开任意一个 markdown 文件，找 `{{TODO: ...}}` 标记的位置填写。建议从 BRIEF.md 开始。
>
> 填完后如果想再走对话流程检查任意一份文档，对我说 "review BRIEF" / "review PRD" / 等等，我会基于你填好的内容做一轮 review。

### 用户已经走到一半进入时

如果用户已经写过部分文档（如已经有 BRIEF.md 但还没 PRD），父 skill 可以：
- 用 ls / Glob 看看当前目录有哪些 `*.md` 已经存在
- 跳过已完成的步骤，从下一步开始
- 例如：发现 BRIEF.md 存在但 PRD.md 不存在 → 直接进入 `first-flight-prd`

### 用户不想走完整流程

如果用户明确只想做某一步（比如"我只想写 BRIEF"），尊重用户的选择，直接切到对应子 skill，不强行推完整流程。

## 设计原则（对所有子 skill 通用）

1. **Spec 阶段是 0 到 1 only**——Step 0 与 6 个 spec sub-skill 假设项目还没启动，没有现有代码 / 设计 / 内容。
2. **Phase 阶段反复使用**——phases sub-skill 不受 0→1 限制，首次开发 + 后续迭代 + 重构都用同一套。
3. **spec-driven**——不写代码，只产出 spec。代码留给用户复制 spec 到项目后让 AI 写。
4. **路径 A / B 分流**——每个子 skill 都会先识别用户经验度（小白 vs 有经验），用对应的措辞和节奏。
5. **预览再写文件**——所有最终文档都先在对话里展示，用户确认后再写文件。
6. **每步可停**——子 skill 写完文件会问"接着做下一步吗"。用户说停就停。
7. **不越界**——BRIEF 不写功能，PRD 不写视觉，DESIGN 不写代码。每个文档只管自己的范围。

## 子 skill 概览（给父 skill 自己 + 给用户参考）

**Step 0 sub-skill（只服务首次开发，不产文件，对话中形成问题定义）：**

| skill 名 | 产出 | 说明 |
|---|---|---|
| first-flight-grill | 对话中一页"问题定义" | 双向钢人论证：确认要解决的问题本身成立，再进 BRIEF |

**长期文档 sub-skill（只服务首次开发，写到项目根）：**

| skill 名 | 产出文件 | 字数预期 |
|---|---|---|
| first-flight-brief | `./BRIEF.md` | 200-400 字 |
| first-flight-design | `./DESIGN.md` | 2000-4000 字 |
| first-flight-architecture | `./ARCHITECTURE.md` | 2000-3000 字 |
| first-flight-agents | `./AGENTS.md` + `./CLAUDE.md` | ~2000 字 |

**迭代产物 sub-skill（首次 + 后续迭代都用，写到 iterations/v{N}-{slug}/）：**

| skill 名 | 产出文件 | 字数预期 |
|---|---|---|
| first-flight-prd | `iterations/v{N}-{slug}/PRD.md` | 800-2500 字 |
| first-flight-content | `iterations/v1-launch/CONTENT.md`（**仅首次**，迭代时不触发） | ≤ 2000 字 |
| first-flight-phases | `iterations/v{N}-{slug}/.plan/plan.md` + `phases/NN-*.md` | 自适应 |

## 写到哪里

所有产出文件都写到用户当前工作目录 `./`。在 Cowork 里，写到 outputs 目录并给 `computer://` 链接。

最终用户的项目目录看起来会是：

```
my-website-project/
├── BRIEF.md              ← 长期文档（项目级，所有迭代共用）
├── DESIGN.md             ← 长期文档
├── ARCHITECTURE.md       ← 长期文档
├── AGENTS.md             ← 长期文档（AI 入口）
├── CLAUDE.md             ← 一句话指向 AGENTS.md
├── iterations/           ← 每次迭代独立目录
│   ├── v1-launch/        ← 首次开发的产物
│   │   ├── PRD.md
│   │   ├── CONTENT.md    ← 仅首次有
│   │   └── .plan/
│   │       ├── plan.md
│   │       └── phases/
│   ├── v2-blog/          ← 后续迭代（如有）
│   │   ├── PRD.md
│   │   └── .plan/
│   └── ...
└── （代码 / content / public 等）
```
