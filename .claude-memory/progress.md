# 進度與待辦

_最後更新：2026-04-26（家裡電腦）_

## 待處理

### 🔴 [高優先] Stan / Kyle / Kenny 無回應問題

- **狀態**：待查明
- **症狀**：三個 bot 沒有綠點（offline），@-mention 後也無回應
- **容器狀態**：全部 healthy，logs 確認有收到 Discord 事件（MESSAGE_CREATE）
- **Stan 的 log 行為**：
  ```
  thread check channel_id=1494894076930035893 parent_id=Some(1494687723192320202)
  owner_id=Some(UserId(1493964839079641118)) parent_allowed=true bot_owns=false
  multi-bot thread, requiring @mention
  ```
- **推測原因**：`multibot-mentions` 認定 thread 是 Cartman（1493964839079641118）開的，所以要求 @mention。但 @mention 後仍無回應，可能是：
  1. 使用者的 @mention 是純文字而非 Discord 真正的 mention（`<@user_id>`），因為 bot 不顯示在 member list 裡
  2. 或 OpenAB 的 multibot-mentions 判斷邏輯問題
- **排查建議**：
  1. 暫時把 kyle 的 `allow_user_messages` 改為 `"all"`，看是否有回應（確認連線正常）
  2. 若改為 `all` 有回應 → 問題在 multibot-mentions 邏輯
  3. 若改為 `all` 仍無回應 → 問題在更底層（可能 MESSAGE_CONTENT intent 仍不正確）
  4. 加 `RUST_LOG=debug` 到 kyle 看完整訊息內容
- **暫時解法**：考慮改回 `"mentions"`（每個 bot 都在 allowed channel 回應 @mention，不管 thread owner）

### openab run -c 語法（等 image 更新）

- **狀態**：刻意暫緩
- **說明**：0.8.1-beta.4 release note 說 `openab run` 改為 `openab run -c <path>`，但 `ghcr.io/openabdev/openab:latest` 實際上還是舊版 binary，改了會 crash
- **待辦**：等 `latest` image 真正更新後，把 `docker-compose.yml` entrypoint 的 `openab run /etc/openab/config.toml` 改為 `openab run -c /etc/openab/config.toml`
- **確認方式**：`docker run --rm ghcr.io/openabdev/openab:latest openab run --help`，若出現 `-c, --config` 旗標即可改

## 已完成（今天 2026-04-26）

- [x] **MemPalace MCP 整合**
  - Dockerfile 加 `pip3 install mempalace`
  - `scripts/setup-mcp.sh` 加 mempalace MCP server 設定
  - `docker-compose.yml` entrypoint 加 `mempalace init /palace --yes 2>/dev/null || true`
  - 四個 agent 加 `MEMPALACE_PALACE_PATH=/palace` 與 `./palace:/palace` volume
  - 容器啟動後確認 `.mempalace/` 目錄存在，功能正常
- [x] **PR #2 已 merge 到 master**（SHA: e98f4e8）
  - 使用 GitHub REST API merge（gh CLI 缺 read:org scope）
  - 解決了 Dockerfile、docker-compose、config.toml 的衝突
- [x] **multibot-mentions 改版**
  - 所有 bot config 改為 `allow_user_messages = "multibot-mentions"` + `allow_bot_messages = "off"`
  - 新版 OpenAB image 支援此值，容器不再 crash
- [x] **Discord bot 邀請問題解決**
  - Stan / Kyle / Kenny 三個 bot 被邀請進 server（之前從未被邀請）
  - Developer Portal 開啟 Message Content Intent（此前未開啟，導致 4014 disconnect）
  - 三個 bot 現在可以穩定連線並收到 Discord 事件
- [x] **docs/new-agent-sop.md 更新**（反映目前架構）
- [x] **Stan 的 RUST_LOG=debug 移除**（臨時加的 debug flag，已清理）
- [x] **setup-mcp.sh CRLF 問題修正**
  - Windows 建立的檔案有 `\r\n` 換行，Linux 的 shebang 無法執行
  - Dockerfile 加 `sed -i 's/\r$//'` 修正

## 已完成（之前）

- [x] 四個南方公園角色設定（cartman / stan / kyle / kenny）
- [x] Dockerfile + docker-compose.yml 完整設定
- [x] 各角色 Claude Code 認證（`claude login`）
- [x] **Figma MCP + Jira MCP 整合**（2026-04-24）
- [x] **.claude-memory/ 跨機器記憶同步**（2026-04-24）
- [x] **SOP + 跨機器工作流建立（2026-04-25 晚）**

## 下次上班從這裡繼續

1. **[主要] Stan/Kyle/Kenny 無回應排查**：
   - 先改 kyle config 為 `allow_user_messages = "all"` 測試
   - 若有回應 → 改回 `"mentions"` 作為暫時解法，另研究 `multibot-mentions` 的正確使用方式
2. **Figma / Jira token**：沒有帳號，功能已架好但尚未測試；有帳號後填 `.env` 即可
