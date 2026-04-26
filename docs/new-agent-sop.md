# 新增角色 SOP

## 前置準備

1. 到 [Discord Developer Portal](https://discord.com/developers/applications) 建立新的 Application
2. 設定 Bot 名稱和頭像
3. Bot → 開啟 **Message Content Intent**
4. OAuth2 → URL Generator → scope: `bot` → 勾選權限：
   - Send Messages
   - Send Messages in Threads
   - Create Public Threads
   - Read Message History
   - Add Reactions
   - Manage Messages
5. 用產生的連結邀請 bot 到你的 Discord server
6. 複製 Bot Token

## 建立角色目錄

以新增「蟹老闆」(krabs) 為例：

```bash
mkdir -p agents/krabs
```

## 建立設定檔

建立 `agents/krabs/config.toml`：

```toml
[discord]
bot_token = "${DISCORD_BOT_TOKEN}"
allowed_channels = ["${CHANNEL_GENERAL}"]
allow_user_messages = "multibot-mentions"
allow_bot_messages = "off"

[agent]
command = "claude-agent-acp"
args = []
working_dir = "/home/agent/projects"

[pool]
max_sessions = 10
session_ttl_hours = 24

[reactions]
enabled = true
remove_after_reply = false

[reactions.emojis]
queued = "👀"
thinking = "🤔"
tool = "🔥"
coding = "🦀"
web = "⚡"
done = "🆗"
error = "😱"

[reactions.timing]
debounce_ms = 700
stall_soft_ms = 10000
stall_hard_ms = 30000
done_hold_ms = 1500
error_hold_ms = 2500
```

可自訂 `coding` emoji 為角色代表符號。

`allow_user_messages = "multibot-mentions"` 確保多個 bot 在同一頻道時不會互相搶答，需要被 @ 才回應。

## 建立 CLAUDE.md

建立 `agents/krabs/CLAUDE.md`，包含：

- 身份描述
- 個性與回答風格
- 口頭禪與用語
- 工作職責
- 互動規則
- 工作環境（固定內容，複製即可）
- 工作日誌規範（固定內容，複製即可）

工作環境區塊（每個角色都一樣）：

```markdown
## 工作環境

- 你的工作目錄是 `/home/agent/projects`，所有專案都必須在這個目錄底下進行
- 每個專案用獨立的子目錄，例如 `/home/agent/projects/my-app`
- 不要在 `/home/agent/projects` 以外的地方建立或修改檔案
- 這個目錄會與本地電腦同步，所以你在這裡寫的程式碼，團隊成員都看得到
- 使用 `git` 進行版本控制，用 `gh` 操作 GitHub（建立 PR、管理 issue 等）
- commit 時不需要設定 git 使用者名稱和信箱，環境已經幫你設定好了

## 工作日誌

- 你的記憶不會跨對話保留，所以你必須依賴檔案來記住事情
- 在 `/home/agent/projects/` 底下維護一份 `WORKLOG.md`
- 每次開始新的工作前，先讀取 `WORKLOG.md` 了解之前做過什麼
- 每次完成一項工作後，在 `WORKLOG.md` 最上方新增一筆紀錄，格式如下：

\`\`\`
## YYYY-MM-DD 簡短標題
- 做了什麼
- 目前狀態
- 待辦事項
\`\`\`

## 交接原則

- 假設每次對話都是全新的開始
- 所有重要資訊都要寫進檔案，不要只存在對話裡
- 如果有人問你之前做了什麼，去讀 `WORKLOG.md`
```

可參考現有角色的 CLAUDE.md：

```bash
cp agents/cartman/CLAUDE.md agents/krabs/CLAUDE.md
# 再修改角色名稱、個性等內容
```

## 更新 .env

在 `.env` 中新增 token，並同步更新 `.env.example`：

```env
DISCORD_BOT_TOKEN_KRABS=你的token
```

## 更新 docker-compose.yml

在 `services` 區塊新增（使用 `<<: *entrypoint` 繼承啟動流程）：

```yaml
  krabs:
    build: .
    container_name: krabs
    restart: unless-stopped
    <<: *entrypoint
    environment:
      - DISCORD_BOT_TOKEN=${DISCORD_BOT_TOKEN_KRABS}
      - CHANNEL_GENERAL=${CHANNEL_GENERAL}
      - GIT_AUTHOR_NAME=蟹老闆 (Mr. Krabs)
      - GIT_COMMITTER_NAME=蟹老闆 (Mr. Krabs)
      - GIT_AUTHOR_EMAIL=${GIT_EMAIL}
      - GIT_COMMITTER_EMAIL=${GIT_EMAIL}
      - MEMPALACE_PALACE_PATH=/palace
      - FIGMA_API_KEY=${FIGMA_API_KEY:-}
      - ATLASSIAN_SITE_NAME=${ATLASSIAN_SITE_NAME:-}
      - ATLASSIAN_USER_EMAIL=${ATLASSIAN_USER_EMAIL:-}
      - ATLASSIAN_API_TOKEN=${ATLASSIAN_API_TOKEN:-}
      - JIRA_PROJECT_KEY=${JIRA_PROJECT_KEY:-}
    volumes:
      - ./agents/krabs/config.toml:/etc/openab/config.toml:ro
      - ./agents/krabs:/home/agent
      - ./palace:/palace
```

`<<: *entrypoint` 會自動繼承 `mempalace init`、`setup-mcp.sh`、`openab run` 的啟動流程。

## 啟動

```bash
docker compose up -d --build
```

## 首次登入

```bash
# claude 登入
docker exec -it krabs claude login

# gh 登入（如果需要 git 操作）
docker exec -it krabs gh auth login

# 重啟讓登入生效
docker compose restart krabs
```

## 驗證

```bash
# 檢查 logs
docker compose logs krabs --tail 20

# 在 Discord 頻道 @蟹老闆 測試
```

## 檢查清單

- [ ] Discord Application 已建立
- [ ] Message Content Intent 已開啟
- [ ] Bot 已邀請到 server
- [ ] `agents/krabs/config.toml` 已建立（含 `multibot-mentions`）
- [ ] `agents/krabs/CLAUDE.md` 已建立
- [ ] `.env` 已新增 token
- [ ] `.env.example` 已同步更新
- [ ] `docker-compose.yml` 已新增 service（含 `<<: *entrypoint` 和 palace volume）
- [ ] `claude login` 已完成
- [ ] `gh auth login` 已完成（如需要）
- [ ] Discord 測試 `@` 有回應
