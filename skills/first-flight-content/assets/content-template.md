# {项目名} · CONTENT · v1-launch

> 文件位置：`iterations/v1-launch/CONTENT.md`（**仅首次开发产出**——后续迭代不再写 CONTENT.md）
> 配合 [PRD.md](./PRD.md)（同目录，信息架构）+ [DESIGN.md](../../DESIGN.md)（Do's & Don'ts + voice）+ [ARCHITECTURE.md](../../ARCHITECTURE.md)（数据存储）阅读。
>
> 本文件给 PRD 的每个**内容槽**填上具体内容，AI 写代码时按这里的标记处理：📝 直接用文案 / 🤖 按需求生成 / 📦 从数据源读。

## 模式说明

- **📝 COPY（直接文案）**——用户已写好的具体文字。**≤ 100 字直接内联在本文件；> 100 字拆到 `content/snippets/{slug}.md`，这里只留 reference**
- **🤖 PROMPT（AI 生成需求）**——用户描述要什么样的，AI 在写代码时根据需求 + DESIGN.md 的 voice 生成（内联）
- **📦 DATA（数据源）**——内容来自结构化文件（MDX / JSON / Content Collections），AI 从指定路径读

**目录约定**：长文案 / 数据源都在 `content/` 下；本文件 CONTENT.md 是索引（目标 ≤ 2000 字）。

---

## 全局内容资源

### 网站元信息
- **网站标题** 📝
  > {Title}
- **SEO meta title 模板** 📝
  > `{页面标题} · {网站标题}`
- **默认 meta description** 📝 / 🤖
  > ...
- **OG image** 📦
  > 路径：`public/og-image.jpg`
- **Favicon** 📦
  > 路径：`public/favicon.svg`

### 联系方式
- **邮箱** 📝
  > {email@example.com}
- **社交账号** 📝
  > Twitter: ...
  > Instagram: ...
  > LinkedIn: ...

### 法务页链接（如有）
- **隐私政策** 📝
  > 完整文本见下方 / 或链接到 `/privacy`
- **服务条款** 📝
  > ...

### 状态 / 错误页文案
- **404 标题** 📝 / 🤖
  > ...
- **404 副文案** 📝 / 🤖
  > ...
- **表单提交成功** 📝
  > ...
- **表单提交失败** 📝
  > ...

---

## 页面 1：{首页 `/`}

### {Hero 区}（呼应 PRD §5）
- **slogan**（PRD: 1 句，15-25 字）— 📝
  > {短文案直接内联}

- **副文案**（PRD: 1-2 句，~80 字）— 🤖
  - **生成需求**：{长度 / 语气 / 关键词 / 反例}

- **主视觉图** — 📦
  > 路径：`...`

- **主 CTA 按钮文字** — 📝
  > {≤ 10 字直接内联}

### About 区
- **个人介绍长文**（~300 字）— 📝
  > 见 [`content/snippets/about-bio.md`](./content/snippets/about-bio.md)

### {下一个区块}
...

---

## 页面 2：...

---

## 样例数据骨架（如有 📦 模式）

### `src/content/works/example.mdx`
```mdx
---
title: ...
slug: ...
...
---

正文 MDX 内容...
```

### `data/team.json`（如有）
```json
[
  { "name": "...", "role": "...", "avatar": "..." }
]
```

---

## 文案写作规范（给所有 🤖 PROMPT 模式参考）

呼应 DESIGN.md Do's & Don'ts + BRIEF 的目标用户和语气：

- ✅ {Do's 摘要 1}
- ✅ {Do's 摘要 2}
- ❌ {Don'ts 摘要 1}
- ❌ {Don'ts 摘要 2}

字数 / 语气 / 词汇默认规则：
- 标题字数限制：...
- 正文段落字数：...
- 语气：...
- 避免使用的词：...
