# {项目名} · ARCHITECTURE

> 文件位置：项目根 `ARCHITECTURE.md`（长期文档，跨迭代共用）
> 配合 BRIEF.md + DESIGN.md（同根目录）+ `iterations/v{N}-{slug}/PRD.md`（当前迭代）阅读。本文件定义技术决策；不写视觉细节（见 DESIGN.md）和具体文案（见 `iterations/v1-launch/CONTENT.md`，仅首版有）。

## 1. 技术栈一句话

**{项目名} 用 {Framework} + {UI 库} + {Styling} + {部署平台} 搭建，作为 {SSG / SSR / Hybrid} 站点。**

## 2. 决策原因

{为什么选这个组合——映射到 BRIEF / PRD / DESIGN 的具体诉求}

- BRIEF 要求 {长期定位} → 选 {decision}
- PRD 的页面规模 {规模} 和 {特定需求} → 选 {decision}
- DESIGN 的 UI Framework Considerations 候选 {库列表} → 收窄到 {选定库}
- DESIGN 的动效尺度 {级别} → {是否需要 animation lib}

## 3. 核心技术栈

### Framework
- **名称**：{Next.js / Astro / Nuxt / ...}
- **版本**：{主版本，如 Next.js 15 / Astro 5}
- **渲染模式**：{SSG / SSR / ISR / Hybrid}
- **路由**：{App Router / Pages Router / file-based}

### Language
- **TypeScript**（First Flight 默认 TS，因为更适合 AI 协作开发）
- **Node version**：{LTS 版本，如 Node 22 LTS}
- **Package manager**：{pnpm / npm / bun}

### UI 库
- **{库名}**——{为什么选这个（呼应 DESIGN 的诉求）}
- **安装方式**：{如 `npx shadcn@latest init` / `npm install xxx`}

### Styling
- **Tailwind v4**（默认）
- **Theme 来源**：从 DESIGN.md export 的 `theme.css`
  ```bash
  npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css
  ```
- 在 `src/styles/global.css` 里 `@import "./theme.css"` 来激活 design tokens

### 前端实施知识库
- **默认参考**：`web-development`（仅用于前端实现与验证）
- **适用范围**：HTML/CSS/JS、静态站、落地页、展示型页面、响应式、a11y、SEO、Core Web Vitals、动效、排错
- **可复用资产**：
  - `web-development/templates/starter-template.html`：静态 / 单文件页面起手模板
  - `web-development/assets/tokens.css`：独立设计令牌
  - `web-development/scripts/verify-html.py`：HTML/CSS 质量验证
- **边界**：不替代 BRIEF / PRD / DESIGN / CONTENT；不决定后端、数据库、认证、支付；框架项目只使用其 UI/CSS/a11y/performance 规则，依赖仍以本文件为准

## 4. 内容与数据

### 内容存储
{Markdown / MDX flat files / Content Collections / CMS / 数据库}

### 数据获取策略
{SSG 默认 / ISR 触发条件 / SSR 场景 / 客户端 fetch}

### Schema（如有结构化内容）

```ts
interface {EntityName} {
  // ... 字段定义
}
```

## 5. 第三方服务

| 类别 | 选择 | 用途 | 环境变量 |
|---|---|---|---|
| 表单 / 邮件 | {Service} | {用途} | `{ENV_VAR}` |
| 分析 | {Service} | {用途} | `{ENV_VAR}` |
| 反垃圾 | {Service} | {用途} | `{ENV_VAR}` |
| 图像 CDN | {Service} | {用途} | - |
| ... | ... | ... | ... |

## 6. 部署

- **平台**：{Vercel / Cloudflare Pages / Netlify}
- **域名**：{域名状态：已注册 / 待注册（候选）}
- **DNS**：{Cloudflare / Vercel / Namecheap}
- **CI/CD**：{平台原生 + GitHub 集成}
- **环境变量**：见上表 + 部署面板配置
- **环境**：production / preview（PR 自动 preview deploy）

## 7. 代码组织

```
project/
├── (具体目录结构)
├── BRIEF.md
├── PRD.md
├── DESIGN.md
├── ARCHITECTURE.md
├── CONTENT.md
├── AGENTS.md
└── CLAUDE.md
```

**命名约定**：
- 组件：PascalCase（`WorkCard.tsx`）
- 工具函数：camelCase（`formatDate.ts`）
- MDX 内容文件：kebab-case（`my-first-post.mdx`）
- 路由 segment：kebab-case（`/case-studies/`）

## 8. 性能预算

| 指标 | 目标 |
|---|---|
| LCP（Largest Contentful Paint） | < {数字}s |
| CLS（Cumulative Layout Shift） | < {数字} |
| TTFB（Time to First Byte） | < {数字}ms |
| JS initial bundle | < {数字}KB |
| Lighthouse Performance | ≥ {分数} |
| Lighthouse Accessibility | ≥ {分数}（呼应 DESIGN 的 WCAG AA） |

**图像优化策略**：{如 next/image / Astro Image + WebP / AVIF}

## 9. 安全与隐私

- **CSP（Content-Security-Policy）**：{基础规则}
- **HTTPS-only**：强制（部署平台默认）
- **环境变量**：`.env.local` 不入 git
- **表单防垃圾**：{Turnstile / hCaptcha / honeypot}
- **Cookie 合规**：{如有 cookies，列出 + 隐私政策链接}
- **PII 保护**：表单收集的个人信息只发邮件，不入库

## 10. 可观测性

- **错误监控**：{Sentry / 平台内建 / 无（小项目可省）}
- **日志**：{平台日志 / 自建}
- **Uptime 监控**：{UptimeRobot / BetterStack（可选）}

## 11. 风险与替代方案

- **{风险 1}**：{描述 + 替代方案}
- **{风险 2}**：{...}
- **{vendor lock-in}**：{评估是否容易迁移到其他平台}

## 12. 开始写代码前的 checklist

- [ ] 跑 `npx @google/design.md export --format css-tailwind DESIGN.md > src/styles/theme.css`
- [ ] 注册所有第三方服务账号，把 API key 放到 `.env.local`
- [ ] 创建 GitHub 仓库
- [ ] 连接部署平台 ↔ GitHub（开 preview deploy）
- [ ] 注册 / 解析域名（如未完成）
- [ ] 装好 Node + pnpm
- [ ] 跑 framework 的 `create` 命令初始化项目
- [ ] 前端页面实现前已确认是否启用 `web-development`；静态 / 单文件页面已选择 `starter-template.html` 或 `tokens.css` 起步
- [ ] 页面交付前已规划验证方式：`python3 ~/.codex/skills/web-development/scripts/verify-html.py <file.html>`（静态 HTML）或真实浏览器 + console + 响应式断点验证（框架项目）
