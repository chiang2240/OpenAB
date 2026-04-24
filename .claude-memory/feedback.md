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
