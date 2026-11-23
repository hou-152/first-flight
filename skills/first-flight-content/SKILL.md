---
name: first-flight-content
description: First Flight 系列的**首次开发专属** skill——为 v1-launch 生成 CONTENT.md，把 PRD 信息架构里的每个内容槽（slogan / 副文案 / 作品列表 / etc.）用三种模式之一填上：📝 直接文案 / 🤖 AI 生成需求 / 📦 数据源。**只服务于首次开发**——后续迭代时**不要触发**这个 skill，因为迭代时新内容应该通过 CMS / JSON / API 等方式管理。当用户在首次开发流程中刚做完 ARCHITECTURE.md、或者用户说"帮我写网站文案 / 内容 / copywriting"、"create content spec for my site"、"我有 ARCHITECTURE 了下一步是 CONTENT"，且项目还没有 iterations/v1-launch/CONTENT.md 时，请使用这个 skill。这是 First Flight 首次流程的第 5 步（BRIEF → PRD → DESIGN → ARCHITECTURE → **CONTENT** → AGENTS → phases），输出位置是 `iterations/v1-launch/CONTENT.md`。
---

# First Flight · CONTENT

帮用户产出 `iterations/v1-launch/CONTENT.md`——把 PRD 信息架构里的每个**内容槽**（slogan / 副文案 / 作品列表 / 按钮文字 / 联系表单字段 / etc.）填上具体的东西，用三种模式之一标记。

**⚠️ 只服务于首次开发**——这个 skill 只在 `iterations/v1-launch/` 还没有 CONTENT.md 时触发。后续迭代时（v2+）**不再生成 CONTENT.md**，因为：
- 首版上线后，内容应该已经接到 CMS / JSON / API / Markdown 文件等管理机制
- 新一轮迭代如果有新内容，按现有管理机制添加
- 再写一份 CONTENT.md 反而和实际内容来源脱钩，变成"双写"负担

迭代触发时主动拒绝并指引：「我看到 iterations/v1-launch/CONTENT.md 已存在。本次是迭代，CONTENT.md 不再需要——直接进 phases 实施即可」。

三种模式（仅在首次需要时）：

- **📝 直接文案（COPY）**：用户已经写好了具体文字。**短文案（≤ 100 字）直接内联在 CONTENT.md；长文案（> 100 字）单独存到 `content/snippets/{name}.md`，CONTENT.md 只留 reference**
- **🤖 AI 生成需求（PROMPT）**：用户描述"想要什么样的"（语气 / 长度 / 关键词），写代码时由 AI 根据需求 + 品牌 voice 生成
- **📦 数据源（DATA）**：内容来自结构化文件（如 `content/works/*.mdx` 或 `data/projects.json`），附 schema 或样例骨架

## 与其他文档的分界

- **PRD.md** 已经定义了：每个页面 → 每个区块 → 每个内容槽。CONTENT **完全不重复**这个结构，只在每个槽下面标记"用什么模式 + 具体内容"。
- **DESIGN.md** 提供了品牌气质 / Do's & Don'ts——CONTENT 写文案 / 提示词时**必须遵循**这些（如 DESIGN 说"❌ 不要全大写"，CONTENT 的 slogan 就不能全大写）。
- **ARCHITECTURE.md** 决定了内容存储方式（MDX / JSON / Content Collections）——CONTENT 的 📦 数据源模式要**对齐** ARCHITECTURE 里的 schema。
- **CONTENT.md**（这个 skill 的输出）：按 PRD 的页面结构 → 区块 → 内容槽，每个槽标记模式 + 具体内容 / 需求 / 数据源
- **CONTENT 不写**：视觉细节、技术实现、信息架构本身

## 整体流程

```
Step 0   读 BRIEF.md + PRD.md + DESIGN.md + ARCHITECTURE.md
   ↓
Step 1   识别经验度 → 路径 A / B
   ↓
Step 2   按 PRD 的页面顺序逐个处理：
         对每个页面：
           1. 列出所有区块和内容槽（从 PRD 提取）
           2. skill 预判每个槽的"默认模式"（基于槽名启发式）
           3. 用户批量确认 / 调整模式 + 填具体内容
   ↓
Step 3   收集"全局内容资源"（如品牌色彩名称、口号库、社交链接、联系方式）
   ↓
Step 4   生成 CONTENT.md → 预览 → 写文件
   ↓
Step 5   自动衔接 AGENTS（First Flight 最后一步）
```

## Step 0：读前 4 份文档

必读 BRIEF + PRD + DESIGN + ARCHITECTURE。原因：
- PRD：所有内容槽的来源
- DESIGN：Do's & Don'ts + 字数 / 语气倾向（如"editorial 气质" → 文案偏 long-form）
- ARCHITECTURE：📦 数据源模式时引用的存储路径
- BRIEF：目标用户和核心价值——文案要呼应

## Step 1：识别经验度

`AskUserQuestion` 4 选项分到路径 A（小白）或路径 B（有经验）。

## 两条路径差异

**路径 A（小白）：**
- 默认推荐"🤖 AI 生成需求"模式（让小白只需要描述想要什么样的，AI 来写）
- 文案需求用大白话问，给参考方向
- 不强求一次填完所有内容槽——可以"先骨架，AI 写代码时再迭代文案"

**路径 B（有经验）：**
- 默认推荐"📝 直接文案"模式（用户通常自己写得更准）
- 允许混合三种模式
- 可以直接给 JSON schema 设计 📦 数据源

## Step 2：按页面逐个处理

### 启发式：每个槽的默认模式

基于槽名识别（路径 A 用户依赖这个）：

| 槽名特征 | 默认模式 |
|---|---|
| slogan / 一句话定位 / 副文案 | 🤖 AI 生成需求（用户给关键词，AI 写） |
| 主 CTA 文字 / 按钮文字 | 📝 直接文案（用户挑短词组） |
| 作品列表 / 文章列表 / 团队成员 / 产品 SKU 等**列表型** | 📦 数据源 |
| 个人简介 / 公司故事 / 长文 | 🤖 AI 生成需求（用户给大纲 + 语气） |
| 表单字段标签 / placeholder / 提交成功提示 | 📝 直接文案（短 + 标准） |
| 联系方式 / 邮箱 / 社交链接 | 📝 直接文案 |
| FAQ 列表 | 📝 直接文案 或 📦 数据源 |
| 案例研究 detail | 📦 数据源 + 单条用 📝 |

### 逐页面问的方式

对每个页面，用 1 个 `AskUserQuestion` 批量收集：

> 【首页】有这些内容槽（从 PRD 提取）：
>
> 1. slogan（1 句）——推荐用 🤖 AI 生成，你给关键词
> 2. 副文案（1-2 句）——推荐 🤖
> 3. 主视觉图——📦 数据源（指向作品的某张）
> 4. 精选作品（6-8 张）——📦 数据源（按 featured: true 过滤）
> 5. 简介一段（80-120 字）——推荐 🤖
> 6. CTA 按钮文字 ×2——📝 你直接给
>
> 你要逐个填还是先批量定模式？

路径 A 用户：skill 直接按推荐填，最后请用户检查
路径 B 用户：可以一条条调整

### 每种模式的写法

#### 📝 直接文案（COPY）——自适应拆分

**短文案（≤ 100 字）直接内联**：

```markdown
### Hero 区
- **slogan** 📝
  > 用画讲故事
```

**长文案（> 100 字）拆到独立文件 + reference**：

```markdown
### About 区
- **个人介绍长文**（约 300 字）📝
  > 见 [`content/snippets/about-bio.md`](./content/snippets/about-bio.md)
```

对应的独立文件 `content/snippets/about-bio.md`：

```markdown
# About bio
<!-- 用于 /about 页面的"个人介绍区"内容槽 -->

Linka 是一名独立设计师，现居杭州。她的工作分为两条线...

（接下来 300 字的完整文案）
```

**为什么自适应拆分**：CONTENT.md 是 AI 写代码时要反复读的索引，如果用户网站规模大、长文案多，CONTENT.md 会膨胀到几千字，吃掉大量 context。把 > 100 字的内容拆到 `content/snippets/*.md` 后，CONTENT.md 保持 \< 2000 字的"索引文档"角色，AI 只在真正需要某段长文案时才去读对应文件。

#### 🤖 AI 生成需求（PROMPT）

```markdown
### Hero 区
- **slogan** 🤖
  - **生成需求**：1 句话，10-15 字，温暖而非张扬，避开"用 AI 赋能"这种空话，避开全大写
  - **关键词**：插画、品牌、双线
  - **品牌 voice 参考**：见 DESIGN.md Do's & Don'ts
  - **示例方向**："像 The Verge 的标题那样有重量但不刻意"
```

AI 在写代码阶段读到这个需求 + DESIGN.md 的 voice + BRIEF 的定位，就能写出合规的 slogan。

#### 📦 数据源（DATA）

```markdown
### 精选作品区
- **作品卡片 × 6-8** 📦
  - **数据源**：`src/content/works/` 下所有 `featured: true` 的作品（按 `order` 字段排序）
  - **schema**：见 ARCHITECTURE.md §4 Content Collections
  - **样例骨架**：见下文 "样例数据" 段
```

skill 还可以**主动建议生成样例 MDX 文件骨架**（如 `content/works/example-brand-redesign.mdx`），让用户复制改填，避免空手起步。

## Step 3：全局内容资源

每个网站有一些**跨页面共享**的内容碎片，单独成段：

- **网站标题 / SEO meta title 模板**
- **默认 meta description**
- **OG image**（哪张图作为 social share 预览）
- **favicon**
- **联系方式**（邮箱 / 电话 / 社交账号）
- **法务页链接**（隐私政策 / 服务条款）
- **404 页文案**
- **加载状态文案 / 错误提示模板**

每条都标 📝 / 🤖 / 📦 之一。

## 拆分规则（CONTENT.md 体积控制）

**核心目标**：CONTENT.md 是 AI 反复读的"内容索引"，**整体控制在 ≤ 2000 字**。大项目会有几十个内容槽，如果每个都内联长文案，CONTENT.md 会膨胀到上万字、吃掉大量 context。

**自适应规则**（skill 在生成 CONTENT.md 时自动应用，**不**需要用户决策）：

| 内容槽长度 / 模式 | 处理方式 |
|---|---|
| 📝 ≤ 100 字 | 直接内联在 CONTENT.md 里 |
| 📝 > 100 字 | 单独存到 `content/snippets/{slug}.md`，CONTENT.md 只留 reference link |
| 🤖（任意长度） | 内联在 CONTENT.md 里（需求描述本身一般 ≤ 200 字） |
| 📦（任意） | 本来就是 reference，写 schema + 路径即可 |

**`content/` 目录约定**：

```
project/
├── BRIEF.md
├── PRD.md
├── DESIGN.md
├── ARCHITECTURE.md
├── CONTENT.md                ← 索引，≤ 2000 字
├── content/
│   ├── snippets/             ← 长文案 📝 拆出来的小文件
│   │   ├── home-hero-subtitle.md
│   │   ├── about-bio.md
│   │   ├── 404-message.md
│   │   └── privacy-policy.md
│   ├── pages/                ← 整页长内容（如完整法务页）
│   │   ├── privacy.md
│   │   └── terms.md
│   └── {datasource-name}/    ← 📦 数据源（如 works / posts），由 ARCHITECTURE 决定路径
│       └── *.mdx
├── AGENTS.md
└── CLAUDE.md
```

**命名约定**：
- snippet 文件名用 kebab-case，包含**所属页面 + 槽名**（如 `home-hero-subtitle.md` / `about-bio.md`），AI 一眼能知道这个 snippet 用在哪
- snippet 文件顶部用一行 `<!-- 用途说明 -->` HTML 注释，避免脱离 CONTENT.md 后语境丢失

**写到文件的时机**：
- skill 在 Step 4 写 CONTENT.md 的同时，**一起**写所有 `content/snippets/*.md` 文件
- 如果是 📦 数据源的样例骨架，也一起写到 `content/{datasource}/example.mdx`

**何时不拆**：
- 极小项目（PRD 页面 ≤ 3、总文案 < 500 字）→ skill 可以全部内联，不需要 `content/snippets/`。判断标准：CONTENT.md 内联后字数 < 1500 字
- 用户明确说"我项目小，不想要 content 子目录"→ 尊重

## Step 4：生成 CONTENT.md 并预览

按 `assets/content-template.md` 组织。**控制在 ≤ 2000 字**（长文案拆出去后基本能做到）。结构：

```markdown
# {项目名} · CONTENT · v1-launch

> 文件位置：`iterations/v1-launch/CONTENT.md`（仅首次产出）
> 配合 [iterations/v1-launch/PRD.md](./PRD.md) + [DESIGN.md](../../DESIGN.md) + [ARCHITECTURE.md](../../ARCHITECTURE.md) 阅读。

## 模式说明
- 📝 直接文案
- 🤖 AI 生成需求
- 📦 数据源

## 全局内容资源
...

## 页面 1：首页 `/`
### Hero 区
- **slogan** 📝 / 🤖 / 📦
  ...
### 精选作品区
...

## 页面 2：...
```

**字数**：自适应 PRD 的复杂度，通常 1500-5000 字。

**预览给用户**："这份 CONTENT 看着对吗？有没有哪条文案 / 需求你想改？📦 数据源的 schema 对齐 ARCHITECTURE 没问题吗？"

### 写文件

按拆分规则同时写到首版迭代目录：

1. **`./iterations/v1-launch/CONTENT.md`** —— 索引主文件（≤ 2000 字）
2. **`./iterations/v1-launch/content/snippets/*.md`** —— 所有拆出来的 > 100 字 📝 文案
3. **`./content/{datasource}/example.mdx`** —— 📦 数据源的样例骨架（**写到项目根的 content/**，因为数据源是长期资产，迭代后还会用到）

注意：snippet 拆出的小文件**也在 iterations/v1-launch/ 下**（因为这些是首版定稿的文案，不再迭代）。数据源（如 works/）**在项目根**（因为后续迭代继续用同一个 collection 加新数据）。

已存在则对比 + 确认。如果是极小项目可以省略 `content/snippets/`。

## Step 5：自动衔接 AGENTS（最后一步！）

> CONTENT.md 写完了。这是 First Flight 的倒数第二步。
>
> 最后一步是 AGENTS.md（+ CLAUDE.md）——把前面 5 份文档串起来，告诉 AI "拿到这个项目时，按什么顺序读，怎么开始写代码"。完成后你复制整个文件夹到自己的代码项目里，AI 就有了完整上下文，可以全自动开始搭网站。
>
> 我直接帮你启动 AGENTS。如果你想先停一下，告诉我一声。

立即切换到 `first-flight-agents` skill。

## 写作风格守则

- **三种模式必须明文标记**——每条内容槽前必须有 📝 / 🤖 / 📦 emoji，AI 才能精确识别该怎么处理
- **🤖 模式的需求必须可执行**——"想要温暖的感觉"不够，要给"长度 / 语气 / 关键词 / 反例"
- **📦 模式必须给路径**——"数据来自 works.json"不够，要给"`src/content/works/`（Astro Content Collections）"
- **不写 HTML / Markdown 语法装饰**——文案就是文案，不要带 `<h1>` 或 `**bold**`（视觉表现归 DESIGN，文案只管字）
- **品牌 voice 一致性**——所有 🤖 需求都要呼应 DESIGN 的 Do's & Don'ts + BRIEF 的语气

## 参考

- `assets/content-template.md`——CONTENT.md 模板
- `references/example-content.md`——Linka 作品集的完整 CONTENT 示例（含 3 种模式都用上）
