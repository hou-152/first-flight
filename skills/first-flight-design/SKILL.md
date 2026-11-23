---
name: first-flight-design
description: First Flight 系列的第 3 步——通过结构化对话帮用户产出符合 Google DESIGN.md 标准的网站项目 DESIGN.md，定义视觉与 UX 风格（气质、色彩、字体、布局、阴影、形状、组件、Do's and Don'ts），并扩展 First Flight 独有内容（动效、响应式、a11y、UI 框架倾向、参考）。当用户已经有 PRD.md 准备进入"网站长什么样"层面、或者用户说"帮我定网站的风格 / 视觉 / 设计语言"、"create a design spec for my site"、"我有 PRD 了下一步是设计"时，请务必使用这个 skill。**只服务于第一次设计定义**，不处理重构。这是 First Flight 流程的第 3 步（BRIEF → PRD → **DESIGN** → ARCHITECTURE → CONTENT → AGENTS），输出会成为 ARCHITECTURE.md（UI 框架选型）的输入。
---

# First Flight · DESIGN

帮用户产出符合 **Google DESIGN.md 标准**（[google-labs-code/design.md](https://github.com/google-labs-code/design.md)）的设计文档，同时扩展 First Flight 流程独有的内容。

生成的文件可以被 `npx @google/design.md lint DESIGN.md` 校验，也能 export 成 Tailwind / DTCG token 格式，供 Codex 或 Claude 精确消费。

## 与其他文档的分界

- **PRD.md** 已经定义了：页面结构 + 信息架构 + 每个区块的内容槽。DESIGN **不重复**这些，DESIGN 只管"每个区块**长什么样**"。
- **DESIGN.md**（这个 skill 的输出）：YAML token（colors / typography / rounded / spacing / elevation / components）+ markdown 说明（Overview / Colors / Typography / Layout / Elevation / Shapes / Components / Do's and Don'ts）+ First Flight 扩展（Motion / Responsiveness / Accessibility / UI Framework Considerations / References）
- **ARCHITECTURE.md**（下一步）：技术栈、代码组织、部署 —— 会参考 DESIGN 的 UI 框架倾向选具体的库
- **CONTENT.md**（后续）：每个内容槽的具体文案 / 数据来源

## 文件格式（Google DESIGN.md 标准）

DESIGN.md 有两层结构：

1. **YAML front matter**（机器可读 tokens）—— 由 `---` 包围
2. **Markdown body**（人类可读的 design rationale）—— 用 `##` 分 section

### YAML Token Schema

```yaml
---
name: <项目名>
description: <一句话设计气质描述>

colors:
  primary: "#hex"
  secondary: "#hex"
  tertiary: "#hex"
  neutral: "#hex"           # 背景 / 表面色
  on-primary: "#hex"        # 主色上的文字色（确保对比度）
  on-neutral: "#hex"        # neutral 上的文字色
  success: "#hex"
  warning: "#hex"
  error: "#hex"
  # 可加更多 token，但保持 primary 必选

typography:
  h1:
    fontFamily: <字体名>
    fontSize: <如 "3rem"，单位 rem/em/px>
    fontWeight: <数字，如 500>
    lineHeight: <如 "1.2">
    letterSpacing: <可选，如 "-0.02em">
  h2: {...}
  h3: {...}
  body: {...}              # 或 body-md
  caption: {...}
  # 至少要有 h1 + body

spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  2xl: 48px

rounded:
  none: 0
  sm: 4px
  md: 8px
  lg: 12px
  full: 9999px

elevation:                  # 阴影层级
  none: "none"
  sm: "0 1px 2px rgba(0,0,0,0.05)"
  md: "0 4px 6px rgba(0,0,0,0.07)"
  lg: "0 10px 20px rgba(0,0,0,0.1)"

components:                 # 关键组件的 tokens（使用 token reference）
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    rounded: "{rounded.md}"
    padding: "12px 24px"
    typography: "{typography.body}"
  button-primary-hover:
    backgroundColor: "{colors.secondary}"
  button-secondary: {...}
  card: {...}
  input-text: {...}
  badge: {...}
  # 变体（hover / active）作为独立 entry，命名约定 base + state
---
```

**Token Reference 规则**：用 `{path.to.token}` 引用其他 token，让 AI 知道这些值是关联的（改 primary 时所有引用它的地方都跟着变）。

### Markdown Body Section 顺序（Google 标准）

必须按这个顺序（缺哪个可以省略，但出现的必须按序）：

1. **Overview** —— 整体气质 / 设计语言 / 一句话定位
2. **Colors** —— 每个 color token 的用途和理由
3. **Typography** —— 字体选择理由 + 层级关系
4. **Layout** —— 间距 scale + 布局模式 + 断点
5. **Elevation & Depth** —— 阴影 / 层级 / 表面感
6. **Shapes** —— 形状语言（角锐 vs 圆 / 边框风格 / 视觉密度）
7. **Components** —— 每个 component 的形态描述（呼应 YAML 里的 component tokens）
8. **Do's and Don'ts** —— 明文写"做什么 / 不做什么"

### First Flight 扩展 sections（在 Do's and Don'ts 之后）

Google spec 允许 "Unknown section heading: Preserve; do not error"。我们扩展 5 个 section：

9. **Motion & Animation** —— 动效尺度（无 / 微 / 适度 / 丰富）+ 典型场景
10. **Responsiveness** —— 断点策略 + 移动端简化
11. **Accessibility** —— WCAG 等级 + 关键 a11y 目标
12. **UI Framework Considerations** —— 对组件库的诉求 + 2-3 个候选库（给 ARCHITECTURE 输入）
13. **References & Inspiration** —— 参考站点 + 用户灵感来源（截图 / 文字描述）

## 整体流程

```
Step 0   读 BRIEF.md + PRD.md
   ↓
Step 1   识别经验度 → 路径 A / B
   ↓
Step 2   分批问问题（5 批）：
         1. 整体气质 + 参考站点（含 8 个预设套件可选）
         2. 色彩 + 字体（基于气质给候选 / 接受具体值 / 从截图提取）
         3. 形状语言 + 阴影感 + 组件形态
         4. 动效 + 响应式 + a11y + UI 框架倾向
         5. Do's and Don'ts（明文收集"绝对不做的事"）
   ↓
Step 3   生成 DESIGN.md（YAML front matter + 8 Google sections + 5 First Flight 扩展 sections）
   ↓
Step 4   预览 → 写文件 → 提示用户可以跑 `npx @google/design.md lint DESIGN.md` 验证
   ↓
Step 5   自动衔接 ARCHITECTURE
```

## Step 0：读 BRIEF.md + PRD.md

两个文档都要读。BRIEF 提供长期气质方向，PRD 提供页面结构（决定组件需求范围——比如有作品列表的项目需要 `card-work` 组件，有表单的项目需要 `input-text`）。

## Step 1：识别经验度

`AskUserQuestion` 4 选项分流到路径 A（小白，大量预设 + 选项）或路径 B（有经验，可直接给 hex / 字体名 / 自定义 token）。

## Step 2：5 批问题

### 批 1：整体气质 + 参考站点

要拿到：
1. **预设选择**——8 个预设套件（`references/presets.md`），让用户选 1 个或叠加 2 个
2. **参考站点**——从灯火库（`references/reference-sites.md`）挑 1-3 个 + 用户自带 URL / 截图 / 文字描述
3. **一句话气质概括**——后续会写进 YAML front matter 的 `description` 字段

### 批 2：色彩 + 字体（输出为 YAML tokens）

**规则：用户精度优先**——给精确 hex 用精确 hex；给参考方向给候选；给截图从截图提取色板。

#### 色彩 token 必填项

- `primary` —— 主品牌色
- `neutral` —— 背景 / 表面色（深色模式下需要单独 `neutral-dark`）
- `on-primary` —— 主色上文字色（确保对比 ≥ 4.5:1）
- `on-neutral` —— 背景上文字色

可选：`secondary`、`tertiary`、`success`、`warning`、`error`。

#### Typography token 必填项

- `h1` + `body`（最少）
- 推荐：`h1` / `h2` / `h3` / `body` / `caption`
- 每个 entry 至少包含 `fontFamily` + `fontSize`，可选 `fontWeight` / `lineHeight` / `letterSpacing`

**自动 a11y 检查**：写完 colors + components 后，skill 应**主动检查 primary/on-primary 的对比度**，提示用户如果 < 4.5:1（lint 规则之一）。

### 批 3：形状语言 + 阴影感 + 组件形态

#### Shapes（形状语言）

要拿到：
- **整体角度**：sharp（0 / 2px）/ rounded（8-12px）/ very rounded（16-24px）/ pill（full）
- **边框风格**：无边框 / 细线（1px）/ 粗线（2-3px）/ 双层装饰
- **视觉密度**：紧凑 / 标准 / 宽松

路径 A 用预设默认值。路径 B 可直接给 token。

#### Elevation & Depth（阴影感）

4 级让用户选：
- **flat**（无阴影，纯排版分层）—— 杂志阅读 / 极简 / 复古常用
- **soft**（极轻阴影，1 层）—— 现代极简、温和有机常用
- **layered**（多层阴影 sm/md/lg，明显立体感）—— 友好可爱常用
- **deep**（带 glow / 内阴影 / 浮起感）—— 极客 / 游戏类常用

#### 组件 token

至少要定义这 5 个组件（YAML 输出）：
- `button-primary` + `button-primary-hover`
- `button-secondary`
- `card`（如 PRD 里有作品 / 文章列表）
- `input-text`（如 PRD 里有表单）
- `badge`（标签 / 类型标识）

如果 PRD 里页面更复杂，按需追加（如 `nav-item` / `dialog` / `code-block`）。

每个组件用 token reference 引用 colors / rounded / typography 而不是写死值。

### 批 4：动效 + 响应式 + a11y + UI 框架倾向

- **动效**：4 级（无 / 微 / 适度 / 丰富）+ 典型场景（hover / 页面切换 / 滚动入场 / hero 动画）
- **响应式**：断点（默认 Tailwind 风格）+ 移动端简化策略
- **a11y**：WCAG 等级（默认 AA）+ 其他要求（如 prefers-reduced-motion）
- **UI 框架倾向**：3-5 条诉求 + 2-3 个候选库（参考预设里每个气质对应的推荐）

### 批 5：Do's and Don'ts（**重要**）

这是 Google 标准里专门一节，**对 AI 极有用**。要让用户明确说出他**绝对不想要**的设计倾向。

路径 A 提示：列一些常见 anti-patterns 让用户认领：
- ❌ 不要用渐变背景
- ❌ 不要用 stock 照片
- ❌ 不要全大写标题
- ❌ 不要 emoji 装饰
- ❌ 不要 carousel / slider
- ❌ 不要弹窗 / popup
- ❌ 不要 hero 视频背景
- ❌ 不要荧光色 / neon
- ❌ 不要 3D / 渲染感图标

让用户挑 3-5 条作为 Don'ts，再追问"还有什么是你看到就反感的？"

路径 B 直接问"你的设计黑名单是什么"。

也要收集 **Do's**——同样的方式：
- ✅ 始终用真实作品图，不用 stock
- ✅ 所有交互组件支持键盘聚焦
- ✅ 整体大量留白
- ✅ 排版优先于装饰
- ✅ ...

## Step 3：生成 DESIGN.md

按下列结构组装。**字数预期 2000-4000 字**（YAML + 13 sections）。

```markdown
---
{完整 YAML front matter}
---

## Overview
{2-3 段。整体气质 / 选定预设 / 一句话定位 / 核心 vibe 关键词}

## Colors
{每个 color token 的用途和应用场景。例：}
- **Primary (#1A1C1E):** Deep ink for headlines and core text.
- **Secondary (#6C7278):** Sophisticated slate for borders and metadata.
...

## Typography
{字体选择理由 + 层级关系 + 字号尺度的含义}

## Layout
{间距 scale + 常用布局模式 + 断点}

## Elevation & Depth
{阴影层级的应用规则。flat / soft / layered / deep 中的哪一档，每档用在什么场景}

## Shapes
{角度 / 边框 / 整体形状语言。如 "圆角统一 4-8px，边框 1px，没有装饰性形状"}

## Components
{每个 YAML 里定义的组件，配一段用法说明。}

### button-primary
Used for the single highest-priority action on a page. ...

### card-work
Used in the works grid on the homepage and `/works`. ...

## Do's and Don'ts

### Do's
- ✅ ...

### Don'ts
- ❌ ...

---

## Motion & Animation
**Level:** {无 / 微 / 适度 / 丰富}

**Typical scenes:**
- Button hover: ...
- Page transition: ...
- Scroll-in: ...

## Responsiveness
**Breakpoints:** ...
**Approach:** mobile-first
**Mobile simplifications:** ...

## Accessibility
**WCAG target:** AA
**Color contrast:** ...
**Keyboard navigation:** ...
**Other:** {如 prefers-reduced-motion 支持}

## UI Framework Considerations
**Requirements:**
- ...
- ...

**Candidate libraries:**
- **{Library 1}** —— ...
- **{Library 2}** —— ...

(Final selection deferred to ARCHITECTURE.md)

## References & Inspiration
**Reference sites:**
- [Site 1](url) —— captured visual feature
- ...

**User-provided inspiration:** {截图描述 / 文字 vibe}
```

## Step 4：预览 + 写文件 + lint 提示

预览给用户看，问"哪里要调？"。改完写到 `./DESIGN.md`（项目根，长期文档）。

写完后告诉用户：

> DESIGN.md 已经写好。你可以跑 `npx @google/design.md lint DESIGN.md` 校验格式 + 检查色彩对比度。要导出成 Tailwind config 用 `npx @google/design.md export --format css-tailwind DESIGN.md > theme.css`。

## Step 5：自动衔接 ARCHITECTURE

```
> DESIGN.md 已写完。下一步是 ARCHITECTURE.md——根据 DESIGN 里的 UI 框架倾向、动效尺度、布局复杂度，定具体的技术栈（Next.js / Astro / Nuxt / 静态站）、UI 库选型（shadcn / Mantine / 自定义）、代码组织、部署方式。
>
> 我直接帮你启动 ARCHITECTURE。如果你想先停一下，告诉我一声。
```

立即切换到 `first-flight-architecture` skill。

> First Flight 完整流程还剩：ARCHITECTURE.md（技术选型）→ CONTENT.md（内容填充）→ AGENTS.md（AI 入口文档）。

## 写作风格守则

- **YAML 是 normative**——token 值是权威的，markdown 文字只是解释
- **token reference 优先**——组件值能用 `{colors.primary}` 就别写死 `#1F1F1B`
- **变体用独立 entry**——`button-primary` 和 `button-primary-hover` 是两个 entry，不要在一个 entry 里写嵌套
- **不写代码**——DESIGN 里没有 CSS / Tailwind utility / 框架 API（那是 ARCHITECTURE）
- **不写具体文案**——slogan 是什么字归 CONTENT，DESIGN 只管 "slogan 用 h1 typography"
- **Do's 和 Don'ts 要明文且具体**——"不要用渐变"OK，"避免太花哨"太模糊

## 参考

- `references/presets.md`——8 个预设套件库（每个含 colors / typography / elevation / shapes / typical do's & don'ts / 推荐 UI 库）
- `references/reference-sites.md`——20+ 灯火站点库
- `references/example-design.md`——Linka 个人作品集的完整 DESIGN 示例（按 Google 标准 + First Flight 扩展）
- `assets/design-template.md`——纯净模板（YAML front matter + 13 sections）
