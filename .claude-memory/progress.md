# 進度與待辦

_最後更新：2026-05-06（公司筆電）_

## 待處理

### ⚠️ Discord Role 命名衝突（bot @mention 失效）
- **狀態**：已診斷，未修復
- **問題**：Discord 伺服器有四個 role 與 bot 同名（cartman / stan / kyle / kenny），導致打 @cartman 只能選到 role 而非 bot user，OpenAB 不回應
- **確認方式**：API 抓頻道訊息皆為 `<@&ROLE_ID>`，從未出現 `<@USER_ID>`
- **修法**：Discord 伺服器設定 → 身分組，把四個 role 刪掉或改名（如 `cartman-role`）
- **bot user ID 速查**：
  - cartman: `1493964839079641118`
  - Stan: `1494154472509800578`
  - Kyle: `1494156557468962987`
  - Kenny: `1494185596384575651`
- **測試方式**（改完 role 後）：打 @cartman，選到 bot（非 role）→ 送出 → 看 log 有沒有 `processing`

### 清理 RUST_LOG=debug
- cartman 和 kyle 的 `RUST_LOG=debug` 還在 docker-compose.yml，是診斷用的，確認 bot 正常後移除

### 安裝 MemPalace MCP（待測試）
- **狀態**：已整合進 Dockerfile 和 entrypoint，但尚未驗證功能
- **entrypoint** 已加 `mempalace init /palace --yes 2>/dev/null || true`
- **volume** `/palace` 掛載到各容器

## 已完成（2026-05-06）

- [x] **OpenAB image 升級 + entrypoint 語法修正**
  - `latest` image 升至 0.8.3-beta.3，ACP protocolVersion 不相容問題修正（舊送字串，新 Claude Code 2.1.119 期望數字）
  - `docker-compose.yml` entrypoint 改為 `openab run -c /etc/openab/config.toml`（新版 breaking change）
  - 四個容器目前 healthy，Discord 連線正常

## 已完成（2026-04-27）

- [x] **Stan/Kyle/Kenny 無回應根本原因診斷**：bot 未正規 OAuth2 邀請進 server
- [x] **補邀請三個 bot**（OAuth2 連結）
  - Stan: `1494154472509800578`
  - Kyle: `1494156557468962987`
  - Kenny: `1494185596384575651`
- [x] **`allow_user_messages` 三個值行為搞清楚**：
  - `mentions`：只要有直接 @mention 就回
  - `involved`：需 bot 曾在 thread 發過言才回
  - `multibot-mentions`：多 bot 環境下 thread 內仍需 @mention

## 已完成（2026-04-26）

- [x] **MemPalace MCP 整合**（entrypoint + volume）
- [x] **PR #2 merge 到 master**（SHA: e98f4e8）
- [x] **Discord bot 邀請問題解決**（Message Content Intent 開啟）
- [x] **docs/new-agent-sop.md 更新**
- [x] **Stan 的 RUST_LOG=debug 移除**
- [x] **setup-mcp.sh CRLF 問題修正**

## 已完成（2026-04-24）

- [x] 四個南方公園角色設定（cartman / stan / kyle / kenny）
- [x] Dockerfile + docker-compose.yml 完整設定
- [x] 各角色 Claude Code 認證（`claude login`）
- [x] multibot-mentions 啟用
- [x] Figma MCP + Jira MCP 整合
- [x] .claude-memory/ 跨機器記憶同步

## 下次上班從這裡繼續

1. **[第一件事]** Discord 伺服器設定 → 身分組，把 cartman / stan / kyle / kenny 四個 role 改名或刪除
2. **[測試]** 在頻道打 @cartman → 選 bot（非 role）→ 確認有回應
3. **[清理]** 確認正常後移除 docker-compose.yml 裡的 `RUST_LOG=debug`
