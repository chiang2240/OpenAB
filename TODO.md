# TODO — 待辦事項

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
