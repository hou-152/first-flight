# 建站元技能 · First Flight ✈️

> **用规格文档把网站从 0 到 1 规划清楚，再交给 AI 分阶段实现。**
> 一套帮你从 0 到 1 把网站搭起来、再用 phase 管理把开发节奏抓在手里的 AI 协作流程。

> **本仓库是 `candobear/first-flight` v0.3.2 的个人使用副本**（作者 Jason Ng / CandoBear），含本地增强：Step 0 问题定义 `first-flight-grill`、phases 的 PR Readiness Gate 等。**安装看 [INSTALL.md](INSTALL.md)**；下文安装章节沿用上游说明，只作参考。内容版权归原作者所有。

「**建站元技能**」是一个帮普通人和 AI 协作做产品级网站的 plugin。当前包含一套核心工作流 **First Flight**——从 0 到 1 把新网站搭建出来。

> 📐 **命名说明**：「建站元技能」是产品名（对外展示）；**First Flight** 是当前工作流的名字（这套从 0 到 1 的 spec-driven 流程）；`first-flight` 是稳定的机器 ID（plugin / skill 标识，不会随展示名变化）。下文如果出现 "First Flight"，指的就是这套工作流本身。

First Flight 分两类文档：

- **长期文档**（项目根，跨迭代共用，写一次基本不动）：BRIEF / DESIGN / ARCHITECTURE / AGENTS
- **迭代产物**（`iterations/v{N}-{slug}/`，每次迭代独立）：PRD / CONTENT（仅 v1）/ `.plan/` 工作目录

首次开发走完整 7 步（生成全部文档 + 实施 v1-launch）。后续迭代只走 2 步（新 PRD + 新 phases），长期文档不动。

```
═══ 首次开发（每个新项目一次）═════════════════════════════════════
BRIEF ──► PRD ──► DESIGN ──► ARCHITECTURE ──► CONTENT ──► AGENTS ──► phases
                                                                    └─ 写到 iterations/v1-launch/.plan/

═══ 后续迭代（v2 / v3 / ...，每次新功能或重构）═══════════════════
PRD（迭代版）──► phases
└─ 写到 iterations/v{N}-{slug}/
   长期文档（BRIEF/DESIGN/ARCHITECTURE/AGENTS）不动，CONTENT 也不再写
```

兼容 [OpenAI Codex](https://openai.com/codex)、[Claude Code](https://claude.com/code)、[Claude Cowork](https://claude.ai)。这三个入口都用同一份 skills 源码。

---

## 安装

### OpenAI Codex

First Flight 提供 Codex plugin manifest：`.codex-plugin/plugin.json`，核心 skills 在 `skills/`。

> **为什么不用 Codex 自带的"添加插件市场" UI？**
> 那个弹窗走的是裸 `git clone`。装我们这种私有仓库只有两条路：用 SSH URL（必须先把 SSH key 加到 GitHub）或者 HTTPS URL（会被要求 Personal Access Token）。两种都门槛偏高。下面这套用 `gh repo clone` 走 GitHub CLI 已存的 OAuth 凭据，**不需要 SSH key 也不需要 PAT**。

#### Step 1. 克隆 + 运行安装脚本

```bash
mkdir -p ~/.candobear/plugins
gh repo clone candobear/first-flight ~/.candobear/plugins/first-flight
~/.candobear/plugins/first-flight/script/install-codex.sh
```

前置条件：先装好 [GitHub CLI](https://cli.github.com) 并执行 `gh auth login` 登录，账号要对 `candobear` 这个 org 有访问权限。

脚本会先运行卸载流程，移除当前和旧市场名下的 First Flight 条目 / cache，再把本地这份检出全新注册到 `~/.agents/plugins/marketplace.json`。

#### Step 2. 在 Codex 里手动激活

脚本只是"让 Codex 看得见这个插件市场"，真正启用还需要进 UI 走一遍：

1. **重启 Codex**——`marketplace.json` 是启动时读的，不重启看不到新市场
2. 打开插件管理界面，在插件市场列表里找到 **CandoBear AgentLab**（脚本注册的市场名）
3. 进入该市场，找到 **建站元技能·First Flight**（机器 ID 是 `first-flight`），点击安装 / 启用

启用后任意一句"我想做一个网站"就能触发流程。

#### 更新

仓库里有新内容时，进入本地检出 `git pull` 即可。skills 文件是 Codex 启动时从 marketplace 路径复制到 cache 的，所以拉新代码后**重新跑一次 install 脚本**（它会先卸载旧注册和旧 cache，再全新注册）再重启 Codex 才能生效：

```bash
cd ~/.candobear/plugins/first-flight && git pull
./script/install-codex.sh
```

#### 卸载

```bash
~/.candobear/plugins/first-flight/script/uninstall-codex.sh
```

只会从 Codex marketplace 反注册，并移走当前和旧市场名下的插件缓存——本地的 repo 检出不会被动，需要的话自己删除 `~/.candobear/plugins/first-flight`。

### Claude Code

使用终端进行安装，安装前，务必先确保你的 Claude 已经登录了你的 GitHub 账号，并且已经授权了 `candobear` 这个 org 的访问权限。

```
/plugin marketplace add candobear/first-flight
/plugin install first-flight@candobear
/reload-plugins  
```

装完后任意一句"我想做一个网站"就能触发流程，或者使用明确的 `/first-flight` 命令。

#### 更新

```
/plugin marketplace update candobear  
/reload-plugins  
```

### Claude Cowork

Cowork 在桌面 / Web UI 里走图形化安装流程：

1. 打开 **Customize → Plugin → Browse Plugins**
2. 在弹窗里粘贴仓库地址：

   ```
   https://github.com/candobear/first-flight
   ```

3. 如果你之前已经在 Claude 里授权过 GitHub 访问当前 workspace，会直接拉取并安装；如果没有，按提示完成 GitHub 授权后**回到这一步重新粘贴地址**

安装后 7 个 skill 一次性就绪。任意一句"我想做一个网站"就能触发流程，或者使用明确的 `/first-flight` 命令。

> 私有仓库 / 组织仓库：确保你的 Claude workspace 已经被授权能访问 `candobear` 这个 GitHub 账号下的仓库。


#### 更新

找到下面的路径：

> Customize → Personal Plugin → Browse Plugins → Plugins → First Flight

然后点击 first-flight 右侧的「...」，点击 「Check for Updates」，建议多点击几次，因为可能会有缓存。

更新完市场后，回到插件里找到 first-flight ，在详情页里点击 update 按钮，更新插件。

---

## 使用方式

### Spec 阶段：交互模式（默认）

通过对话依次走 6 步。每步 skill 引导你回答问题，每步完成都能停下来检查。适合不太确定细节、希望被引导思考。

```
你：我想做一个个人作品集网站
AI：[启动 first-flight] 先做第 1 步 BRIEF...
... [6 步对话] ...
AI：6 份文档已生成，可以开始写代码了
```

### Spec 阶段：Batch 模式（一次性骨架）

你给一段对项目的描述，AI 一次性生成 6 份带 `{{TODO}}` 标注的初稿骨架，你用 IDE 自己填写。适合已经知道自己要什么、习惯边写边想。

```
你：用 first-flight 给我一份个人作品集的骨架，我自己填
AI：[batch 模式] 给我一段项目描述就行
你：[一段描述]
AI：[生成 6 份带 TODO 标注的骨架]
```

### 开发实施阶段：Phase 管理（自动触发）

Spec 文档完成后开始写代码时，AI 读完 AGENTS.md 会自动触发 `first-flight-phases` skill 来管理复杂开发任务：

```
你：好了，开始把首页做出来
AI：[识别到 ≥ 5 步骤 + 跨多文件 → 触发 phases skill]
    先建 .plan/plan.md + 拆 phase 子文档，给你看一下整体计划...
    [用户确认]
    [开始 phase 01 Section A → AI 自测 → 你验收 → commit]
    [开始 phase 01 Section B → ...]
```

phases skill 会：
- 强制每个 phase 完成停下让你验收
- 用状态符号（`[ ] [~] [x] [-] [!]`）跟踪每个任务
- 完成必须附 evidence（文件:行号 / commit hash）
- AI 不能自行跳过任务、不能自行 commit
- 大 phase 拆 Section，每段 5 分钟内可验收

**首次开发和后续新功能都用同一套**——所以即使 First Flight 的前 6 个 spec skill 是 0→1 一次性的，phases skill 让你能反复用同一个 plugin 管理任何复杂改动。

---

## 长期文档（项目根，跨迭代共用，写一次基本不动）

| 文档 | 内容 | 字数 |
|---|---|---|
| BRIEF.md | 项目纲领（本质、用户、价值、边界） | 200-400 |
| DESIGN.md | 视觉与 UX（[Google DESIGN.md 标准](https://github.com/google-labs-code/design.md) + 扩展） | 2000-4000 |
| ARCHITECTURE.md | 技术栈 + 代码组织 + 部署 | 2000-3000 |
| AGENTS.md + CLAUDE.md | AI 入口文档（含 Spec Sync 分类机制） | ~2000 |

**DESIGN.md 标准合规**：可以用 `npx @google/design.md lint DESIGN.md` 校验，用 `npx @google/design.md export --format css-tailwind DESIGN.md > theme.css` 直接导出 Tailwind v4 theme。

## 迭代产物（iterations/v{N}-{slug}/，每次迭代独立目录）

| 文件 | 内容 | 何时生成 |
|---|---|---|
| `iterations/v1-launch/PRD.md` | 首版功能 + 信息架构 + 目标 | 首次开发 |
| `iterations/v1-launch/CONTENT.md` | 首版内容槽（📝/🤖/📦） | **仅首次**——迭代时不再生成 |
| `iterations/v1-launch/.plan/` | 首版的 plan + phases 工作目录 | 首次实施时 |
| `iterations/v2-{slug}/PRD.md` | 第二轮迭代的需求 | 后续迭代 |
| `iterations/v2-{slug}/.plan/` | 第二轮迭代的实施工作目录 | 后续迭代实施时 |

**关键设计**：内容（CONTENT.md）只在首次写——后续迭代时新内容应由 CMS / JSON / API 等管理。BRIEF/DESIGN/ARCHITECTURE/AGENTS 这些长期文档不会因为新迭代而被重写。

## 开发实施：Phase 管理（反复使用）

任何迭代（首次或后续）的实施都由 `first-flight-phases` skill 管理：

- 改动 ≥ 5 步骤 / 跨多文件 / 跨多次会话 / 新功能 / 重构 → 必须用 phases
- **强制 AI 边做边更新进度**，每个 phase 完成停下让用户验收
- plan + phases 写到**当前迭代目录**的 `.plan/`

---

## 设计原则

1. **Spec 阶段 0 到 1 only** — 前 6 个 sub-skill 不处理已有项目迭代
2. **Phase 阶段反复使用** — phases sub-skill 不受 0→1 限制，首次开发 + 后续迭代 + 重构都用同一套
3. **Spec-driven** — 只产出 spec，代码留给用户复制 spec 到项目后让 AI 写
4. **路径 A / B 分流** — 每个子 skill 都识别用户经验度，给对应节奏
5. **预览再写文件** — 所有文档先在对话里展示，确认后才写
6. **每步可停** — 子 skill 写完文件会问"接着做吗"
7. **不越界** — BRIEF 不写功能、PRD 不写视觉、DESIGN 不写代码
8. **Spec Sync** — 后续开发改了代码也要同步回 spec（AGENTS.md 里有规则）
9. **Phase 强制慢** — 复杂开发不允许 AI 一口气做完，每个 phase 完成后停下让用户验收

---

## 仓库结构

```
first-flight/
├── README.md                          ← 你现在看的
├── AGENTS.md                          ← Codex / Claude 协作入口
├── LICENSE                            ← MIT
├── .codex-plugin/                     ← Codex plugin 元数据
│   ├── assets/
│   │   ├── icon.svg
│   │   └── logo.svg
│   └── plugin.json
├── .claude-plugin/                    ← Claude Code plugin 元数据
│   ├── marketplace.json
│   └── plugin.json
├── script/                            ← Codex 安装 / 卸载脚本
│   ├── install-codex.sh
│   └── uninstall-codex.sh
└── skills/                            ← 单一 source of truth
    ├── first-flight/                  父 skill（编排）
    ├── first-flight-brief/            Spec 阶段 1
    ├── first-flight-prd/              Spec 阶段 2
    ├── first-flight-design/           Spec 阶段 3
    ├── first-flight-architecture/     Spec 阶段 4
    ├── first-flight-content/          Spec 阶段 5
    ├── first-flight-agents/           Spec 阶段 6
    └── first-flight-phases/           开发实施阶段（反复使用）
```

**单一 source 设计**：所有 skill 内容只放在 `skills/`。三种入口（Codex / Claude Code / Cowork）都引用同一份内容：
- Codex：`.codex-plugin/plugin.json` 引用 `./skills/`
- Claude Code 和 Cowork：`.claude-plugin/marketplace.json` 引用 `./skills/*`

修改 skill 只需要改 `skills/` 一处，三个入口同步生效。

---

© 2026 Jason Ng & CandoBear
