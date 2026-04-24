# 進度與待辦

_最後更新：2026-04-24_

## 進行中

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
- [x] **OpenAB 0.8.x 升級對應**（2026-04-24）
  - entrypoint 改為 `openab run -c`（breaking change in 0.8.1-beta.4）
  - 四個 config.toml 改為 `multibot-mentions`，多 bot 同時回應問題解決
- [x] **Figma MCP + Jira MCP 整合**（2026-04-24）
  - `figma-developer-mcp` + `@sooperset/mcp-atlassian` 預裝於 image
  - `scripts/setup-mcp.sh`：容器啟動時從 env vars 動態生成 MCP 設定
  - Figma → Jira 工作流寫入 stan / kyle / cartman 的 CLAUDE.md
