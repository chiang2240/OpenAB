# 進度與待辦

_最後更新：2026-05-19（下班交接）_

## 待處理

### 🔴 [最高優先] 驗收 bot-to-bot 對話功能

**剛完成的設定**（今天已 commit）：
- 四個 agent 的 `config.toml` 改為 `allow_bot_messages = "all"` + `trusted_bot_ids = [四個 bot ID]`
- 四個 agent 的 `CLAUDE.md` 加入「Bot 之間的互動」規則（防迴圈、角色互動原則）

**還沒有驗證**：
- Kenny 有沒有收到 Cartman 的訊息並回應？
- 對話迴圈有沒有被觸發？CLAUDE.md 的防迴圈規則有沒有效？

**驗收方式**：@Cartman 說「去跟肯尼打招呼」，觀察 Kenny 是否回應，對話是否在 3 輪內自然結束

### ⚠️ Stan / Kyle / Kenny @mention 問題（managed role 衝突）

打 `@Stan` 補全清單只出現 role 沒有 BOT 標籤。Cartman 有回應，其他三個需要從右側成員清單右鍵 mention。

**根本原因**：Discord 邀請 bot 時自動建立同名 managed role，遮蔽了 bot user 的補全選項。

**目前狀態**：未解決，暫時用右鍵 mention 當 workaround。

**可能的解法（下次可試）**：
1. 在 Discord 給三個 bot 設定 Server Nickname（不同於 managed role 名稱），例如 `斯坦`、`凱爾`、`肯尼`

## Bot ID 備查

| 角色 | Discord User ID |
|------|----------------|
| Cartman | 1506269965521518662 |
| Stan | 1506271868561129594 |
| Kyle | 1506272572655014038 |
| Kenny | 1506273240601853983 |

## 新 Server 資訊

| 項目 | 值 |
|------|---|
| Server 名稱 | 南方公園俱樂部 |
| CHANNEL_GENERAL | 1506269033685717002 |

## 已完成（2026-05-19）

- [x] **新 Discord Server「南方公園俱樂部」建立**，四個 bot 重新申請並邀請
- [x] **ANTHROPIC_API_KEY 填入 `.env`**
- [x] **CHANNEL_GENERAL 更新**為新 server 的頻道 ID（1506269033685717002）
- [x] **OpenAB 升級至 beta.11**（Dockerfile 用 latest tag，rebuild 自動取得）
- [x] **Cartman bot 驗證正常**（@mention 可回應）
- [x] **Bot-to-bot 設定完成**：`allow_bot_messages = "all"` + `trusted_bot_ids` 讀取正常（`trusted_bots=4`）
- [x] **四個 CLAUDE.md 加入角色互動規則**

## 已完成（2026-05-11）

- [x] **刪除並重建四個 Discord bot**（使用者手動操作），新 token 填入 `.env`
- [x] **docker-compose.yml 修正**：`openab run` → `openab run -c`（新版 OpenAB 0.8.3-beta.7 需要 `-c` 旗標）
- [x] **.gitignore 更新**：排除 `agents/*/.claude.json`（含帳號敏感資訊）和 `agents/*/.npm/`

## 已完成（2026-05-06 晚）

- [x] **Discord 伺服器重建**：新 server「南方公園」，新 channel ID `1501549509573087383`
- [x] **四個 bot 重新邀請**（OAuth2 含 permissions=68672）並完成 claude login
- [x] **entrypoint 修正**：`openab run -c` → `openab run`（當時 latest image 不支援 -c 旗標）
- [x] **Config 清理**：所有 agent 統一 `allow_user_messages = "mentions"`
- [x] **@mention 失效根本原因確認**：managed role 衝突，API 無法修改

## 已完成（2026-05-06 早）

- [x] **claude-agent-acp 導入**：修正 ACP 協議相容問題
- [x] **OpenAB image 升至 0.8.3-beta.3**

## 已完成（2026-04-27）

- [x] Stan/Kyle/Kenny OAuth2 補邀請
- [x] `allow_user_messages` 三種模式行為釐清

## 已完成（2026-04-26）

- [x] MemPalace MCP 整合
- [x] PR #2 merge 到 master
- [x] Discord bot 邀請問題（Message Content Intent）
- [x] docs/new-agent-sop.md 更新
- [x] setup-mcp.sh CRLF 問題修正

## 下次上班從這裡繼續

1. **[最優先]** @Cartman 說「去跟肯尼打招呼」，驗收 bot-to-bot 對話是否正常
2. **[如有迴圈]** 若對話不停，調整 CLAUDE.md 的防迴圈規則或縮小 trusted_bot_ids 範圍
3. **[可選]** 給 Stan/Kyle/Kenny 設定 Discord Server Nickname 解決 @mention 問題
