# 進度與待辦

_最後更新：2026-05-11（下班交接）_

## 待處理

### 🔴 [最高優先] ANTHROPIC_API_KEY 未設定 — Claude Code 無法運作

`.env` 缺少 `ANTHROPIC_API_KEY`，docker-compose.yml 有引用但值為空字串。
需要到 [console.anthropic.com](https://console.anthropic.com) 取得 API Key，填進 `.env`：

```
ANTHROPIC_API_KEY=sk-ant-...
```

填完後執行 `docker compose up -d` 讓容器吃到新值。

### 🔴 [最高優先] 容器目前全部重啟中，尚未正常運行

**根本原因（已修）**：docker-compose.yml entrypoint 的 `openab run` 缺少 `-c` 旗標。
`openab run /etc/openab/config.toml` → 應為 `openab run -c /etc/openab/config.toml`。

本次已修正 docker-compose.yml（已 commit），但還沒 `docker compose up -d` 套用。
**下次上班第一件事**：`docker compose up -d`，再看 logs 確認四個容器都正常。

### ⚠️ Discord @mention 問題（managed role 衝突）— 可能已解決

使用者今天**刪掉並重建了四個 Discord bot**，新 token 已填入 `.env`。
舊問題（managed role 與 bot 同名導致 @mention 打到 role）**可能因重建而消失**，需實際測試確認。

**驗收方式**：容器正常後，在 Discord 打 @cartman，確認：
1. 補全清單裡 cartman 有「BOT」標籤
2. bot 有在 thread 或頻道回應

### ⚠️ Channel ID 需確認

目前 `.env` 的 `CHANNEL_GENERAL=1494687723192320202`，但 2026-05-06 曾換過 server。
若 bot 加進了不同的 server/channel，需確認 CHANNEL_GENERAL 是否正確。

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

1. **[最優先]** 把 `ANTHROPIC_API_KEY` 填進 `.env`
2. **[最優先]** `docker compose up -d`，確認四個容器不再重啟
3. **[測試]** 在 Discord 打 @cartman，確認 bot 有回應
4. **[確認]** `CHANNEL_GENERAL` 是否為正確的頻道 ID
