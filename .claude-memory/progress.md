# 進度與待辦

_最後更新：2026-05-06（公司筆電）_

## 待處理

### ⚠️ Discord Role 命名衝突（bot @mention 失效）
- **狀態**：已診斷，未修復
- **問題**：Discord 伺服器有四個 role 與 bot 同名（cartman / stan / kyle / kenny），導致打 @cartman 只能選到 role 而非 bot user，OpenAB 不回應
- **確認方式**：API 抓訊息皆為 `<@&ROLE_ID>`，從未出現 `<@USER_ID>`
- **修法**：Discord 伺服器設定 → 身分組，把這四個 role 刪掉或改名（如 `cartman-role`）
- **cartman bot user ID**：`1493964839079641118`（可用於測試原始 mention：`<@1493964839079641118>`）
- **斯坦/凱爾/肯尼**：同理，需找到各自的 bot user ID 並確認 role 不衝突

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
- [x] **openab run -c 語法修正 + image 更新**（2026-05-06）
  - `latest` image 升至 0.8.3-beta.3，正式棄用 positional arg，改為 `-c` flag
  - `docker-compose.yml` entrypoint 已更新：`openab run -c /etc/openab/config.toml`
  - 同時修正 ACP protocolVersion 不相容問題（舊 image 送字串，新 Claude Code 2.1.119 期望數字）
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
