# DESIGN.md 完整示例（接续 Linka 个人作品集）

格式遵循 [Google DESIGN.md 标准](https://github.com/google-labs-code/design.md) + First Flight 扩展。

可以用 `npx @google/design.md lint DESIGN.md` 校验，用 `npx @google/design.md export --format css-tailwind DESIGN.md > theme.css` 导出 Tailwind 主题。

---

```yaml
---
name: "Linka Portfolio"
description: "Architectural minimalism meets editorial gravitas — a serene portfolio for an illustrator + brand designer."

colors:
  primary: "#1F1F1B"
  secondary: "#6B6660"
  tertiary: "#A14B3D"
  neutral: "#F5F0E8"
  on-primary: "#F5F0E8"
  on-neutral: "#1F1F1B"
  on-tertiary: "#F5F0E8"
  success: "#5C7A3D"
  warning: "#C68A2E"
  error: "#A14B3D"

typography:
  h1:
    fontFamily: "Tiempos Headline"
    fontSize: "3.5rem"
    fontWeight: 500
    lineHeight: "1.15"
    letterSpacing: "-0.01em"
  h2:
    fontFamily: "Tiempos Headline"
    fontSize: "2.25rem"
    fontWeight: 500
    lineHeight: "1.2"
  h3:
    fontFamily: "Tiempos Headline"
    fontSize: "1.5rem"
    fontWeight: 500
    lineHeight: "1.3"
  body:
    fontFamily: "Söhne"
    fontSize: "1.0625rem"
    fontWeight: 400
    lineHeight: "1.6"
  body-large:
    fontFamily: "Söhne"
    fontSize: "1.25rem"
    fontWeight: 400
    lineHeight: "1.55"
  caption:
    fontFamily: "Söhne"
    fontSize: "0.875rem"
    fontWeight: 400
    lineHeight: "1.4"
    letterSpacing: "0.01em"

spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  2xl: 48px
  3xl: 64px
  4xl: 96px

rounded:
  none: 0
  sm: 2px
  md: 6px

elevation:
  none: "none"
  sm: "0 1px 0 rgba(31,31,27,0.06)"

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    rounded: "{rounded.none}"
    padding: "16px 24px"
    typography: "{typography.body}"
  button-primary-hover:
    backgroundColor: "{colors.secondary}"
    textColor: "{colors.on-primary}"
  button-secondary:
    backgroundColor: "transparent"
    textColor: "{colors.primary}"
    rounded: "{rounded.none}"
    padding: "16px 24px"
    typography: "{typography.body}"
  card-work:
    backgroundColor: "transparent"
    rounded: "{rounded.md}"
    padding: 0
  card-work-hover:
    backgroundColor: "transparent"
  input-text:
    backgroundColor: "transparent"
    textColor: "{colors.primary}"
    rounded: "{rounded.none}"
    padding: "12px 0"
    typography: "{typography.body}"
  badge:
    backgroundColor: "transparent"
    textColor: "{colors.secondary}"
    rounded: "{rounded.sm}"
    padding: "4px 8px"
    typography: "{typography.caption}"
---
```

## Overview

Linka 的个人作品集网站采用 **杂志阅读（Editorial）+ 一点温和有机** 的复合气质——像 Aesop 的米色温度叠加 The Verge 的 editorial 节奏。整体克制、留白、有节奏，把"屏幕"还给作品图本身的质感。

**预设：** Editorial + Soft Organic（叠加）

**气质关键词：** 留白、editorial、温暖、有节奏、不张扬

## Colors

调色板基于"暖墨 + 米白 + 一抹砖红"的高对比中性，避开纯黑纯白的冷硬。

- **Primary `#1F1F1B`** —— 暖墨色，所有标题和正文。不是纯黑，避免冷硬。
- **Secondary `#6B6660`** —— 暖灰，用于边框、caption、metadata、hover 状态。
- **Tertiary `#A14B3D`** —— 砖红，唯一的交互驱动色（链接、主 CTA）。
- **Neutral `#F5F0E8`** —— 米白背景，温暖而非纯白，给作品图一个柔和的衬托。
- **On-primary `#F5F0E8`** —— 暖墨上的米白文字（对比 11.2:1，远超 AA）。
- **On-neutral `#1F1F1B`** —— 米白上的暖墨文字（对比 11.2:1）。
- **Success / Warning / Error** —— 暖绿 / 芥末 / 复用砖红，保持暖色家族一致性。

**不做深色模式**——杂志阅读气质依赖米色温度，强求 dark 会失去这份感觉。

## Typography

**Heading family: Tiempos Headline**——高质感衬线体，带 editorial 重量感和温度。
**Body family: Söhne**——humanist sans，可读性强且和衬线标题协调。

**Scale rationale**：
- H1 56px / line-height 1.15——大标题作为视觉锚点，不堆叠
- 正文 17px / line-height 1.6——略大于 16，强调阅读舒适
- caption 14px 加 0.01em letter-spacing——元数据有"editorial 标签感"

## Layout

**Spacing scale**: 4px-based。常用 16 / 24 / 32 / 48 / 64。

**Common layouts**:
- 首页：hero 全宽（左文右图分屏）→ 简介窄栏 → 精选作品 3 列 grid → CTA 区
- 作品列表：12 列规整 grid（非 masonry）
- 作品详情：单栏阅读，max-width 800px 居中，作品图全宽嵌入文字间
- 关于页：左右两栏（左：头像 + 时间线，右：长文）
- 联系页：表单居中，max-width 600px

**Breakpoints**: sm 640 / md 768 / lg 1024 / xl 1280

## Elevation & Depth

**Level**: flat（几乎无阴影）

杂志阅读 + 温和有机的复合气质不依赖阴影分层，而是用排版层级 + 留白 + 边框区分表面。

- `elevation.none` —— 卡片、容器、整体页面默认无阴影
- `elevation.sm` —— 仅在表单提交按钮 hover 时出现极轻阴影（`0 1px 0 rgba(31,31,27,0.06)`），暗示交互发生

## Shapes

**Overall sharpness**: sharp（圆角 0-6px，几乎方形）

**Border philosophy**: hairline（1px solid，使用 secondary 色或 primary 半透明）

**Visual density**: 宽松（spacing 偏大，留白多）

形状语言总结：**几乎所有元素是方形或极小圆角**（按钮 0px，作品图 6px 缓和锐感）。**装饰性形状一律不用**——没有渐变、没有 blob、没有 squircle。

## Components

### button-primary
单页面最多 1 个，用于唯一的高优先级动作（如"咨询合作"）。方形 + 暖墨实色 + 米白字，padding 偏大显沉稳。Hover 时 background 变 secondary（更轻），暗示可点击。

### button-secondary
透明背景 + 暖墨字 + 无边框（仅 hover 时下划线变粗）。用于次要动作（如"查看全部作品"）。

### card-work
极简——无边框、无阴影、仅作品图 + 下方左对齐的标题 + 类型标签。Hover 时作品图轻微 scale 1.03（300ms），标题颜色变 tertiary（砖红）暗示可点击。

### input-text
**下划线风格**——无边框、仅 bottom 1px，focus 时下划线变 2px tertiary。和整体的 editorial 感一致。

### badge
透明背景 + 1px hairline + caption typography + 0.01em letter-spacing。用于作品类型标签（"品牌设计"/"插画"）。

## Do's and Don'ts

### Do's
- ✅ 始终用真实作品图，不用 stock 照片
- ✅ 所有作品图必须有有意义的 alt 文本（描述类型 + 客户 + 主体）
- ✅ 留白优先于装饰
- ✅ 排版用衬线 / 无衬线对比建立 editorial 节奏
- ✅ 砖红色只用于交互（链接、CTA），不要扩散到大色块
- ✅ 所有交互组件支持键盘聚焦
- ✅ 支持 prefers-reduced-motion

### Don'ts
- ❌ 不要用渐变背景（任何地方）
- ❌ 不要 stock 照片 / 摄影素材库
- ❌ 不要 emoji 装饰（除非作为内容）
- ❌ 不要 hero 视频 / 动画背景
- ❌ 不要 carousel / slider（作品列表用静态 grid）
- ❌ 不要弹窗 / 模态框 / popup
- ❌ 不要荧光色 / neon / 高饱和 accent
- ❌ 不要全大写英文标题（caption 例外）
- ❌ 不要 3D 渲染 / glassmorphism / neumorphism

---

## Motion & Animation

**Level**: 微（subtle）

**Typical scenes**:
- **Button hover**: 200ms background-color 过渡
- **Page transition**: 极轻 fade-in 150ms（不做滑动）
- **Scroll-in**: 不做（杂志阅读不需要入场动效）
- **Hero animation**: 静态，无动效
- **Card hover**: 作品图 scale 1→1.03（300ms ease-out）+ 标题色变

**Constraints**: 支持 `prefers-reduced-motion: reduce`——开启时所有 transform 关闭，仅保留 color transition。

## Responsiveness

**Approach**: mobile-first

**Mobile simplifications**:
- 导航: 顶部水平 → 全屏抽屉
- 首页 hero: 左文右图 → 上下堆叠（图在上、占 60vh）
- 作品 grid 3 列 → 1 列
- 关于页左右两栏 → 上下堆叠
- 字号: H1 56→40px

## Accessibility

**WCAG target**: AA

**Color contrast**:
- Primary on Neutral: 11.2:1 ✅
- Secondary on Neutral: 4.8:1 ✅（仅用于 caption 和 metadata）
- Tertiary on Neutral: 5.2:1 ✅

**Keyboard navigation**: 全覆盖（所有作品卡、按钮、表单字段可 Tab + Enter 触发）

**Screen reader**:
- 所有作品图必须有 alt 描述
- 导航用 `<nav>` 语义标签
- 表单字段用 `<label>` 关联
- skip-to-content 链接

**Other**: 支持 `prefers-reduced-motion`，开启时关闭所有 transform 类动效。

## UI Framework Considerations

**Requirements**:
- 极轻量——杂志阅读型站点不需要重组件库
- 可自由 restyle——避免被 Material / Mantine 那种"有自己 opinion"的库锁死
- 类型友好（TypeScript first）
- 静态生成友好（SSG），适合作品集类网站
- 原生 a11y 行为（focus management / aria）不要我自己手搓

**Candidate libraries**:
- **shadcn/ui** —— 复制粘贴组件源码，可自由 restyle，最贴合气质。底层 Radix Primitives 提供 a11y。
- **Radix Primitives**（备选）—— 只要 unstyled a11y 行为，视觉完全自定义。比 shadcn 更克制。
- **不用** —— Mantine / Chakra / Material UI / Tailwind UI components（视觉风格太强，难匹配 editorial）

最终选择留给 ARCHITECTURE.md，根据完整技术栈（SSG framework / 部署方式）决定。

## References & Inspiration

**Reference sites**:
- [Aesop](https://aesop.com) —— 米色背景 + 极致留白，让产品图主导
- [Are.na](https://are.na) —— 极简灰色 editorial，专业感强
- [Werner.dev](https://werner.dev) —— 个人作品集的复古质感参考
- [Studio Yorktown](https://studioyorktown.com) —— serif 标题 + 黑白几何对比

**User-provided inspiration**: Linka 提到希望"像高铁车窗外晨雾里的旧火车站，有点孤独但温暖"——这种 vibe 转译成了暖墨主色（不是冷黑）、米白背景（不是纯白）、砖红 accent（不是品牌蓝）的色彩选择。
