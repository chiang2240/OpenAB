# TODO — 待辦事項

## 進行中

### 修正角色與 Discord bot 對應錯誤

**狀態**：`.env` 裡的 token 填錯位置，需要對照 Discord Developer Portal 確認

**症狀**：`@cartman` 由 Kyle 回應，`@Kyle` 由 Stan 回應，依此類推

**步驟**：

1. 開啟 [Discord Developer Portal](https://discord.com/developers/applications)
2. 對照以下 Application ID，確認每個 Application 對應哪個角色：
   - `1493964839079641118` → 目前放在 `DISCORD_BOT_TOKEN_CARTMAN`
   - `1494154472509800578` → 目前放在 `DISCORD_BOT_TOKEN_STAN`
   - `1494156557468962987` → 目前放在 `DISCORD_BOT_TOKEN_KYLE`
   - `1494185596384575651` → 目前放在 `DISCORD_BOT_TOKEN_KENNY`
3. 依照正確對應修改 `.env`
4. `docker compose restart`

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
