# 踩坑紀錄 — 避免重蹈覆轍

記錄實際發生過的問題，方便日後快速排查同類型錯誤。

---

## 2026-04-16

### Discord Channel ID vs Guild ID
**問題**：設定 `CHANNEL_GENERAL` 時填入的是 Discord 伺服器的 Guild ID，不是頻道的 Channel ID。Bot 啟動正常但完全收不到訊息。

**如何分辨**：
- Guild ID（伺服器 ID）：在伺服器圖示上右鍵 → 「複製伺服器 ID」
- Channel ID（頻道 ID）：在頻道名稱上右鍵 → 「複製頻道 ID」

**解法**：在 `.env` 裡 `CHANNEL_GENERAL` 必須填頻道 ID，不是伺服器 ID。

---

### Docker ENTRYPOINT 繼承問題
**問題**：OpenAB 基底 image（`ghcr.io/openabdev/openab:latest`）有自己的 `ENTRYPOINT`。如果 Dockerfile 沒有加 `ENTRYPOINT []`，`docker-compose.yml` 的 `command` 會被當成參數傳給基底 image 的 entrypoint，導致啟動失敗。

**解法**：Dockerfile 加上 `ENTRYPOINT []` 來清除繼承的 entrypoint：
```dockerfile
FROM ghcr.io/openabdev/openab:latest
USER root
RUN ...
USER agent
ENTRYPOINT []
```

**驗證方式**：
```bash
docker inspect ghcr.io/openabdev/openab:latest --format '{{.Config.Entrypoint}}'
```

---

### Windows CRLF 換行符問題
**問題**：在 Windows 上建立或編輯的 `.sh` shell script，換行字元是 `\r\n`（Windows CRLF）。在 Linux container 裡執行時會失敗，錯誤訊息類似 `$'\r': command not found`。

**解法**：跨 Windows/Linux 操作時，**不要用 `.sh` 腳本**，改用 `docker-compose.yml` 的 `command` 欄位直接執行指令：
```yaml
command: sh -c "mkdir -p /home/agent/projects && openab run"
```

---

### Claude Code 首次登入必須在容器啟動前完成
**問題**：OpenAB 啟動後會執行 `claude --dangerously-skip-permissions`，但 Claude Code 第一次需要**互動式 OAuth 登入**，這跟 OpenAB 預期的靜默啟動衝突，會導致 `Timeout waiting for initialize` 錯誤。

**正確部署順序**：
1. 先啟動容器（讓它 timeout 也沒關係）
2. 進入容器執行登入：`docker exec -it cartman claude login`
3. 登入完成後重啟容器：`docker compose restart cartman`

**認證儲存位置**：`./agents/<name>/.claude/`（已掛載為 volume，重啟後保留）

---
