# 專案：南方公園開發團隊（OpenAB）

## 是什麼
基於 OpenAB（Rust ACP harness）的 Discord AI 開發團隊。四個角色各自是 Docker 容器，透過 OpenAB 橋接 Discord 和 Claude Code。

## 架構
- OpenAB + Claude Code + Discord bot，每個角色一個容器
- 容器 image：`ghcr.io/openabdev/openab:latest` + 自訂 Dockerfile
- MCP：Figma Developer MCP + Atlassian MCP（容器啟動時由 `setup-mcp.sh` 動態生成 `settings.local.json`）
- Git repo：`chiang2240/OpenAB`，主線 `master`，工作 branch `claude/review-adapt-code-LxTfO`

## 角色
| 角色 | 容器名 | 職責 | MCP |
|------|--------|------|-----|
| 👑 卡特曼 | cartman | 全端工程師 | Figma + Jira |
| 🎿 斯坦 | stan | 前端工程師 | Figma |
| 🧢 凱爾 | kyle | 後端工程師 | Jira |
| 🧡 肯尼 | kenny | 維運助手 | — |

## 重要檔案
- `Dockerfile` — 安裝 Node.js、Claude Code、MCP 套件
- `docker-compose.yml` — 四個服務 + env vars
- `scripts/setup-mcp.sh` — 生成 `.claude/settings.local.json`
- `agents/<name>/config.toml` — OpenAB 設定（Discord token、channel、agent command）
- `agents/<name>/CLAUDE.md` — 角色個性 + 工作流程
- `.env` — 所有 token（不進 git）
- `TODO.md` — 待辦事項（最新狀態看這裡）

## 環境變數（.env）
- `DISCORD_BOT_TOKEN_<NAME>` — 各角色 Discord bot token
- `CHANNEL_GENERAL` — Discord 頻道 ID
- `GIT_EMAIL` — commit 信箱
- `FIGMA_API_KEY` — Figma Personal Access Token
- `JIRA_URL` / `JIRA_USERNAME` / `JIRA_API_TOKEN` / `JIRA_PROJECT_KEY`

## 常用指令
```bash
docker compose up -d --build    # 啟動
docker compose logs -f cartman  # 看 log
docker exec -it cartman claude login  # 角色登入
```
