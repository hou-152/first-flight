# 建站元技能 · First Flight —— 安装

仓库根目录就是插件本体，9 个 skill 在 `skills/`。
来源：CandoBear 私有版 `candobear/first-flight` v0.3.2（作者 Jason Ng）；本副本的本地增强见文末。

## 下载（不用登录 GitHub）

```bash
git clone https://github.com/hou-152/first-flight.git ~/first-flight
```

没装 git 就下压缩包：

```bash
curl -L https://github.com/hou-152/first-flight/archive/refs/heads/main.tar.gz -o first-flight.tar.gz
tar xzf first-flight.tar.gz && mv first-flight-main ~/first-flight
```

## 1. 只要 skills（Codex / Claude Code / DSH / Pi 通用，最省事）

把这 9 个 skill 目录链进共享 skill 目录，宿主自动发现，不用复制：

```bash
mkdir -p ~/.agents/skills
for d in ~/first-flight/skills/*/; do
  ln -sfn "$d" "$HOME/.agents/skills/$(basename "$d")"
done
ls -l ~/.agents/skills/first-flight ~/.agents/skills/first-flight-grill
```

`~/.claude/skills/<name>` 如果已经指向 `../../.agents/skills/<name>`，Claude Code 会跟着同一个真源走，不用再建一遍。
新会话里说「我想做一个网站」即可触发；`first-flight` 是总入口，`first-flight-grill` 是 Step 0 问题定义。

## 2. 装成 Codex 插件（需要插件 UI / 市场入口时）

```bash
~/first-flight/script/install-codex.sh
```

脚本会先把旧注册和旧 cache 移开，再把本目录注册到 `~/.agents/plugins/marketplace.json`（市场名 `candobear-agentlab`）。
插件目录必须在 `$HOME` 下面，别放在 `/tmp`。
然后重启 Codex，在插件 UI 里找到「建站元技能·First Flight」启用。
卸载：`~/first-flight/script/uninstall-codex.sh`。

更新：`cd ~/first-flight && git pull`，再跑一次 install 脚本并重启 Codex（skills 是启动时复制进 cache 的）。

## 3. 检查装好了没

```bash
head -3 ~/.agents/skills/first-flight/SKILL.md          # 应看到 Step 0 / first-flight-grill
head -3 ~/.agents/skills/first-flight-grill/SKILL.md    # 双向钢人论证
```

## 本副本相对上游的差异

- 新增 `first-flight-grill`：Step 0 双向钢人论证，先确认要解决的问题成立，再进 BRIEF。
- `first-flight` 总入口同步为带 Step 0 的 8 步流程（GRIL → BRIEF → PRD → DESIGN → ARCHITECTURE → CONTENT → AGENTS → phases）。
- `first-flight-phases` 增加 PR Readiness Gate（迭代准备交付 / PR / 合并前的收口检查）。
- `first-flight-agents` 改为通用 AI 入口文档（不再只写 Codex / Claude），并加源文档发现与质量门禁。
- `first-flight-architecture` 模板同步到当前版本。

`README.md` 的安装章节沿用上游写法（指向 `candobear/first-flight`），只作参考；装本仓库以本文件为准。

---

内容版权归原作者 Jason Ng（CandoBear）所有。本仓库是其私有版的个人使用副本，不是官方发布。
