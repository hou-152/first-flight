# plan.md 完整示例（Linka 个人作品集首次开发）

延续 First Flight 系列的 Linka 项目。假设用户已完成 6 份 spec 文档（BRIEF/PRD/DESIGN/ARCHITECTURE/CONTENT/AGENTS），现在开始写代码。

---

# Linka 作品集 v1-launch 实施

> 文件位置：`iterations/v1-launch/.plan/plan.md`
> 配套 skill：first-flight-phases
> 本 plan 文档是**稳定航图**，状态跟踪在同目录 `phases/NN-*.md` 里。

## 背景

Linka 的 6 份 spec 已经齐全（BRIEF / PRD / DESIGN / ARCHITECTURE / CONTENT / AGENTS）。Astro 5 + Radix Primitives + Tailwind v4 + Cloudflare Pages 技术栈也定了。现在进入第一次实施——目标是 90 天内通过网站收到 ≥ 5 份认真合作咨询。

不做 phase 管理直接开始写，会出现：作品图加载性能没控、a11y 没覆盖、SEO meta 漏写、Formspree 集成卡住没人发现……所以拆 phase 边做边验。

## 范围

**做：**

- 项目初始化（Astro + Tailwind v4 + Radix + theme.css export）
- 5 个页面实施（首页 / 作品列表 / 作品详情 / 关于 / 联系）
- 联系表单 + Formspree + Turnstile 集成
- 基础 SEO（meta + sitemap + OG image）
- 性能优化（图像 / 字体）+ a11y 校验
- 部署到 Cloudflare Pages

**不做：**

- 博客 / 文章系统（BRIEF 边界明确排除）
- 客户管理后台（BRIEF 边界明确排除）
- 多语言（PRD §7 明确不做）
- 评论 / 互动
- 移动 App

## 阶段总览

| #  | 阶段 slug         | 一句话目标                                  | 状态         |
|----|-------------------|---------------------------------------------|--------------|
| 01 | bootstrap         | 项目初始化 + 基础布局 + 导航                | not started  |
| 02 | home              | 首页（hero + 精选作品 + 简介 + CTA 四区块） | not started  |
| 03 | works             | 作品列表 + 作品详情两个页面                 | not started  |
| 04 | about-contact     | 关于页 + 联系页 + 表单 + Formspree 接入     | not started  |
| 05 | polish-launch     | 性能 + a11y + SEO + 部署                    | not started  |

> 状态值：`not started` / `in progress` / `completed` / `blocked` / `skipped`
>
> 详细任务、evidence、blocker 在各 phase 文档里。

## 关键决策

- **2026-05-19**：先做 bootstrap + 首页（phase 01-02）再做作品页（phase 03）——首页是访客落地最重要的，先做能尽早拿到视觉反馈
- **2026-05-19**：联系表单（phase 04）放在作品页之后——因为表单依赖作品页的"导流到 contact"按钮已经存在
- **2026-05-19**：polish-launch（phase 05）独立一个 phase——不混在功能 phase 里，让性能 / a11y 集中扫一次

## Open Questions

- [ ] Tiempos Headline 字体授权要不要这次实施前买？还是先用 Crimson Pro 替代上线 → 预期在 phase 01 决定
- [ ] 作品详情页的"设计思路"是 MDX 写还是从 Notion 导？→ 预期在 phase 03 决定
- [ ] Linka 邮箱 hi@linka.design 是否已配置好接收 Formspree 转发？→ 预期在 phase 04 解决

## PR Readiness Gate

> 只在本迭代准备交付 / PR / 合并 / 上线前跑；不是每个 phase 都跑。

**状态**：`not started`

- [ ] 原始意图复核：BRIEF / DESIGN / ARCHITECTURE / 当前 PRD / plan.md 已重读，实际完成范围没有偏离
- [ ] 主分支同步：已检查 `git status`；需要 rebase / merge 时已确认目标分支并处理冲突
- [ ] 对抗式 review：已按 reviewer 视角检查需求漏项、scope creep、回归风险、a11y / 性能 / 安全、文档漂移
- [ ] 端到端测试：已手工走首页 → 作品列表 → 作品详情 → 联系表单路径
- [ ] Evidence 汇总：关键文件路径、命令、测试结果、预览链接 / 截图路径已记录
- [ ] 文档同步：PRD / DESIGN / ARCHITECTURE / AGENTS / phase 文档中需要更新的都已同步
- [ ] 静态检查：typecheck / build / design lint / Lighthouse 已跑
- [ ] PR 草稿：Summary / Scope / Validation / Evidence / Risks / Rollback / Open Questions 已准备

**收口记录**：
- 原始意图：
- 实际完成：
- 验证：
- Evidence：
- 风险 / 未决：
- PR 草稿：

## 关联

> 路径相对当前文件 `iterations/v1-launch/.plan/plan.md`：

- 长期文档（项目根）：[BRIEF.md](../../../BRIEF.md) / [DESIGN.md](../../../DESIGN.md) / [ARCHITECTURE.md](../../../ARCHITECTURE.md) / [AGENTS.md](../../../AGENTS.md)
- 当前迭代 PRD：[PRD.md](../PRD.md)
- 首版 CONTENT：[CONTENT.md](../CONTENT.md)
