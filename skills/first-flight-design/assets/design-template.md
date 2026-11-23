---
name: "{项目名}"
description: "{一句话设计气质描述}"

colors:
  primary: "#hex"
  secondary: "#hex"
  tertiary: "#hex"
  neutral: "#hex"
  on-primary: "#hex"
  on-neutral: "#hex"
  success: "#hex"
  warning: "#hex"
  error: "#hex"

typography:
  h1:
    fontFamily: "{字体名}"
    fontSize: "3rem"
    fontWeight: 500
    lineHeight: "1.2"
  h2:
    fontFamily: "{字体名}"
    fontSize: "2.25rem"
    fontWeight: 500
    lineHeight: "1.2"
  h3:
    fontFamily: "{字体名}"
    fontSize: "1.5rem"
    fontWeight: 500
    lineHeight: "1.3"
  body:
    fontFamily: "{字体名}"
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: "1.6"
  caption:
    fontFamily: "{字体名}"
    fontSize: "0.875rem"
    fontWeight: 400
    lineHeight: "1.4"

spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  2xl: 48px
  3xl: 64px

rounded:
  none: 0
  sm: 4px
  md: 8px
  lg: 12px
  full: 9999px

elevation:
  none: "none"
  sm: "0 1px 2px rgba(0,0,0,0.05)"
  md: "0 4px 6px rgba(0,0,0,0.07)"

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    rounded: "{rounded.md}"
    padding: "12px 24px"
    typography: "{typography.body}"
  button-primary-hover:
    backgroundColor: "{colors.secondary}"
    textColor: "{colors.on-primary}"
  button-secondary:
    backgroundColor: "transparent"
    textColor: "{colors.primary}"
    rounded: "{rounded.md}"
    padding: "12px 24px"
  card:
    backgroundColor: "{colors.neutral}"
    rounded: "{rounded.md}"
    padding: "{spacing.lg}"
  input-text:
    backgroundColor: "transparent"
    textColor: "{colors.on-neutral}"
    rounded: "{rounded.sm}"
    padding: "{spacing.sm} {spacing.md}"
  badge:
    backgroundColor: "transparent"
    textColor: "{colors.secondary}"
    rounded: "{rounded.sm}"
    padding: "4px 8px"
---

## Overview

{2-3 段描述整体气质 / 选定预设 / 一句话定位 / 核心 vibe 关键词}

**预设：** {预设名}（可叠加）

**气质关键词：** {3-5 个形容词}

## Colors

{每个 color token 的用途和应用场景。每个 token 一行。}

- **Primary `{hex}`** —— {用途，如 "标题和核心文字"}
- **Secondary `{hex}`** —— {用途}
- **Tertiary `{hex}`** —— {用途}
- **Neutral `{hex}`** —— {用途，通常是背景 / 表面}
- **On-primary `{hex}`** —— {主色上的文字色，确保对比}
- **On-neutral `{hex}`** —— {背景上的文字色}
- **Success / Warning / Error** —— {语义色用途}

## Typography

{字体选择理由 + 层级关系 + 字号尺度的含义。}

**Heading family**: {字体名 + 字符特征}
**Body family**: {字体名 + 字符特征}

**Scale rationale**: {为什么 H1 是这么大 / 正文是这么小 / 行距怎么定的}

## Layout

**Spacing scale**: {如 "4px-based scale，常用 8/16/24/32"}

**Common layouts**:
- 首页：{...}
- 内容列表页：{...}
- 详情页：{...}

**Breakpoints**: {如 "sm 640 / md 768 / lg 1024 / xl 1280"}

## Elevation & Depth

**Level**: {flat / soft / layered / deep}

{描述阴影策略：哪些组件用阴影、哪些场景增层、深色模式下如何处理}

- `elevation.none` —— {应用场景}
- `elevation.sm` —— {应用场景}
- `elevation.md` —— {应用场景}

## Shapes

**Overall sharpness**: {sharp / rounded / very rounded / pill}

**Border philosophy**: {无边框 / 细线 1px / 粗线 / 装饰边框}

**Visual density**: {紧凑 / 标准 / 宽松}

{形状语言一句话总结，如 "圆角统一 4-8px，边框 1px hairline，没有装饰性形状"}

## Components

{每个 YAML 里定义的组件，配一段用法说明}

### button-primary
{用法：什么场景用 / 一个页面最多几个 / 不要和谁混用}

### button-secondary
{...}

### card
{...}

### input-text
{...}

### badge
{...}

## Do's and Don'ts

### Do's
- ✅ {应该做的具体规则}
- ✅ ...

### Don'ts
- ❌ {绝对不做的具体规则}
- ❌ ...

---

## Motion & Animation

**Level**: {无 / 微 / 适度 / 丰富}

**Typical scenes**:
- **Button hover**: {如 "200ms background-color 过渡"}
- **Page transition**: {如 "极轻 fade-in 150ms"}
- **Scroll-in**: {如 "不做" 或 "卡片 fade-up 进入"}
- **Hero animation**: {...}

**Constraints**: {如 "支持 prefers-reduced-motion，开启时关闭所有 transform"}

## Responsiveness

**Approach**: mobile-first

**Mobile simplifications**:
- 导航: {如 "顶部水平 → 全屏抽屉"}
- Hero: {...}
- 多列网格: {...}
- 字号: {...}

## Accessibility

**WCAG target**: AA

**Color contrast**: 正文 ≥ 4.5:1，标题 ≥ 3:1（YAML 里的 primary/on-primary 通过 lint 检查）

**Keyboard navigation**: 全覆盖

**Screen reader**: 语义化标签 + 关键交互 aria-label

**Other**: {如 prefers-reduced-motion 支持 / 高对比度模式}

## UI Framework Considerations

**Requirements**:
- {诉求 1，如 "轻量、可自由 restyle"}
- {诉求 2，如 "原生 a11y 支持"}
- {诉求 3}

**Candidate libraries**:
- **{Library 1}** —— {为什么合适}
- **{Library 2}** —— {...}
- **{Library 3}**（备选）—— {...}

最终选择留给 ARCHITECTURE.md，根据完整技术栈决定。

## References & Inspiration

**Reference sites**:
- [{Site 1}]({URL}) —— {捕捉到的视觉特征}
- [{Site 2}]({URL}) —— {...}

**User-provided inspiration**: {截图描述 / 文字 vibe / 用户提到的具体细节}
