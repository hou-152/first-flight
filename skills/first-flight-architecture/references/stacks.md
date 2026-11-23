# 预设技术栈库

5 个开箱即用的技术栈，覆盖 First Flight 95% 场景。每个栈基于真实项目的合理默认，路径 A 用户选 1 个就能走完。

每个栈含：framework / UI / styling / 语言 / 内容存储 / 第三方服务默认组合 / 部署 / 代码组织 / 性能预算。

skill 根据 PRD + DESIGN 的信号自动推荐 1-2 个栈给用户。

---

## 栈 1：静态作品集 / 简单站点（Astro 栈）

> 默认推荐给：个人作品集、博客、文档站、简单官网

### 信号匹配
- PRD：页面 ≤ 6 个，几乎纯静态内容
- DESIGN：editorial / 极简 / 复古 / 东京 / 温和有机
- BRIEF：明确"永远不做用户系统 / 动态后台"

### 技术决策
- **Framework**：Astro 5（SSG 为主，支持 islands 局部交互）
- **Language**：TypeScript
- **UI 库**：shadcn-style（Astro 适配版本）或 Radix Primitives + 自定义
- **Styling**：Tailwind v4
- **内容存储**：Content Collections（typed MDX）
- **图像**：Astro Image（内建优化）

### 第三方服务默认
| 类别 | 选择 | 理由 |
|---|---|---|
| 表单 / 邮件 | Formspree 或 Web3Forms | 纯静态，无需后端 |
| 分析 | Plausible Cloud / 自建 Umami | 隐私友好、轻 |
| 反垃圾 | Cloudflare Turnstile | 比 hCaptcha 轻 |
| 评论（如有博客） | Giscus（GitHub Discussions） | 免费 + 不要数据库 |
| 搜索（如有内容） | Pagefind（静态搜索） | 构建时生成索引 |

### 部署
- **平台**：Cloudflare Pages（默认）/ Vercel / Netlify
- **DNS**：Cloudflare（默认，免费）
- **CI/CD**：平台原生（推 main 自动部署）

### 代码组织
```
project/
├── src/
│   ├── content/          # Astro Content Collections
│   │   ├── works/        # 作品 MDX
│   │   └── posts/        # 文章 MDX（如有博客）
│   ├── pages/            # Astro 路由
│   ├── components/
│   │   ├── ui/           # 基础组件
│   │   └── ...
│   ├── layouts/          # 布局组件
│   └── styles/
│       └── theme.css     # 从 DESIGN.md export 的 Tailwind v4 theme
├── public/               # 静态资源（图片、字体）
├── astro.config.mjs
├── tailwind.config.js
└── package.json
```

### 性能预算
- LCP < 1.5s（静态站可以做到）
- CLS < 0.05
- JS initial bundle < 30KB（Astro islands 默认 0 JS）
- Lighthouse Performance ≥ 95

---

## 栈 2：SaaS 落地页（Next.js 栈）

> 默认推荐给：SaaS 产品官网、产品落地页、需要表单交互

### 信号匹配
- PRD：5-10 个页面，含定价 / 注册 CTA / demo 申请表单
- DESIGN：现代极简 / 友好可爱
- BRIEF：B 端或 C 端 SaaS 官网

### 技术决策
- **Framework**：Next.js 15（App Router，SSG + 选择性 ISR）
- **Language**：TypeScript
- **UI 库**：shadcn/ui
- **Styling**：Tailwind v4
- **内容存储**：硬编码 + Markdown for 长内容段（features / pricing FAQ）
- **图像**：next/image（内建优化）

### 第三方服务默认
| 类别 | 选择 | 理由 |
|---|---|---|
| 表单 / 邮件 | Resend + Next.js Server Actions | SDK 简洁，Server Actions 原生支持 |
| 分析 | Plausible + Vercel Analytics | Plausible 看 KPI，Vercel 看 perf |
| 反垃圾 | Cloudflare Turnstile | 集成简单 |
| 图像 CDN | next/image + Vercel | 默认配置即可 |

### 部署
- **平台**：Vercel（默认，最佳 Next.js 体验）
- **DNS**：Cloudflare（推荐）或 Vercel Domains
- **CI/CD**：Vercel 原生 + GitHub 集成

### 代码组织
```
project/
├── app/                  # Next.js App Router
│   ├── (marketing)/      # 营销页 group
│   │   ├── page.tsx      # 首页
│   │   ├── pricing/
│   │   └── about/
│   ├── api/              # API routes（如有）
│   ├── layout.tsx
│   └── theme.css         # DESIGN.md export 的 Tailwind theme
├── components/
│   ├── ui/               # shadcn 组件（npx shadcn add）
│   └── ...               # 业务组件
├── lib/                  # 工具函数
├── content/              # MDX 长内容
└── public/
```

### 性能预算
- LCP < 2.0s
- CLS < 0.1
- JS initial < 80KB
- Lighthouse Performance ≥ 90

---

## 栈 3：内容站 / 博客（Astro Content 栈）

> 默认推荐给：技术博客、editorial 站点、文章为主的网站

### 信号匹配
- PRD：核心是 `/posts` 列表 + `/posts/[slug]` 详情
- DESIGN：杂志阅读 / editorial / 极客
- BRIEF：长期沉淀内容、追求阅读体验

### 技术决策
- **Framework**：Astro 5
- **Language**：TypeScript
- **UI**：极简，主要排版 + 少量交互组件
- **Styling**：Tailwind v4 + @tailwindcss/typography 插件
- **内容**：Content Collections（typed MDX）
- **代码高亮**：Shiki（Astro 内建）+ Expressive Code

### 第三方服务默认
| 类别 | 选择 | 理由 |
|---|---|---|
| 评论 | Giscus | 免费 + GitHub 集成 |
| 分析 | Plausible / Umami | 隐私 + 简洁 |
| 搜索 | Pagefind | 静态构建时索引 |
| RSS | Astro 内建 | `@astrojs/rss` |
| Newsletter（可选） | Buttondown / Resend Broadcasts | 简单订阅 + 群发 |

### 部署
- **平台**：Cloudflare Pages（默认）
- **DNS**：Cloudflare

### 代码组织
```
project/
├── src/
│   ├── content/
│   │   ├── config.ts     # Content Collections schema
│   │   └── posts/        # MDX 文章
│   ├── pages/
│   │   ├── index.astro   # 首页
│   │   ├── posts/
│   │   │   ├── index.astro
│   │   │   └── [slug].astro
│   │   └── rss.xml.js
│   ├── components/
│   ├── layouts/
│   └── styles/
│       └── theme.css
└── public/
```

### 性能预算
- LCP < 1.5s
- CLS < 0.05
- JS initial < 20KB
- Lighthouse 全 95+

---

## 栈 4：Dev 工具 / 文档站（Next.js + Shiki 栈）

> 默认推荐给：开发者工具产品、SDK 文档、API 文档站

### 信号匹配
- PRD：含大量代码块 / API 示例 / 安装指引
- DESIGN：极客
- BRIEF：面向开发者用户

### 技术决策
- **Framework**：Next.js 15（App Router）或 Nextra / Mintlify（如纯文档）
- **Language**：TypeScript
- **UI 库**：shadcn/ui (dark mode 优先)
- **Styling**：Tailwind v4
- **内容**：MDX + Next.js fs-based
- **代码块**：Shiki + Code Hike（带交互的代码展示）

### 第三方服务默认
| 类别 | 选择 | 理由 |
|---|---|---|
| 分析 | PostHog | event tracking + heatmap，适合 dev 工具 |
| 反垃圾 | Cloudflare Turnstile | |
| 搜索 | Algolia DocSearch（开源项目免费） | dev 文档标配 |
| GitHub 集成 | next-github（star count / issue 数据） | dev 工具站常见 |

### 部署
- **平台**：Vercel
- **DNS**：Cloudflare

### 性能预算
- LCP < 2.0s
- 代码块渲染不阻塞首屏

---

## 栈 5：Vue / Nuxt 栈

> 默认推荐给：用户偏好 Vue 生态的项目

### 信号匹配
- 用户明确提到 Vue / Nuxt / Vite 偏好
- 用户已有 Vue 项目经验
- BRIEF / PRD 不限定特定框架

### 技术决策
- **Framework**：Nuxt 3（SSG / SSR / hybrid）
- **Language**：TypeScript
- **UI 库**：Nuxt UI（默认）或 PrimeVue / 自定义 + Tailwind
- **Styling**：Tailwind v4
- **内容存储**：@nuxt/content（MDC = Markdown Components）

### 第三方服务默认
| 类别 | 选择 | 理由 |
|---|---|---|
| 表单 / 邮件 | Resend + Nitro server route | Nuxt 内建 server 端 |
| 分析 | Plausible | |
| 反垃圾 | Cloudflare Turnstile | |
| 图像 | @nuxt/image | 内建优化 |

### 部署
- **平台**：Vercel / Cloudflare Pages / Netlify（Nuxt 都支持）
- **DNS**：Cloudflare

### 代码组织（Nuxt 约定）
```
project/
├── app/                  # 或顶层
│   ├── pages/            # 文件即路由
│   ├── components/
│   ├── layouts/
│   ├── composables/      # Vue composables
│   └── assets/css/
├── content/              # @nuxt/content
├── public/
├── server/               # Nitro server routes
└── nuxt.config.ts
```

---

## 默认决策总结表（路径 A 用户的"零决策栈"）

| 项目类型 | 推荐栈 |
|---|---|
| 个人作品集 | 栈 1（Astro） |
| 个人博客 | 栈 3（Astro + Content） |
| 公司官网（小） | 栈 1（Astro） |
| SaaS 产品官网 | 栈 2（Next.js） |
| Dev 工具网站 | 栈 4（Next.js + Shiki） |
| 落地页 | 栈 2（Next.js） |
| 文档站 | 栈 4（或 Nextra） |
| Vue 偏好 | 栈 5（Nuxt） |

skill 在 Step 2 应该自动从 PRD + DESIGN 推断项目类型，给出**一个**主推荐 + **一个**备选，路径 A 用户基本只需要点头同意。
