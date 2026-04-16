# 待改項目

## 1. 換掉角色
- 角色名、顯示名稱、職責、個性風格、emoji
- 需修改：
  - `agents/*/config.toml`
  - `agents/*/.kiro/steering/personality.md`
  - `docker-compose.yml`（GIT_AUTHOR_NAME 等）
  - `README.md`
  - `docs/new-agent-sop.md`
  - `.env.example`（token 變數名）

## 2. 換 AI 引擎（kiro-cli → claude 或其他）
- 需修改：
  - `agents/*/config.toml` 中的 `[agent] command` 與 `args`
  - `docs/new-agent-sop.md` 範本

## 3. 調整 slash-bot
- 使用者清單（USER_MAP：UUID → 姓名）
- 各成員 tier（PRO / PRO_PLUS / POWER）
- S3 bucket、Athena workgroup / database 名稱
- 需修改：
  - `services/slash-bot/query_usage.py`
