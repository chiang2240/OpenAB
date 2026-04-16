# TODO — 待辦事項

## 進行中

### 確認 Discord Bot 可以正常運作
**狀態**：Claude login 已完成，但 bot 回應尚未驗證成功

**背景**：
- 四個 bot（cartman、stan、kyle、kenny）的 Docker 容器已設定完成
- `cartman` 已執行 `claude login`，認證檔案存在 `agents/cartman/.claude/`
- stan、kyle、kenny 尚未執行 `claude login`

**明天繼續的步驟**：

1. **確認 `.env` 的 Channel ID 正確**
   - 用記事本開啟 `C:\Users\USER\OpenAB\.env`
   - 確認 `CHANNEL_GENERAL` 是**頻道 ID**（不是伺服器 ID）
   - 在 Discord 對頻道右鍵 → 「複製頻道 ID」取得正確值

2. **重啟 cartman 容器**
   ```powershell
   cd C:\Users\USER\OpenAB
   docker compose restart cartman
   ```

3. **看 log 確認啟動成功**
   ```powershell
   docker compose logs -f cartman
   ```
   應看到類似：`Connected to Discord`

4. **去 Discord 測試**
   - 在 `general` 頻道 @卡特曼 發一條訊息
   - 確認 bot 有回應

5. **其餘三個角色登入**（cartman 確認可以後再做）
   ```powershell
   docker exec -it stan claude login
   docker exec -it kyle claude login
   docker exec -it kenny claude login
   docker compose restart
   ```

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
- [x] cartman 執行 `claude login`（認證完成）

---

## 已知問題待確認

- [ ] **Dockerfile 缺少 `ENTRYPOINT []`**：需確認基底 image 的 entrypoint 是否會干擾啟動（見 `docs/LESSONS.md`）
- [ ] **stan、kyle、kenny 尚未 `claude login`**：等 cartman 確認可用後再做其他三個
