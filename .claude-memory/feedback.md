# 使用偏好與協作慣例

## 溝通
- 回應語言：繁體中文
- 風格：簡短直接，不贅述，不用項目符號堆疊廢話
- 不確定時直接說「不知道」，不要亂猜

## Git 慣例
- Branch 命名：英文小寫 + 連字號
- Commit message 格式：`feat/fix/chore/docs: 簡短描述`（繁體中文說明）
- 不直接 push 到 master，用 PR

## 程式碼慣例
- 文件、commit message、CLAUDE.md 全用繁體中文
- 程式碼變數、技術術語可用英文
- Token / 密鑰一律用環境變數，不寫死

## Claude Code 操作
- 修改前先讀檔案確認現況
- 新增 env var 時同步更新 `.env.example`
- 新增角色遵循 `docs/new-agent-sop.md`

## 跨機器工作流（重要）
- 使用者在公司電腦和家裡電腦交替工作，每次對話不一定是同一台機器
- **每次對話開始必須先 `git fetch`**，然後看遠端 log，再讀 `.claude-memory/`
- 不可假設本地狀態就是最新狀態——另一台機器可能已經做了大量工作
- 不要讓使用者花時間幫你回顧；自己從 git log 和 `.claude-memory/` 還原上下文
- 對話結束（使用者說「下班」或暗示要停）時，更新 `progress.md` 做好交接
