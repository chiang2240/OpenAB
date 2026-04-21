# TODO — 待辦事項

## 進行中

### 安裝 MemPalace MCP（AI 跨 session 記憶系統）

**狀態**：尚未開始

**步驟**：
1. `pip install mempalace`（需 Python 3.9+，約 300 MB）
2. `mempalace init`（初始化 `~/.mempalace/` 資料庫）
3. `claude mcp add mempalace mempalace mcp`（加入 MCP）
4. 重啟 Claude Code，確認 19 個 MCP 工具出現

**參考**：
- [安裝指南](https://www.mempalace.tech/guides/setup)
- [GitHub](https://github.com/mempalace/mempalace)

---



### 修正多 bot 同時回應問題

**狀態**：tag 任一角色，四個 bot 全部回應

**根本原因**：
- OpenAB `mentions` 模式是「訊息有任何 @mention 就回應」，不是「只回應提到自己的」
- 目前 `latest` image 只支援 `involved` / `mentions`，不支援 `multibot-mentions`

**已確認無效的做法**：
- `allow_user_messages = "multibot-mentions"` → 這版 OpenAB 不支援，容器會 crash

**解法選項（擇一）**：

**A. 每個 bot 各自一個頻道（建議）**
1. 在 Discord 建 4 個頻道：`#cartman`、`#stan`、`#kyle`、`#kenny`
2. 各自複製 Channel ID，更新 `.env`：
   ```
   CHANNEL_CARTMAN=...
   CHANNEL_STAN=...
   CHANNEL_KYLE=...
   CHANNEL_KENNY=...
   ```
3. 各角色 `config.toml` 的 `allowed_channels` 改用對應變數
4. `docker compose down && docker compose up -d`

**B. 等 OpenAB 釋出支援 `multibot-mentions` 的版本**
- 追蹤 [openabdev/openab releases](https://github.com/openabdev/openab)
- 更新後改 config：`allow_user_messages = "multibot-mentions"`

---

### ~~修正角色與 Discord bot 對應錯誤~~（已確認 token 對應正確，暫擱置）

---

## 已完成

- [x] 將 `.kiro` 設定全部改成 Claude Code 的 `CLAUDE.md` 格式
- [x] 移除 slash-bot（查詢 Kiro 用量的服務）
- [x] 建立南方公園四個角色（卡特曼、斯坦、凱爾、肯尼）
- [x] 設定各角色的個性（`agents/*/CLAUDE.md`）
- [x] 設定各角色的 OpenAB config（`agents/*/config.toml`）
- [x] Dockerfile 安裝 Node.js + Claude Code
- [x] Docker Compose 設定四個角色服務
- [x] Discord Application 建立四個 bot
- [x] 開啟 Discord Privileged Gateway Intents
- [x] 四個角色 `claude login` 認證完成
- [x] Dockerfile ENTRYPOINT 問題修正
- [x] 安裝 `@agentclientprotocol/claude-agent-acp`，修正 initialize timeout
- [x] 所有 config.toml 改用 `claude-agent-acp` 指令
- [x] docker-compose.yml 修正 OpenAB 新版 ENTRYPOINT 相容問題
- [x] 加入 `allow_user_messages = "mentions"`，修正多 bot 搶答問題
- [x] 修正 `CHANNEL_GENERAL` 頻道 ID（舊 ID 失效，更新為 `1494687723192320202`）
