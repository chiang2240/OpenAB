> ## 每次對話開始必做（順序不可跳）
>
> 1. `git fetch` — 同步遠端狀態（使用者可能在另一台機器做過事）
> 2. `git log --oneline origin/HEAD -10` 或 `git log --oneline origin/<current-branch> -10` — 確認遠端有無新 commit
> 3. 若遠端比本地新，先 `git pull` 再繼續
> 4. 讀 `.claude-memory/progress.md` — 了解目前進度與待辦
> 5. 讀 `.claude-memory/feedback.md` — 了解協作偏好
>
> **不要假設本地狀態是最新的。使用者在公司電腦和家裡電腦都會工作，每次對話可能換了一台機器。**
>
> 結束工作後更新 `.claude-memory/progress.md`，記下完成了什麼、下次從哪裡繼續。

# 南方公園開發團隊 — 專案概述

## 這是什麼

這是一個基於 OpenAB 的 Discord AI 開發團隊配置專案。每個角色是一個獨立的 Docker 容器，透過 OpenAB 橋接 Discord 和 Claude Code，讓 AI agent 在 Discord 上以南方公園卡通角色的身份與使用者互動。

## 架構

- AI 角色使用 OpenAB（Rust）+ Claude Code，定義在 `agents/` 底下
- 所有容器透過 `docker-compose.yml` 管理
- 環境變數（token、channel ID、MCP token）集中在 `.env`
- 角色的個性和工作規範透過各角色目錄下的 `CLAUDE.md` 設定
- 容器啟動時 `setup-mcp.sh` 從 env vars 生成 `.claude/settings.local.json`（MCP token 不進 git）

## MCP 整合

| MCP | 用途 | 相關角色 |
|-----|------|----------|
| Figma Developer MCP | 讀取設計稿結構（Auto Layout、色票、字型） | 卡特曼、斯坦 |
| Atlassian MCP | 建立/查詢 Jira tickets | 卡特曼、凱爾 |

### 工作流程
Figma 連結貼到 Discord → 斯坦/卡特曼讀取設計規格 → 凱爾/卡特曼建 Jira tickets → 工程師開發

## 目錄結構

```
OpenAB/
├── .env                      ← 環境變數（不進 git）
├── .env.example              ← 環境變數範本
├── Dockerfile                ← 基於官方 OpenAB image + git + Claude Code + MCP
├── docker-compose.yml        ← 所有服務定義
├── scripts/
│   └── setup-mcp.sh          ← 容器啟動時從 env vars 生成 MCP 設定
├── agents/                   ← AI 角色設定
│   ├── cartman/              ← 👑 卡特曼（全端工程師，Figma + Jira）
│   │   ├── config.toml
│   │   └── CLAUDE.md         ← 個性 + 工作流程
│   ├── stan/                 ← 🎿 斯坦（前端工程師，Figma 讀取）
│   ├── kyle/                 ← 🧢 凱爾（後端工程師，Jira 管理）
│   └── kenny/                ← 🧡 肯尼（維運助手）
└── docs/
    └── new-agent-sop.md      ← 新增角色 SOP
```

## 角色清單

| 角色 | 別名 | 職責 | 狀態 |
|------|------|------|------|
| 👑 卡特曼 | cartman | 全端工程師 | 運作中 |
| 🎿 斯坦 | stan | 前端工程師 | 運作中 |
| 🧢 凱爾 | kyle | 後端工程師 | 運作中 |
| 🧡 肯尼 | kenny | 維運助手 | 運作中 |

## 常用操作

- 啟動：`docker compose up -d --build`
- 看 logs：`docker compose logs -f bob`
- 更新 OpenAB：`docker compose build --pull && docker compose up -d`
- 新增角色：參考 `docs/new-agent-sop.md`
- 角色登入：`docker exec -it <name> claude login`

## 開發慣例

### 語言
- 所有文件、註解、commit message 使用繁體中文
- 角色的 CLAUDE.md 全程繁體中文，不使用英文
- 程式碼中的變數名和技術術語可以用英文

### 角色管理
- 每個角色一個獨立目錄在 `agents/<alias>/`
- 角色別名使用英文小寫（cartman, stan, kyle, kenny）
- 新增角色遵循 `docs/new-agent-sop.md`
- 角色的 config.toml 中使用 `${ENV_VAR}` 引用環境變數，實際值放 `.env`

### Docker
- AI 角色使用根目錄的 `Dockerfile`（基於官方 OpenAB image）
- 不要把 token 或密鑰寫死在任何檔案中，一律用環境變數

### 環境變數命名
- Bot token：`DISCORD_BOT_TOKEN_<ALIAS>`（例如 `DISCORD_BOT_TOKEN_BOB`）
- Channel ID：`CHANNEL_<NAME>`（例如 `CHANNEL_GENERAL`）
- 新增變數時同步更新 `.env.example`

### Git
- 修改目標使用英文小寫，多個單字用 `-` 連接
- commit message 格式：`feat/fix/chore: 簡短描述`，可附多行說明
- 推送後到 GitHub 開 PR，不直接 push 到 master

## 注意事項

- 使用者溝通語言為繁體中文
- 每個角色的 `agents/<name>/` 整個目錄會掛載為容器的 `/home/agent`
- 角色工作產出在 `agents/<name>/projects/`（被 gitignore）
- `memory.md` 是動態記憶，每個環境不同（被 gitignore）
