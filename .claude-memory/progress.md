# 進度與待辦

_最後更新：2026-04-24（公司筆電）_

## 待處理

### openab run -c 語法（等 image 更新）
- **狀態**：刻意暫緩
- **說明**：0.8.1-beta.4 release note 說 `openab run` 改為 `openab run -c <path>`，但 `ghcr.io/openabdev/openab:latest` 實際上還是舊版 binary，改了會 crash
- **待辦**：等 `latest` image 真正更新後，把 `docker-compose.yml` entrypoint 的 `openab run /etc/openab/config.toml` 改為 `openab run -c /etc/openab/config.toml`
- **確認方式**：`docker run --rm ghcr.io/openabdev/openab:latest openab run --help`，若出現 `-c, --config` 旗標即可改

### 安裝 MemPalace MCP
- **狀態**：尚未開始
- **用途**：AI 跨 session 記憶系統
- **步驟**：`pip install mempalace` → `mempalace init` → `claude mcp add mempalace mempalace mcp`
- **注意**：需 Python 3.9+，約 300 MB

## 已完成

- [x] 四個南方公園角色設定（cartman / stan / kyle / kenny）
- [x] Dockerfile + docker-compose.yml 完整設定
- [x] 各角色 Claude Code 認證（`claude login`）
- [x] OpenAB + claude-agent-acp 整合修正
- [x] **multibot-mentions 啟用**（2026-04-24）
  - 四個 config.toml 改為 `multibot-mentions`，多 bot 同時回應問題解決
- [x] **Figma MCP + Jira MCP 整合**（2026-04-24）
  - Dockerfile 預裝 `figma-developer-mcp` + `@aashari/mcp-server-atlassian-jira`
  - `scripts/setup-mcp.sh`：容器啟動時從 env vars 動態生成 `.claude/settings.local.json`
  - Figma → Jira 工作流寫入 stan / kyle / cartman 的 CLAUDE.md
  - Jira env vars：`ATLASSIAN_SITE_NAME` / `ATLASSIAN_USER_EMAIL` / `ATLASSIAN_API_TOKEN`
- [x] **.claude-memory/ 跨機器記憶同步**（2026-04-24）
  - 透過 git 同步工作進度，CLAUDE.md 頂部加讀取提示
- [x] 四個容器目前狀態：全部 healthy（`docker compose ps` 可確認）
