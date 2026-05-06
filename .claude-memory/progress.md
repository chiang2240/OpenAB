# 進度與待辦

_最後更新：2026-05-06 晚（家裡電腦）_

## 待處理

### 🔴 [最高優先] Discord managed role 命名衝突 — @mention 永遠打到 role 而非 bot

**根本原因（已確認）**：
Discord 邀請 bot 時自動建立同名 managed role（cartman/stan/kyle/kenny）。
使用者打 @cartman 時補全清單只出現 role，訊息的 `mention_roles` 有值但 `mentions`（user）為空，OpenAB 的 `mentions` 模式認不到。

**已嘗試但失敗**：
- API 刪除 role → HTTP 403（bot token 沒有 MANAGE_ROLES）
- API 改名 role → HTTP 403
- 切換 `involved` 模式 + API 建 thread → bot 回了一次，restart 後忘記 involvement，無法持續

**目前最可行的修法（需使用者手動）**：
1. Discord 伺服器設定 → 整合 → 把 cartman/stan/kyle/kenny 四個 bot 移除（同時刪掉 managed role）
2. 用以下連結重新邀請（permissions=0，不建立有權限的 managed role）：
   - cartman: `https://discord.com/oauth2/authorize?client_id=1493964839079641118&permissions=0&scope=bot`
   - stan:    `https://discord.com/oauth2/authorize?client_id=1494154472509800578&permissions=0&scope=bot`
   - kyle:    `https://discord.com/oauth2/authorize?client_id=1494156557468962987&permissions=0&scope=bot`
   - kenny:   `https://discord.com/oauth2/authorize?client_id=1494185596384575651&permissions=0&scope=bot`
3. 邀請後確認 @cartman 補全只出現 bot user（有 BOT 標籤），不是 role

**注意**：permissions=0 的情況下 bot 能否傳訊息，取決於 @everyone 預設權限（通常沒問題）

### ⚠️ OpenAB 架構限制：只能 thread 回覆，無法在頻道直接回

使用者希望所有 bot 在同一個頻道聊天（非 thread），但 OpenAB 的設計是：
收到 @mention → 建 thread → 在 thread 裡回應。這是 OpenAB 的架構，不是 config 問題。
**若要真的在頻道直接回，需改 OpenAB 原始碼。**

### ⚠️ 洩漏的 bot token 需重設

今晚對話中不小心貼出了一個 bot token（`MTUwMT...`），必須到 Discord Developer Portal → Bot → Reset Token 重設，並更新 `.env`。

## 已完成（2026-05-06 晚）

- [x] **Discord 伺服器重建**：新 server「南方公園」，新 channel ID `1501549509573087383`
- [x] **四個 bot 重新邀請**（OAuth2 含 permissions=68672）並完成 claude login
- [x] **entrypoint 修正**：`openab run -c` → `openab run`（latest image 是舊語法，不支援 -c 旗標）
- [x] **Config 清理**：
  - Kyle `allow_user_messages` 改回 `mentions`（從 `multibot-mentions` 誤改過的）
  - Cartman 和 Kyle 的 `RUST_LOG=debug` 移除
  - 所有 agent 統一 `allow_user_messages = "mentions"`
- [x] **@mention 失效根本原因確認**：managed role 衝突，API 無法修改
- [x] **CHANNEL_GENERAL 更新**：`.env` 已改為 `1501549509573087383`

## 已完成（2026-05-06 早，另一台機器）

- [x] **claude-agent-acp 導入**：修正 ACP 協議相容問題（舊 claude CLI 不支援 ACP JSON-RPC）
- [x] **OpenAB image 升至 0.8.3-beta.3**（docker compose build --pull）
- [x] **entrypoint 改為 openab run -c**（當時 beta image 支援，但 latest 不支援）

## 已完成（2026-04-27）

- [x] Stan/Kyle/Kenny OAuth2 補邀請
- [x] `allow_user_messages` 三種模式行為釐清
- [x] 診斷 @mention 問題（當時誤以為是 OAuth2 未邀請）

## 已完成（2026-04-26）

- [x] MemPalace MCP 整合
- [x] PR #2 merge 到 master
- [x] Discord bot 邀請問題（Message Content Intent）
- [x] docs/new-agent-sop.md 更新
- [x] setup-mcp.sh CRLF 問題修正

## 下次上班從這裡繼續

1. **[最優先]** 到 Discord Developer Portal 重設洩漏的 bot token（`MTUwMT...`），更新 `.env`
2. **[最優先]** Discord 伺服器設定 → 整合 → 移除四個 bot → 用 permissions=0 連結重新邀請
3. **[測試]** 邀請後打 @cartman，確認補全清單只有 bot user → 送出 → 確認 bot 有回應
4. **[確認後]** 看 bot 在 thread 回應的 UX 是否可接受，或考慮其他架構
