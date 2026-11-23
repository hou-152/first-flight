# ARCHITECTURE.md 完整示例（接续 Linka 个人作品集）

适用场景：已有 BRIEF + PRD + DESIGN，进入技术决策。

DESIGN 已经指出 UI 框架候选是 shadcn/ui 或 Radix Primitives + 自定义，整体气质 editorial + soft organic，flat elevation，sharp shapes，动效尺度"微"。

---

# Linka · ARCHITECTURE

> 文件位置：项目根 `ARCHITECTURE.md`（长期文档）
> 配合 BRIEF.md + DESIGN.md（同根目录）+ `iterations/v1-launch/PRD.md` 阅读。本文件定义技术决策。

## 1. 技术栈一句话

**Linka 用 Astro 5 + shadcn-style + Tailwind v4 + Cloudflare Pages 搭建，作为完全静态生成（SSG）的作品集站点。**

## 2. 决策原因

- BRIEF 明确"永远不会做的：第三方设计师入驻 / 设计素材售卖 / 课程社区 / 用户互动评论"——意味着永远不需要数据库 / 用户系统 / 动态内容，全静态即可
- PRD 共 5 个页面（首页 / 作品列表 / 作品详情 / 关于 / 联系），其中只有联系页有表单交互，其他纯展示——Astro 的 SSG + islands 是最匹配的
- DESIGN 的 UI Framework Considerations 候选是 shadcn/ui 或 Radix Primitives + 自定义，倾向"极轻量、可自由 restyle"——Astro 生态有 shadcn 适配，且 Astro 默认就是"0 JS by default"
- DESIGN 动效尺度"微"（仅 hover 微变 + 极轻 fade），不需要 Framer Motion / GSAP，原生 CSS transition 足够

## 3. 核心技术栈

### Framework
- **名称**：Astro 5
- **渲染模式**：SSG（构建时生成静态 HTML）
- **路由**：file-based（`src/pages/`）
- **Islands**：仅在联系表单和作品 hover 交互处使用（其他全静态 HTML）

### Language
- **TypeScript** strict mode
- **Node version**：Node 22 LTS
- **Package manager**：pnpm

### UI 库
- **Radix Primitives + 自定义样式**（不直接装 shadcn/ui，因为 Astro 的 shadcn 适配不如 Next.js 完整；用 Radix Primitives + 自己 Tailwind class 写组件，更贴合 editorial 气质的低组件覆盖度需求）
- 仅引入需要的 primitives：`@radix-ui/react-dialog`（联系表单 modal）、`@radix-ui/react-tabs`（作品筛选）

### Styling
- **Tailwind v4**（启用 CSS-first config）
- **Theme 来源**：从 DESIGN.md export
  ```bash
  npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css
  ```
- `src/styles/global.css`：
  ```css
  @import "tailwindcss";
  @import "./theme.css";
  ```
- 配合 `@tailwindcss/typography` 插件用在作品详情的设计思路长文上

## 4. 内容与数据

### 内容存储
**Astro Content Collections**（typed MDX）—— 作品和关于页都用 Content Collections。

### 数据获取策略
**100% SSG**——所有页面在 `astro build` 时预渲染成静态 HTML。

### Schema

```ts
// src/content/config.ts
import { defineCollection, z } from 'astro:content'

const works = defineCollection({
  type: 'content',  // MDX body
  schema: z.object({
    title: z.string(),
    slug: z.string(),
    client: z.string(),
    year: z.number(),
    type: z.enum(['brand', 'illustration']),
    coverImage: z.string(),
    gallery: z.array(z.string()),
    summary: z.string(),
    featured: z.boolean().default(false),
    order: z.number().default(0),
  })
})

export const collections = { works }
```

## 5. 第三方服务

| 类别 | 选择 | 用途 | 环境变量 |
|---|---|---|---|
| 表单 / 邮件 | Formspree | 联系表单提交后转发邮件给 Linka | `PUBLIC_FORMSPREE_ID` |
| 分析 | Plausible Cloud | 访客统计 / 漏斗指标 | `PUBLIC_PLAUSIBLE_DOMAIN` |
| 反垃圾 | Cloudflare Turnstile | 联系表单防机器人 | `PUBLIC_TURNSTILE_SITE_KEY` |
| 图像 | Astro Image（内建） | WebP / AVIF 自动转码 | - |
| 字体 | Tiempos Headline + Söhne 自托管 | 性能（不靠 Google Fonts CDN） | - |

**字体说明**：Tiempos / Söhne 是商业字体，需要 Linka 购买授权后自托管在 `public/fonts/`。如未购买，临时用 Crimson Pro（serif 替代）+ Inter（sans 替代）。

## 6. 部署

- **平台**：Cloudflare Pages
- **域名**：`linka.design`（已注册，需要解析）
- **DNS**：Cloudflare（域名也托管在 Cloudflare）
- **CI/CD**：Cloudflare Pages 原生 + GitHub 集成（push main → 自动部署生产；PR → preview deploy）
- **环境**：production + preview（每个 PR 自动）
- **HTTPS**：Cloudflare 自动签发

## 7. 代码组织

```
linka/
├── src/
│   ├── content/
│   │   ├── config.ts         # Content Collections schema
│   │   └── works/
│   │       ├── brand-xxx.mdx
│   │       └── illustration-yyy.mdx
│   ├── pages/
│   │   ├── index.astro       # /
│   │   ├── works/
│   │   │   ├── index.astro   # /works
│   │   │   └── [slug].astro  # /works/[slug]
│   │   ├── about.astro       # /about
│   │   └── contact.astro     # /contact
│   ├── components/
│   │   ├── ui/
│   │   │   ├── Button.astro
│   │   │   ├── Badge.astro
│   │   │   └── Input.astro
│   │   ├── WorkCard.astro
│   │   ├── WorkGrid.astro
│   │   ├── ContactForm.tsx   # React island（Turnstile + 提交逻辑）
│   │   └── Nav.astro
│   ├── layouts/
│   │   ├── BaseLayout.astro
│   │   └── WorkLayout.astro
│   └── styles/
│       ├── global.css
│       └── theme.css         # 从 DESIGN.md export
├── public/
│   ├── fonts/                # Tiempos / Söhne 自托管
│   └── images/               # 作品图（也可放 src/content）
├── astro.config.mjs
├── tailwind.config.js        # Tailwind v4 minimal config
├── tsconfig.json
├── package.json
├── BRIEF.md
├── PRD.md
├── DESIGN.md
├── ARCHITECTURE.md
├── CONTENT.md
├── AGENTS.md
└── CLAUDE.md
```

**命名约定**：
- 组件：PascalCase（`WorkCard.astro`、`ContactForm.tsx`）
- 工具函数：camelCase（`formatYear.ts`）
- 内容文件：kebab-case（`brand-stripe-redesign.mdx`）
- 路由：kebab-case（`/works/brand-stripe-redesign`）

## 8. 性能预算

| 指标 | 目标 | 测量工具 |
|---|---|---|
| LCP | < 1.5s | Lighthouse / Real User Monitoring |
| CLS | < 0.05 | 同上 |
| TTFB | < 200ms（Cloudflare 全球 CDN） | Lighthouse |
| JS initial bundle | < 30KB（仅 islands 部分加载） | 构建产物分析 |
| Lighthouse Performance | ≥ 95 | CI 中跑 Lighthouse |
| Lighthouse Accessibility | ≥ 100（呼应 DESIGN 的 WCAG AA） | 同上 |

**图像优化策略**：
- 作品图全部用 Astro Image（`<Image>`组件），自动生成 WebP / AVIF
- 作品封面 lazy load，hero 大图 eager + preload
- 作品图原图压缩到 ≤ 2400px 宽，质量 80

## 9. 安全与隐私

- **CSP**：基础规则，允许 `'self'` + `https://challenges.cloudflare.com`（Turnstile）+ `https://plausible.io`
- **HTTPS-only**：Cloudflare 自动
- **环境变量**：`.env.local` 加入 `.gitignore`
- **表单防垃圾**：Cloudflare Turnstile（无感）
- **Cookie**：无 cookie（Plausible 不用 cookie）
- **PII 保护**：联系表单提交后通过 Formspree 转发邮件，**不入数据库**（Formspree 会临时存 30 天供导出，符合最小化原则）
- **隐私政策**：`/privacy`（CONTENT.md 会写）

## 10. 可观测性

- **错误监控**：无（小静态站，不必装 Sentry）。如果未来用户量起来，可加 Sentry SDK。
- **日志**：Cloudflare Pages 自带 build / deploy 日志
- **Uptime**：Cloudflare 自带 monitoring，足够

## 11. 风险与替代方案

- **字体授权未购买**：临时用免费替代字体（Crimson Pro / Inter），上线后切换
- **Formspree 免费版限额**：每月 50 次提交。如果 90 天内超出（按主指标 ≥ 5 份咨询的预期不会），升级或迁移到 Web3Forms
- **Cloudflare Pages 构建超时**：当前项目规模不会触发（builds 通常 < 30s）。如未来作品图过多导致超时，分离图片到 R2 + Image Resizing
- **Vendor lock-in 评估**：Astro / Tailwind / Radix 都是开源标准，迁移到 Vercel / Netlify 一键完成；Formspree 可迁到 Web3Forms / 自建 SMTP；Plausible 数据可导出

## 12. 开始写代码前的 checklist

- [ ] 跑 `npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css`
- [ ] 注册 Formspree、Cloudflare Pages、Plausible 账号；拿到 keys 放 `.env.local`
- [ ] Cloudflare Turnstile 申请 site key
- [ ] 创建 GitHub 仓库 `linka-portfolio`
- [ ] 连接 Cloudflare Pages ↔ GitHub
- [ ] 域名 `linka.design` 添加到 Cloudflare（如未托管）
- [ ] 装 Node 22 + pnpm
- [ ] `pnpm create astro@latest linka -- --template minimal --typescript strict --install`
- [ ] 装依赖：`pnpm add @astrojs/tailwind tailwindcss@next @astrojs/mdx @astrojs/react @radix-ui/react-dialog @radix-ui/react-tabs`
- [ ] （可选）购买 Tiempos Headline + Söhne 字体授权
