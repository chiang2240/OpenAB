# 進度與待辦

_最後更新：2026-04-25 晚（家裡電腦）_

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
- [x] **multibot-mentions 已還原為 mentions**（2026-04-25）
  - 公司電腦曾改為 `multibot-mentions`，但 `latest` image 不支援此值，容器會 crash
  - 已全部改回 `allow_user_messages = "mentions"`
  - 多 bot 搶答問題尚未根本解決，解法見 TODO.md（建議每 bot 獨立頻道）
- [x] **Figma MCP + Jira MCP 整合**（2026-04-24）
  - Dockerfile 預裝 `figma-developer-mcp` + `@aashari/mcp-server-atlassian-jira`
  - `scripts/setup-mcp.sh`：容器啟動時從 env vars 動態生成 `.claude/settings.local.json`
  - Figma → Jira 工作流寫入 stan / kyle / cartman 的 CLAUDE.md
  - Jira env vars：`ATLASSIAN_SITE_NAME` / `ATLASSIAN_USER_EMAIL` / `ATLASSIAN_API_TOKEN`
- [x] **.claude-memory/ 跨機器記憶同步**（2026-04-24）
  - 透過 git 同步工作進度，CLAUDE.md 頂部加讀取提示
- [x] 四個容器目前狀態：全部 healthy（`docker compose ps` 可確認）
- [x] **Dockerfile 補齊（2026-04-25，家裡電腦）**
  - 加回 `python3`、`@google/gemini-cli`、`mempalace`、`ENTRYPOINT []`
  - 公司電腦在做 Figma/Jira 整合時漏掉了這幾項
- [x] **docker-compose.yml 補齊（2026-04-25）**
  - cartman 加 `RUST_LOG=debug`；四個 agent 加 `MEMPALACE_PALACE_PATH=/palace` 與 `palace` volume
- [x] **PR #2 已推送**（branch: `claude/review-adapt-code-LxTfO`）
  - 待 merge 到 master
- [x] **SOP + 跨機器工作流建立（2026-04-25 晚）**
  - CLAUDE.md 加入「上班了」/「下班了」觸發詞與五步 SOP
  - `.claude-memory/feedback.md` 加入跨機器協作規則與懲罰條款
  - 下次上班說「上班了」，Claude 會自動執行 SOP 再開口

## 下次上班從這裡繼續

1. **PR #2 merge**：`https://github.com/chiang2240/OpenAB/pull/2`，確認沒問題後 merge 到 master
2. **多 bot 搶答問題**：目前暫時用 `mentions`，根本解法是每個 bot 獨立頻道（見 TODO.md）
3. **MemPalace MCP**：尚未安裝，需要時再做
4. **Figma / Jira token**：沒有帳號，功能已架好但尚未測試；有帳號後填 `.env` 即可
