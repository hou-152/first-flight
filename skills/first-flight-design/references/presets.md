# 预设套件库

8 个开箱即用的设计套件，每个对齐 [Google DESIGN.md 标准](https://github.com/google-labs-code/design.md)。

每个预设含：色板方向 + 字体方向 + 间距 / 圆角 / 阴影 / 形状 + 组件形态 + 动效尺度 + Typical Do's & Don'ts + 推荐 UI 库。

用法：用户选 1 个作为起点，可叠加调整（"现代极简 + 友好色彩"）。

---

## 1. 现代极简（Modern Minimal）

> 偏冷、克制、信息为先。最常见的 B2B SaaS 风格。

- **灵感站**：Linear, Vercel, Stripe, Cal.com
- **气质关键词**：现代、冷静、清晰、专业
- **色板方向**：
  - 主色：偏冷的单色调（蓝 / 灰 / 紫），如 #2563EB / #6366F1 / #0F172A
  - 中性色：冷调灰阶
  - 强调色：用得克制
- **字体方向**：
  - 标题：几何感 sans-serif（Inter / Geist / Söhne）
  - 正文：同族 sans
  - 字号 base：14-15px（紧凑）
- **间距/圆角**：rounded `sm: 4px / md: 8px`，组件圆角小
- **Elevation level**：soft（极轻阴影 + 1px 边框分层）
- **Shape language**：sharp（圆角 0-8px，hairline 边框）
- **动效**：微（hover 200-300ms fade）
- **组件形态**：
  - 按钮：方形 + 小圆角 + 实色 / 描边
  - 卡片：极轻阴影 / 1px 边框 / 无装饰
  - 表单：清晰边框 + focus ring
- **Typical Do's**：
  - ✅ 大量数据用 mono 字体提升可读性
  - ✅ 一个 accent color 贯穿到底，不要多个
  - ✅ Dark mode 一等公民
- **Typical Don'ts**：
  - ❌ 不要渐变背景
  - ❌ 不要 stock 照片
  - ❌ 不要装饰性插画
- **推荐 UI 库**：shadcn/ui, Park UI, Radix Themes

---

## 2. 友好可爱（Friendly & Approachable）

> 圆润、温暖、对小白友好。消费类 SaaS 和教育类常用。

- **灵感站**：Duolingo, Notion (early), Linktree, Pitch
- **气质关键词**：友好、温暖、轻松、邀请感
- **色板方向**：
  - 主色：明亮饱和（橙 / 粉 / 蓝绿），如 #FF6B6B / #FFA94D / #51CF66
  - 中性色：暖调灰阶
  - 强调色：多色组合可行
- **字体方向**：
  - 标题：圆润 sans（DM Sans / Nunito / Quicksand / Plus Jakarta Sans）
  - 正文：humanist sans
  - 字号 base：16px+
- **间距/圆角**：rounded `sm: 8px / md: 12px / lg: 20px`，组件大圆角
- **Elevation level**：layered（多层阴影 sm/md/lg，明显立体感）
- **Shape language**：very rounded（圆角 12-24px，按钮 pill 也可以）
- **动效**：适度（hover 微抬 / spring 弹性 / 入场 slide-up）
- **组件形态**：
  - 按钮：大圆角 + 实色 + 偶尔 emoji 点缀
  - 卡片：大圆角 + 柔和阴影 / 渐变背景
  - 表单：圆角输入 + 友好占位文字
- **Typical Do's**：
  - ✅ Hover 用微抬（translateY -2px）+ 阴影加深
  - ✅ Emoji 可以作为内容装饰（不滥用）
  - ✅ 多彩 illustration 作为大区块视觉锚
- **Typical Don'ts**：
  - ❌ 不要 monospace 字体作为主要字体
  - ❌ 不要硬边、纯白背景
  - ❌ 不要 dark-mode-only
- **推荐 UI 库**：Mantine, Chakra UI, NextUI

---

## 3. 复古怀旧（Retro / Vintage）

> 暖色调、有质感、像翻一本老画册。

- **灵感站**：Stripe Press, Werner.dev, Are.na, 70s/80s 设计博客
- **气质关键词**：怀旧、温暖、有故事、慢
- **色板方向**：
  - 主色：暖色（暗红 / 橙 / 棕 / 芥末黄），如 #C44536 / #D4842B / #6F4E37
  - 中性色：米黄 / 牛皮纸（#F5F0E1 / #E8DDC8）
  - 强调色：墨绿、深紫等深沉
- **字体方向**：
  - 标题：serif（IBM Plex Serif / Tiempos / Old Standard TT）
  - 正文：humanist serif 或带衬线 sans
  - 代码：monospace（JetBrains Mono / IBM Plex Mono）
- **间距/圆角**：rounded `none: 0 / sm: 2px`
- **Elevation level**：flat（几乎无阴影，靠排版分层）
- **Shape language**：sharp（圆角 0-2px，可有装饰性边框 / 双层边框）
- **动效**：几乎无（仅极轻 fade）
- **组件形态**：
  - 按钮：方形 + 描边 / 双层边框
  - 卡片：硬边 / 装饰性边框 / 木刻插画感
  - 表单：方框 + 下划线
- **Typical Do's**：
  - ✅ 装饰性细节（小图标 / 分割线 / 印章感）
  - ✅ 衬线和等宽搭配
  - ✅ 米黄背景而不是纯白
- **Typical Don'ts**：
  - ❌ 不要荧光色 / neon
  - ❌ 不要 glassmorphism / 渐变
  - ❌ 不要 hero 视频
- **推荐 UI 库**：自定义为主 + Tailwind / Pico CSS

---

## 4. 东京 / 日本风（Tokyo / Japanese Minimal）

> 极致克制、留白为主、精确到像素。

- **灵感站**：Studio Yorktown, MUJI, IDEA Magazine, Tokujin Yoshioka
- **气质关键词**：精确、留白、克制、有意境
- **色板方向**：
  - 主色：纯黑 / 深灰 / 深红（如 #1A1A1A / #C03A2B）
  - 中性色：纯白 + 极少灰阶
  - 强调色：一抹饱和点缀（≤ 1 个）
- **字体方向**：
  - 标题：细体 sans（Noto Sans / Inter Thin / Söhne Leicht）
  - 正文：humanist sans
  - 日文：Noto Sans JP / Hiragino Sans
  - 字号尺度：标题大、正文小、对比强
- **间距/圆角**：rounded `none: 0`（一律方形）
- **Elevation level**：flat（绝对无阴影）
- **Shape language**：sharp（圆角 0，hairline 边框可选）
- **动效**：精确慢动作（400-600ms ease，幅度极小）
- **组件形态**：
  - 按钮：无背景 / 细线描边 / 大量留白
  - 卡片：无边框 / 纯排版 / 严密网格
  - 表单：下划线 + 细字
- **Typical Do's**：
  - ✅ 网格对齐到像素
  - ✅ 大留白（margin/padding 是设计本身）
  - ✅ 文本左对齐，避免居中
- **Typical Don'ts**：
  - ❌ 不要圆角（任何地方）
  - ❌ 不要阴影
  - ❌ 不要彩色装饰
  - ❌ 不要 hero 动画
- **推荐 UI 库**：自定义为主 + Tailwind，或 Radix Primitives + 全自定义样式

---

## 5. 极客（Geek / Developer）

> 暗色优先、终端感、性能为美。

- **灵感站**：Bun.sh, HTMX, Tailwind, GitHub, Vercel (dark)
- **气质关键词**：技术、精准、暗黑、有信号灯感
- **色板方向**：
  - 背景：深色（深灰 / 深蓝 / 深紫），如 #0A0A0A / #0F172A
  - 主色：neon 强调（青、紫、绿），如 #00FFCC / #A78BFA / #4ADE80
  - 中性色：冷调深灰阶
- **字体方向**：
  - 标题：几何 sans / 偶尔 monospace
  - 正文：sans
  - 代码：JetBrains Mono / Fira Code / Berkeley Mono（占比大）
- **间距/圆角**：rounded `sm: 4px / md: 6px`
- **Elevation level**：deep（带 glow / 内阴影 / 浮起感）
- **Shape language**：sharp（圆角 0-6px，1px 边框 + 偶尔 glow）
- **动效**：精准（hover 即时 / terminal cursor 闪烁 / 代码块复制反馈）
- **组件形态**：
  - 按钮：方形 + 紧凑 + monospace
  - 卡片：1px border + 深背景 + 偶尔 glow
  - 代码块：大、清晰、带 toolbar + 行号
- **Typical Do's**：
  - ✅ Dark mode 默认且为主
  - ✅ 代码块视觉占有大权重
  - ✅ 可以用 ANSI 配色 / terminal 字符装饰
  - ✅ 数字 / 状态指示用 neon 高亮
- **Typical Don'ts**：
  - ❌ 不要 pastel 配色
  - ❌ 不要 illustration
  - ❌ 不要 hero 视频（除了 terminal demo）
- **推荐 UI 库**：shadcn/ui (dark), Tremor (data viz), 自定义 + Tailwind

---

## 6. 杂志阅读（Editorial / Magazine）

> 长文为主，serif 标题，慢速阅读。

- **灵感站**：The Verge, Pitchfork, Substack, NYT Opinion, Vox
- **气质关键词**：阅读、深度、有重量、editorial
- **色板方向**：
  - 背景：白色 / 米白
  - 主色：黑 / 深棕 + 一个 accent（红 / 蓝 / 绿）
  - 中性色：暖调灰阶
- **字体方向**：
  - 标题：高质感 serif（Tiempos / GT Sectra / Source Serif）
  - 正文：可读 humanist sans 或 transitional serif
  - 字号尺度：标题非常大（H1 60-80px），正文 17-20px
  - 行距宽松（1.6-1.8）
- **间距/圆角**：rounded `none: 0 / sm: 2px`
- **Elevation level**：flat
- **Shape language**：sharp（圆角 0-2px，hairline 边框）
- **动效**：极轻（仅滚动阅读进度条 / 章节进入 fade）
- **组件形态**：
  - 按钮：低调（链接化或描边）
  - 卡片：栏目化 / 报纸感
  - 文章：左对齐、max-width 720px / 居中阅读栏
- **Typical Do's**：
  - ✅ 用衬线建立 editorial 节奏
  - ✅ 大标题 + 小正文的强对比尺度
  - ✅ pull quote 作为视觉锚
- **Typical Don'ts**：
  - ❌ 不要圆角卡片
  - ❌ 不要荧光色 accent
  - ❌ 不要 carousel
  - ❌ 不要 hero 动画
- **推荐 UI 库**：自定义为主，Tailwind Typography 必备

---

## 7. 变重 Brutalist（Brutal & Bold）

> 大胆、强对比、不讨好。

- **灵感站**：Pentagram, Awwwards Brutalism, Bloomberg Businessweek, Gucci
- **气质关键词**：大胆、强势、有态度、不温和
- **色板方向**：
  - 强对比（黑 + 白 + 1 个鲜艳色），如 #000 / #FFF / #FF3D00
  - 极少灰阶
  - 大胆撞色
- **字体方向**：
  - 标题：极大 + 强力 sans（Druk / Helvetica Bold / Founders Grotesk Bold）
  - 正文：朴素 sans
  - 字号反差极大（H1 100px+ vs body 14px）
- **间距/圆角**：rounded `none: 0`
- **Elevation level**：flat（用色块代替阴影分层）
- **Shape language**：sharp（圆角 0，粗线 2-4px 边框）
- **动效**：突然显著（不连续切换 / 大幅度 transform / glitch 效果）
- **组件形态**：
  - 按钮：方形 + 实色 + 大字
  - 卡片：硬边 + 大色块
  - 表单：方框 + 粗边框
- **Typical Do's**：
  - ✅ 字号大胆夸张
  - ✅ 大色块 / 大留白 强对比
  - ✅ 边框粗
- **Typical Don'ts**：
  - ❌ 不要圆角
  - ❌ 不要阴影
  - ❌ 不要"看起来好看"的妥协（brutal 就是 brutal）
- **推荐 UI 库**：自定义为主，Tailwind + 自定义 design tokens

---

## 8. 温和有机（Soft Organic）

> 柔色、圆润、像生活方式品牌。

- **灵感站**：Apple (部分页面), Aesop, Glossier, Headspace, Calm
- **气质关键词**：温柔、有机、平静、 wellness
- **色板方向**：
  - 主色：莫兰迪 / 淡粉 / 沙色，如 #E8DCD0 / #C9A89B / #7B8B7C
  - 中性色：暖调灰、米白
  - 强调色：低饱和
- **字体方向**：
  - 标题：humanist sans 或 transitional serif（Tiempos / Söhne / Beatrice）
  - 正文：humanist sans（Inter / Söhne）
  - 字号宽松
- **间距/圆角**：rounded `sm: 8px / md: 12px / lg: 16px`
- **Elevation level**：soft（极轻柔和阴影 + 大圆角）
- **Shape language**：rounded（圆角 8-16px，无边框或极轻边框）
- **动效**：柔和缓慢（500ms+ ease-in-out，幅度小）
- **组件形态**：
  - 按钮：中圆角 + 柔和填色 / 描边
  - 卡片：柔和阴影 + 圆角 + 留白多
  - 表单：圆角输入 + 柔和 focus
- **Typical Do's**：
  - ✅ 留白多
  - ✅ 阴影柔和（blur 大 / spread 大 / opacity 低）
  - ✅ 圆角统一中等
  - ✅ 摄影素材偏暖、自然光
- **Typical Don'ts**：
  - ❌ 不要纯黑纯白
  - ❌ 不要硬边硬阴影
  - ❌ 不要高饱和荧光
- **推荐 UI 库**：Mantine, Park UI, 自定义 + Tailwind

---

## 预设组合使用

用户可以**叠加**两个预设，比如：
- "现代极简 + 一点温和有机"——结构现代但色调温柔
- "极客 + 杂志阅读"——dev 网站但长文体验也好
- "杂志阅读 + 温和有机"（Linka 示例）——editorial 节奏 + 米色温度

叠加时合并 token 取折中：
- 色板：以第一个预设为基础，融入第二个的色温倾向
- 圆角：取两者的中间值
- 阴影：偏低 level 那个（保守为先）
- 字体：以第一个的方向为主
- Do's & Don'ts：合并两者，冲突时以第一个预设为准

skill 应该理解叠加意图，把核心 token 调和一下。
