# CONTENT.md 完整示例（接续 Linka 个人作品集）

涵盖 3 种模式（📝 COPY / 🤖 PROMPT / 📦 DATA）的混合使用。

---

# Linka · CONTENT · v1-launch

> 文件位置：`iterations/v1-launch/CONTENT.md`
> 配合 [PRD.md](./PRD.md)（同目录，信息架构）+ [DESIGN.md](../../DESIGN.md)（Do's & Don'ts + voice）+ [ARCHITECTURE.md](../../ARCHITECTURE.md)（数据存储）阅读。
>
> 本文件给 PRD 的每个**内容槽**填上具体内容，AI 写代码时按这里的标记处理：📝 直接用文案 / 🤖 按需求生成 / 📦 从数据源读。

## 模式说明

- **📝 COPY**：直接文案，AI 原样使用。**≤ 100 字内联在本文件；> 100 字拆到 `content/snippets/{slug}.md`，这里只留 reference**
- **🤖 PROMPT**：生成需求，AI 写代码时按需求生成（内联在本文件）
- **📦 DATA**：数据源路径，AI 从指定文件读

**目录结构**：

```
content/
├── snippets/
│   ├── home-bio.md          ← 长 📝 文案
│   └── privacy-policy.md
└── works/                   ← 📦 数据源
    └── *.mdx
```

CONTENT.md（本文件）是索引，控制在 ≤ 2000 字。Linka 项目实际拆分情况见下方各 section。

---

## 全局内容资源

### 网站元信息
- **网站标题** 📝
  > Linka
- **SEO meta title 模板** 📝
  > `{页面标题} · Linka`
- **默认 meta description** 🤖
  - **需求**：1 句 60-80 字符（英文）/ 30-40 汉字，包含"独立设计师 / 品牌设计 / 插画"关键词，温暖中性语气
- **OG image** 📦
  > 路径：`public/og-image.jpg`（hero 主视觉作品图，1200×630）
- **Favicon** 📦
  > 路径：`public/favicon.svg`（Linka 的字符 logo，单色暖墨）

### 联系方式
- **主邮箱** 📝
  > hi@linka.design
- **社交账号** 📝
  > Instagram: @linka.design
  > Are.na: @linka

### 法务页
- **隐私政策** 🤖
  - **需求**：基于"仅通过 Formspree 收集联系表单邮件 + Plausible 无 cookie 分析"的事实，生成 GDPR-friendly 隐私政策。结构：收集什么 / 如何使用 / 数据保留期 / 用户权利 / 联系方式。语气克制 editorial，避开法律术语堆砌。约 400-600 字。

### 状态文案
- **404 标题** 📝
  > 这页不在我的画册里
- **404 副文案** 📝
  > 也许你想去 [作品列表](/works) 或 [回首页](/)
- **表单提交成功** 📝
  > 收到了，我会在 48 小时内回复你
- **表单提交失败** 📝
  > 提交没成功，邮件也可以直接发到 hi@linka.design

---

## 页面 1：首页 `/`

### Hero 区
- **slogan**（1 句，15-25 字）— 🤖
  - **生成需求**：温暖而非张扬，强调"插画 + 品牌设计"双线，避开"赋能 / 革新 / 让 X 变得更 Y"这种空话，避开全大写
  - **关键词**：插画、品牌、双线、为人做事
  - **示例方向**：像 The Verge 的标题那样有重量但不刻意；像 Aesop 产品页那样克制
  - **反例**：❌ "AI 赋能你的品牌"、"打造极致设计体验"

- **副文案**（1-2 句，30-60 字）— 🤖
  - **生成需求**：自我介绍 + 服务说明 + 一个量化锚点（如"三年""20+ 品牌"）
  - **必含信息**：独立设计师身份、品牌设计 + 商业插画服务、合作过 20+ 中小品牌

- **主视觉图** — 📦
  > 路径：`src/content/works/` 里 `featured: true` 且 `heroEligible: true` 的作品的 `coverImage`，取最新一张

- **主 CTA 按钮文字** — 📝
  > 看全部作品

### 精选作品区
- **作品卡片 × 6-8** — 📦
  - **数据源**：`src/content/works/` 下所有 `featured: true` 的作品
  - **排序**：按 `order` 字段升序
  - **每张卡片显示字段**：`coverImage`（封面）/ `title`（标题）/ `type`（类型标签）
  - **schema**：见 ARCHITECTURE.md §4
  - **样例骨架**：见下方"样例数据"

- **"查看全部"链接文字** — 📝
  > 全部 →

### 简介区
- **Linka 一段话介绍**（80-120 字）— 🤖
  - **生成需求**：第一人称，讲清楚"我是谁 / 在哪里 / 在做什么"，自然带出"插画 + 品牌设计"，结尾留一个开放邀请（如"想聊聊合作请发邮件给我"）
  - **语气参考**：DESIGN.md voice + BRIEF 目标用户（品牌创始人 / design lead）能读懂的水平，不要术语
  - **避免**：自夸（"业内顶尖"）/ 全英文 / 表情符号

- **合作品牌 logo 列表 × 3-5** — 📦
  - **数据源**：`src/content/brands.json`
  - **schema**：`{ name: string, logo: string }`

### CTA 区（底部引导联系）
- **一句话引导文案** — 🤖
  - **生成需求**：1 句温暖邀请，10-20 字，避免命令式（"现在就联系"）

- **按钮文字** — 📝
  > 开始合作

---

## 页面 2：作品列表 `/works`

### 筛选区
- **筛选标签** — 📝
  > 全部 / 品牌设计 / 插画

### 作品网格区
- **所有作品卡片** — 📦
  - **数据源**：`src/content/works/` 全部
  - **排序**：默认按 `year` 降序，可由 URL query `?sort=` 切换
  - **每张卡片字段**：`coverImage` / `title` / `type` / `year`

- **空状态文案**（万一筛选无结果）— 📝
  > 这个类别下还没有作品

---

## 页面 3：作品详情 `/works/[slug]`

### 作品头部
- **标题** — 📦（来自作品 frontmatter `title`）
- **客户名** — 📦（`client`）
- **完成时间** — 📦（`year`）
- **类型标签** — 📦（`type`）

### 图集区
- **作品图组** — 📦
  - **数据源**：作品的 `gallery` 数组（图片路径列表）
  - **顺序**：保持数组原序

### 设计思路区
- **设计说明全文** — 📦
  - **数据源**：作品 MDX 文件的 body 部分
  - **结构约束**：建议 4 段——背景 / 挑战 / 思路 / 结果（在 schema 里不强制，但每篇 MDX 鼓励按这个结构写）

### 上下件导航
- **"上一件"标签** — 📝
  > ← 上一件
- **"下一件"标签** — 📝
  > 下一件 →
- **作品数据** — 📦
  - **数据源**：当前作品在 `works` 集合的前后两条

---

## 页面 4：关于 `/about`

### 个人介绍区
- **头像** — 📦
  > 路径：`public/images/linka-portrait.jpg`

- **身份一句话** — 📝
  > 独立设计师，分一半时间画画，一半时间帮品牌讲故事。

- **详细介绍**（300-500 字）— 🤖
  - **生成需求**：第一人称长文，分 3-4 段：
    1. 现在在做什么 + 风格特点
    2. 经历背景（学习 / 工作 / 决定独立的契机）
    3. 工作哲学 / 合作方式偏好
    4. 一段闲笔，加点温度（爱好 / 工作室所在城市 / 对设计的看法）
  - **语气**：温暖、editorial、可读性强、不张扬
  - **必含信息**：3 年自由设计经验、合作过 20+ 中小品牌、双线（品牌 + 插画）、工作室在 {城市}

- **时间线** — 📦
  - **数据源**：`src/content/timeline.json`
  - **schema**：`{ year: number, milestone: string }[]`

### 合作品牌区
- **品牌 logo 列表（完整）** — 📦
  - **数据源**：同 `brands.json`，但显示全部（不限于首页的 3-5 个）

### 联系入口
- **一句话** — 📝
  > 想找我做点东西？

- **按钮** — 📝
  > 写邮件给我

---

## 页面 5：联系 `/contact`

### 表单区
- **页面标题** — 📝
  > 开始合作
- **页面副文案** — 🤖
  - **生成需求**：1-2 句话，告诉访客"我会怎么回复 + 多久"，温暖但专业

- **表单字段标签和 placeholder** — 📝
  | 字段 | label | placeholder |
  |---|---|---|
  | 姓名 | 你叫什么 | Linka |
  | 邮箱 | 邮箱 | hi@example.com |
  | 项目类型 | 项目类型 | 品牌设计 / 插画 / 其他 |
  | 预算 | 预算（可选） | 暂时不确定也可以 |
  | 描述 | 想做什么 | 简单讲讲你的项目背景和期望... |

- **提交按钮文字** — 📝
  > 发送

- **隐私小字** — 📝
  > 你的邮件只会发给 Linka，不会用于其他用途。详见 [隐私政策](/privacy)。

### 直接联系区
- **邮箱**（备用方式） — 📝
  > 或直接发邮件到 hi@linka.design

- **社交账号** — 📝
  > Instagram · Are.na

---

## 样例数据骨架

### `src/content/works/example-brand-stripe-redesign.mdx`

```mdx
---
title: Stripe 视觉重塑
slug: brand-stripe-redesign
client: Stripe
year: 2024
type: brand
coverImage: /images/works/stripe-cover.jpg
gallery:
  - /images/works/stripe-1.jpg
  - /images/works/stripe-2.jpg
  - /images/works/stripe-3.jpg
summary: 为 Stripe 设计的 2024 视觉系统更新...
featured: true
heroEligible: true
order: 1
---

## 背景
{1-2 段介绍这个项目的客户、产品、面临的问题}

## 挑战
{1-2 段介绍设计上的难点}

## 思路
{1-3 段介绍设计决策和理由}

## 结果
{1 段介绍交付物 + 客户反馈 + 数据}
```

### `src/content/brands.json`

```json
[
  { "name": "Stripe", "logo": "/images/brands/stripe.svg" },
  { "name": "Notion", "logo": "/images/brands/notion.svg" },
  { "name": "Linear", "logo": "/images/brands/linear.svg" }
]
```

### `src/content/timeline.json`

```json
[
  { "year": 2019, "milestone": "毕业于中央美院，主修视觉传达" },
  { "year": 2020, "milestone": "在 4A 公司做 visual designer 18 个月" },
  { "year": 2022, "milestone": "决定独立，开始接私单" },
  { "year": 2024, "milestone": "工作室落在杭州，合作过 20+ 品牌" }
]
```

---

## 文案写作规范（给所有 🤖 PROMPT 模式的约束）

呼应 DESIGN.md Do's & Don'ts 和 BRIEF 的目标用户（中小品牌创始人 + design lead）：

**Do's**：
- ✅ 温暖中性，editorial 节奏
- ✅ 句子有韵律，长短交替
- ✅ 量化数据具体（"3 年 / 20+ 品牌" 比 "多年经验" 好）
- ✅ 用具象动词（"为 Stripe 重新设计..."）

**Don'ts**：
- ❌ 全大写英文标题（caption 除外）
- ❌ "赋能"、"打造"、"革新"、"颠覆"、"极致"
- ❌ 表情符号装饰（除非内容确实需要）
- ❌ 命令式 CTA（"立即购买"、"马上联系"）
- ❌ 自夸（"业内顶尖"、"最优秀"）

**字数 / 语气默认**：
- 标题：10-25 字
- 副文案 / 描述：30-80 字
- 长文段落：1 段约 80-150 字，3-5 段为宜
- 语气：第二人称中性，避免过度热情

---

## 拆分文件示范（content/snippets/）

Linka 的项目里**绝大多数长内容都是 🤖 模式**（用户偏好让 AI 按需求生成），所以拆分文件很少。这里给一个示范——假设 Linka 决定 `/privacy` 页面她要自己手写完整文本（📝），那就会有一份 `content/snippets/privacy-policy.md`：

```markdown
<!-- content/snippets/privacy-policy.md -->
<!-- 用于 /privacy 页面的"完整隐私政策"内容槽 -->

# Linka 设计工作室 · 隐私政策

最后更新：2026 年 5 月

## 我们收集什么

当你通过本网站的联系表单提交咨询时，我们会收集你提供的信息：
- 你填写的姓名 / 邮箱 / 项目类型 / 预算区间 / 描述

我们使用 Plausible Analytics 跟踪访客访问情况。Plausible 不使用 cookie，不收集个人识别信息——它只统计页面访问量、来源、热门页面等聚合数据。

## 我们如何使用

...（接下来 200+ 字的完整政策文本）

## 你的权利

如果你想查看 / 删除你提交过的联系表单数据，发邮件到 hi@linka.design 即可。
```

而 CONTENT.md 里这一槽**只放 reference**：

```markdown
### 法务页
- **隐私政策** 📝
  > 见 [`content/snippets/privacy-policy.md`](./content/snippets/privacy-policy.md)
```

这样 AI 写 `/privacy` 页面代码时，**索引看 CONTENT.md，内容读 `privacy-policy.md`**，CONTENT.md 不被法律文本撑爆。

**Linka 项目预估**：当前 CONTENT.md 约 3300 字（多 🤖 描述 + 📦 数据源说明）。如果 Linka 决定把每篇作品的"设计思路 500-800 字"用 📝 而不是 📦 MDX 的话，那就要拆出 8 份 `content/snippets/work-{slug}-thinking.md` —— 这是典型的"项目长大时自动拆分"场景。
