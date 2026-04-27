# 進度與待辦

_最後更新：2026-04-27（公司電腦）_

## 待處理

### 🔴 [高優先] Stan / Kyle / Kenny 無回應問題 — 進度：診斷完畢，修復待確認

**根本原因（已確認）**：
三個 bot 之前沒有透過正規 OAuth2 流程邀請進 server，只是用 token 接上 gateway，所以：
- 可以收 Discord events（有 thread check log）
- 但不出現在 member list / @mention 補全清單
- 使用者無法真正 @mention 它們，`is_mentioned` 永遠 false

**今天做了什麼**：
- 確認 `"mentions"` / `"multibot-mentions"` 兩個模式都是靠 `is_mentioned` 過關
- 在 Discord Developer Portal 用 OAuth2 連結補邀請了三個 bot：
  - Stan: `1494154472509800578`
  - Kyle: `1494156557468962987`
  - Kenny: `1494185596384575651`

**待確認（下次上班第一件事）**：
1. 在 Discord 打 `@`，確認 Kyle/Stan/Kenny 現在有沒有出現在補全清單
2. 如果有 → 選 Kyle 正式 @mention 它，看 log 有沒有出現 `processing`
3. 如果還是沒有 → 可能 OAuth2 邀請沒有成功，或 server 設定有問題

**Kyle 目前 config 狀態（暫時的，待確認後清理）**：
- `allow_user_messages = "mentions"`（原本是 `"multibot-mentions"`）
- `RUST_LOG=debug` 加在 `docker-compose.yml`（診斷用，之後要移除）

**確認修復後要做的清理**：
1. 把四個 bot 的 `allow_user_messages` 統一決定要用 `"mentions"` 還是 `"multibot-mentions"`
   - `"mentions"` 較單純：每個 bot 只回應直接 @mention 它的訊息
   - `"multibot-mentions"` 在 thread 內也需要 @mention，適合多 bot 共用頻道
2. 移除 Kyle 的 `RUST_LOG=debug`（除非要繼續 debug）
3. Cartman 的 `RUST_LOG=debug` 也考慮移除（之前為了 debug 加的）

### openab run -c 語法（等 image 更新）

- **狀態**：刻意暫緩
- **說明**：0.8.1 release note 說 `openab run` 改為 `openab run -c <path>`，但 `ghcr.io/openabdev/openab:latest` 實際上還是舊版 binary
- **待辦**：等 `latest` image 真正更新後改 entrypoint
- **確認方式**：`docker run --rm ghcr.io/openabdev/openab:latest openab run --help`，若出現 `-c, --config` 旗標即可改

## 今日檢討（2026-04-27）

### 做對的事
- 有系統地診斷：從 config → log level → channel type → @mention 認知逐步縮小範圍
- 用 Cartman 做對照組，清楚找出 `bot_owns=true` vs `bot_owns=false` 的差異
- 直接查 Discord API 取得 bot application ID，不繞路

### 做得不夠好
- 診斷過程中沒有及早確認「bot 有沒有在 member list」這個最基本的前提
  - 如果一開始就問使用者「打 @ 有沒有出現 Kyle？」，可以省掉很多 log 分析
- Kyle config 改來改去（`multibot-mentions` → `all`（無效）→ `mentions`），留下髒狀態
- 下班前沒確認 OAuth2 邀請是否真的解決問題就結束了

### 下次上班檢查清單
1. 確認 `@` 補全清單有沒有 Kyle/Stan/Kenny
2. 如果有 → 測試 @mention → 確認回應
3. 如果沒有 → 調查為什麼 OAuth2 邀請沒生效
4. 確認後清理 Kyle config（`allow_user_messages` 和 `RUST_LOG`）

## 已完成（今天 2026-04-27）

- [x] **Stan/Kyle/Kenny 無回應根本原因找到**：bot 未正規 OAuth2 邀請進 server
- [x] **補邀請三個 bot**（OAuth2 連結，效果待確認）
- [x] **`allow_user_messages` 三個值的行為搞清楚**：
  - `mentions`：不管 thread 狀況，只要訊息有 @mention 就回
  - `involved`：需 bot 曾在 thread 留過訊息才回（non-owning bot 等於永遠不回）
  - `multibot-mentions`：需 bot 曾在 thread 留過訊息，且多 bot 環境下需 @mention

## 已完成（2026-04-26）

- [x] **MemPalace MCP 整合**
- [x] **PR #2 已 merge 到 master**（SHA: e98f4e8）
- [x] **multibot-mentions 改版**
- [x] **Discord bot 邀請問題解決**（Message Content Intent 開啟）
- [x] **docs/new-agent-sop.md 更新**
- [x] **Stan 的 RUST_LOG=debug 移除**
- [x] **setup-mcp.sh CRLF 問題修正**

## 下次上班從這裡繼續

1. **[第一件事]** 在 Discord 輸入 `@`，確認三個 bot 有沒有出現
2. **[如果有]** 測試 @mention → 看 Kyle log 有沒有 `processing` → 確認修復
3. **[如果沒有]** 調查 OAuth2 邀請為何沒生效（是否 bot 已在 server？是否有 server 設定擋住？）
4. **Figma / Jira token**：沒有帳號，功能已架好但尚未測試
