---
name: first-flight-architecture
description: First Flight 系列的第 4 步——通过结构化对话帮用户产出网站项目的 ARCHITECTURE.md，把"长什么样"落实成"用什么技术怎么搭"——框架选型、UI 库、样式方案、内容存储、第三方服务、部署、代码组织、性能 / a11y / 安全预算。**对小白用户提供整套推荐栈，让他们零决策也能往下走；对有经验用户保留选择权**。当用户已经有 DESIGN.md 准备进入技术决策、或者用户说"帮我选技术栈 / 框架 / 部署方式"、"create architecture spec for my site"、"我有 DESIGN 了下一步"时，请务必使用这个 skill。这是 First Flight 流程的第 4 步（BRIEF → PRD → DESIGN → **ARCHITECTURE** → CONTENT → AGENTS），输出会成为 AI 真正开始写代码的技术基础。
---

# First Flight · ARCHITECTURE

帮用户产出 `ARCHITECTURE.md`——把前面 3 份文档（BRIEF / PRD / DESIGN）落实成具体的技术决策：用什么 framework、哪个 UI 库、怎么部署、文件怎么组织。

**核心设计原则**：
- **路径 A（小白）**：skill 推荐一个完整的栈（基于 5 个预设栈），用户只需选 1 个。零决策。
- **路径 B（有经验）**：保留所有选择权，但 skill 仍然给推荐作为锚点。

## 与其他文档的分界

- **PRD.md** 定义了页面 / 信息架构 / 功能行为。ARCHITECTURE 决定"用什么技术实现这些功能"。
- **DESIGN.md** 的 **UI Framework Considerations** 是 ARCHITECTURE 的关键输入——里面有诉求 + 候选库，ARCHITECTURE 会在此基础上确定最终选择。
- **DESIGN.md 的 YAML tokens** 可以通过 `npx @google/design.md export` 直接导出成 Tailwind v4 theme 或 DTCG，ARCHITECTURE 应该指明这个 export 步骤。
- **ARCHITECTURE.md**（这个 skill 的输出）：framework / UI 库 / styling / 内容存储 / 第三方服务 / 部署 / 代码组织 / 性能 / a11y / 安全 / 风险
- **ARCHITECTURE 不写**：具体的页面代码、组件视觉细节（DESIGN）、内容文案（CONTENT）

## 整体流程

```
Step 0   读 BRIEF.md + PRD.md + DESIGN.md
   ↓
Step 1   识别经验度 → 路径 A / B
   ↓
Step 2   基于 PRD 的页面 + DESIGN 的气质 → skill 自动**推荐预设栈**
   ↓
Step 3   分批问问题（路径 A 主要是"确认 / 调整推荐"，路径 B 是"挑或自定义"）：
         1. Framework + Language + UI 库 + Styling
         2. 内容存储 + 数据策略
         3. 第三方服务（表单 / 邮件 / 分析 / 反垃圾 / 图像）
         4. 部署 + 域名 + 环境变量
         5. 性能 / a11y / 安全预算 + 代码组织
   ↓
Step 4   生成 ARCHITECTURE.md → 预览 → 写文件
   ↓
Step 5   自动衔接 CONTENT
```

## Step 0：读 BRIEF + PRD + DESIGN

三个文档都要读。关键信息：
- **BRIEF**：长期纲领 + 本质边界（"永远不做用户系统"这类约束会决定技术栈走简栈而不是复杂栈）
- **PRD**：页面清单 + 信息架构 + 是否有表单 / 后台 / 动态数据
- **DESIGN**：UI Framework Considerations（诉求 + 候选库）+ 动效尺度（影响是否需要 Framer Motion 等重库）

## Step 1：识别经验度

`AskUserQuestion` 4 选项分到路径 A（小白）或路径 B（有经验）。

## Step 2：推荐预设栈

基于 PRD + DESIGN 的信号，从 `references/stacks.md` 选 1-2 个最匹配的预设栈推荐给用户。

**信号 → 预设栈映射**：
- 页面少 + 静态内容 + 极简气质 → **静态作品集栈**（Astro）
- SaaS 产品官网 + 现代极简气质 + 需要邮件 / 表单 → **SaaS 落地页栈**（Next.js）
- 博客 / 文章站 + editorial / 杂志气质 → **内容站栈**（Astro + Content Collections）
- Dev 工具 / 文档站 + 极客气质 + 大量代码块 → **Dev 工具栈**（Next.js + Shiki）
- 用户提到 Vue / Nuxt 偏好 → **Vue/Nuxt 栈**

路径 A 用户：skill 直接说"基于你的项目，我推荐 X 栈，因为 ..."，让用户确认。
路径 B 用户：skill 给 1-2 个候选，让用户挑或自定义。

## Step 3：分批问问题

### 批 1：Framework + Language + UI 库 + Styling

要拿到：
1. **Framework**——具体选 Next.js / Astro / Nuxt / SvelteKit / 静态站
   - 默认推荐基于预设栈
   - 路径 A 接受默认，路径 B 可换
2. **Language**——TypeScript / JavaScript
   - **First Flight 默认 TypeScript**（更适合 AI 协作开发，类型可减少错误）
   - 路径 A 不问，直接 TypeScript；路径 B 可选 JS
3. **UI 库**——从 DESIGN 的候选里选 1 个
   - 默认选 DESIGN 候选里的第一个
   - 路径 A 用默认；路径 B 可调
4. **Styling**——Tailwind / CSS Modules / Vanilla Extract / Styled Components
   - **First Flight 默认 Tailwind**（能直接用 design.md 的 export 把 tokens 灌进去，无缝衔接）
   - 路径 A 用默认；路径 B 可换

**关键提示**：写完后强调"DESIGN.md 的 tokens 用 `npx @google/design.md export --format css-tailwind DESIGN.md > app/theme.css` 直接导出到 Tailwind v4 theme"——这是 First Flight 的独特工程价值。

#### 前端实施知识库（web-development）

如果项目属于静态站、落地页、展示型网站、演示页、单文件 HTML，或主要工作是前端页面实现，ARCHITECTURE 应把 `web-development` 标为实施阶段默认参考：

- 作为 DESIGN tokens 落地、HTML/CSS/JS 模式、响应式、a11y、SEO、性能、动效和排错参考
- 可复用 `web-development/templates/starter-template.html`、`assets/tokens.css`、`scripts/verify-html.py`
- 只管前端实现和验证；不替代 BRIEF / PRD / DESIGN / CONTENT，也不越界决定后端、数据库、认证或支付
- 框架项目中只引用它的 UI/CSS/a11y/performance 规则，依赖和目录仍以本 ARCHITECTURE 为准

### 批 2：内容存储 + 数据策略

要问到的事：

1. **内容存储**——基于 PRD 推断
   - 简单静态 → flat Markdown / MDX files in `content/` 目录
   - 多类内容（如博客 + 作品 + 页面）→ Astro Content Collections / Next.js fs-based MDX
   - 后期可能要让非开发者编辑 → 推荐轻量 CMS（Sanity / Decap CMS / Tina）
   - 用户系统 / 动态数据 → 数据库（Supabase / Neon / Turso）—— First Flight 默认不推荐这条，需要 BRIEF 允许

2. **数据获取策略**
   - **默认 SSG**（构建时生成静态 HTML）—— 适合 95% 的 First Flight 项目
   - 仅当有真正的动态数据时考虑 SSR / ISR / 客户端获取

3. **schema 示意**（如果有结构化内容）
   - 给一个 TypeScript interface 示例，如：
     ```ts
     interface Work {
       slug: string
       title: string
       client: string
       year: number
       type: 'brand' | 'illustration'
       coverImage: string
       gallery: string[]
       summary: string
       body: string  // MDX
     }
     ```

### 批 3：第三方服务

按 PRD 的需求挑选：

| 类别 | 默认推荐 | 备选 |
|---|---|---|
| **表单 / 邮件通知** | Resend（如有 Next.js Server Actions）/ Formspree（纯静态） | SendGrid / Web3Forms / Postmark |
| **分析** | Plausible（隐私友好）或 Umami | GA / Vercel Analytics / PostHog |
| **反垃圾** | Cloudflare Turnstile | hCaptcha / honeypot |
| **图像 CDN / 优化** | Vercel / Cloudflare Images / framework 内建 | imgix / Bunny CDN |
| **代码语法高亮**（dev 项目）| Shiki | Prism / Rehype-pretty-code |
| **评论**（博客项目）| Giscus（GitHub Discussions） | Disqus（不推荐，重 / 隐私差） |
| **搜索**（内容站）| 静态搜索（pagefind） | Algolia |
| **认证**（如需）| Clerk / Supabase Auth | Auth.js / Lucia |

路径 A：skill 按"项目类型 → 默认组合"给一套，用户确认或调整 1-2 项
路径 B：让用户挑，skill 给意见

### 批 4：部署 + 域名 + 环境变量

1. **部署平台**——基于 framework 自动推荐
   - Next.js → Vercel（默认）/ Cloudflare Pages / Netlify
   - Astro → Cloudflare Pages（默认）/ Vercel / Netlify
   - Nuxt → Vercel / Cloudflare / Netlify
   - 纯静态 → Cloudflare Pages（free + 全球 CDN）/ GitHub Pages

2. **域名 + DNS**——用户已有 / 待买
   - 路径 A：问"你有域名吗？没有的话推荐 Cloudflare Registrar / Namecheap"

3. **环境变量清单**——列出第三方服务需要的 keys：
   - RESEND_API_KEY
   - PLAUSIBLE_DOMAIN
   - 等

4. **CI/CD**——平台原生（Vercel / Cloudflare 自动）+ GitHub Actions（如需自定义）

### 批 5：性能 / a11y / 安全预算 + 代码组织

#### 性能预算
- LCP < 2.5s
- CLS < 0.1
- TTFB < 800ms
- JS bundle (initial) < 100KB
- 图像优化：用 framework 内建（Next/Image / Astro Image）

#### a11y 预算
- 接续 DESIGN.md 的 WCAG AA 目标
- Lighthouse a11y score ≥ 95
- 关键交互键盘可达

#### 安全
- CSP（Content-Security-Policy）头配置
- 表单防垃圾（Turnstile / honeypot）
- 环境变量不入 git（`.env.local` + `.gitignore`）

#### 代码组织
基于 framework 给标准目录结构。例：

```
project/
├── src/
│   ├── app/              # Next.js App Router（或 pages/ 路由）
│   ├── components/       # 共享组件
│   │   ├── ui/           # shadcn/ui 组件
│   │   └── ...           # 业务组件
│   ├── content/          # MDX 内容文件
│   ├── lib/              # 工具函数
│   └── theme.css         # 从 DESIGN.md export 的 Tailwind theme
├── public/               # 静态资源
├── BRIEF.md
├── PRD.md
├── DESIGN.md
├── ARCHITECTURE.md
├── CONTENT.md
├── AGENTS.md
└── CLAUDE.md
```

## Step 4：生成 ARCHITECTURE.md 并预览

按 `assets/architecture-template.md` 写。**字数 2000-4000 字**。

**先预览**给用户："这份 ARCHITECTURE 看着对吗？尤其框架 / 部署 / 表单方案有没有要调？"

写完文件后告诉用户：

> ARCHITECTURE.md 已经写好。
>
> 实际开始写代码前，先做这两件事：
> 1. 跑 `npx @google/design.md export --format css-tailwind DESIGN.md > app/theme.css` 把 DESIGN tokens 导成 Tailwind v4 theme
> 2. 如果是前端页面实现，先确认 `web-development` 可用；静态 / 单文件页面优先从 `templates/starter-template.html` 或 `assets/tokens.css` 起步，交付前跑 `scripts/verify-html.py`（或对应框架的浏览器验证）
> 3. 准备好这些环境变量的账号：{列出 keys}

## Step 5：自动衔接 CONTENT

> ARCHITECTURE.md 写完了。下一步是 CONTENT.md——根据 PRD 里的信息架构（每个区块的"内容槽"），把这些槽填上：直接文案 / AI 生成需求 / 数据源（JSON / MDX）。CONTENT.md 完成后，AI 就有了写代码所需的所有上下文。
>
> 我直接帮你启动 CONTENT。如果你想先停一下，告诉我一声。

立即切换到 `first-flight-content` skill。

> First Flight 完整流程还剩：CONTENT.md（内容填充）→ AGENTS.md（AI 入口文档）。

## 写作风格守则

- 每个技术决策都要有**一句话理由**（不是"用 X 因为我喜欢"，是"用 X 因为它和 DESIGN 的 Y 特性匹配 / 满足 PRD 的 Z 需求"）
- 给版本号或至少明确"主版本"（Next.js 15 / Astro 5 / Tailwind 4）—— 避免 AI 写代码时用过时 API
- 第三方服务给**具体 SDK / 库名**（"用 Resend 的 `resend` npm 包"），不是模糊"用某个邮件服务"
- 涉及前端页面实现时，明确是否启用 `web-development` 作为实施知识库；启用时写清使用边界和验证命令
- 不写代码——只描述决策和组织
- 不写文案（CONTENT 的事）
- 不写视觉（DESIGN 的事）
- 性能 / a11y 预算必须**可验证**——给具体数字 + 测量工具

## 参考

- `references/stacks.md`——5 个预设技术栈（静态作品集 / SaaS 落地页 / 内容站 / Dev 工具 / Vue Nuxt）
- `references/example-architecture.md`——Linka 作品集的完整 ARCHITECTURE 示例
- `assets/architecture-template.md`——ARCHITECTURE.md 模板
