> **每次開始工作前，請先讀 `.claude-memory/` 目錄**（`project.md` 架構、`progress.md` 進度、`feedback.md` 偏好）。
> 結束工作後，如有重要進展請更新 `progress.md`。

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
