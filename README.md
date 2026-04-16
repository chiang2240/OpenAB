# 🏔️ 南方公園開發團隊

基於 [OpenAB](https://github.com/openabdev/openab) 的 Discord AI 開發團隊，每個角色都是獨立的 AI agent，擁有自己的個性、職責和工作空間。

## 架構

```
Discord Server: 南方公園
│
└── AI 角色（OpenAB + Claude Code）
    ├── 👑 卡特曼 — 全端工程師
    ├── 🎿 斯坦   — 前端工程師
    ├── 🧢 凱爾   — 後端工程師
    └── 🧡 肯尼   — 維運助手
```

## 快速開始

```bash
# 1. 複製環境變數範本
cp .env.example .env
# 編輯 .env 填入 token、channel ID

# 2. 啟動
docker compose up -d --build

# 3. 各角色登入 claude
docker exec -it cartman claude login
docker exec -it stan claude login
docker exec -it kyle claude login
docker exec -it kenny claude login

# 4. 登入 gh（如需 git 操作）
docker exec -it cartman gh auth login

# 5. 重啟
docker compose restart
```

## 目錄結構

```
OpenAB/
├── .env.example              ← 環境變數範本
├── .gitignore
├── CLAUDE.md                 ← 專案說明與開發慣例
├── Dockerfile                ← 基於官方 OpenAB image + git + Claude Code
├── docker-compose.yml
├── agents/                   ← AI 角色
│   ├── cartman/              ← 👑 卡特曼（全端工程師）
│   │   ├── config.toml
│   │   └── CLAUDE.md
│   ├── stan/                 ← 🎿 斯坦（前端工程師）
│   ├── kyle/                 ← 🧢 凱爾（後端工程師）
│   └── kenny/                ← 🧡 肯尼（維運助手）
└── docs/
    └── new-agent-sop.md      ← 新增角色 SOP
```

## 角色清單

| 角色 | 別名 | 職責 | 狀態 |
|------|------|------|------|
| 👑 卡特曼 | cartman | 全端工程師 | 運作中 |
| 🎿 斯坦 | stan | 前端工程師 | 運作中 |
| 🧢 凱爾 | kyle | 後端工程師 | 運作中 |
| 🧡 肯尼 | kenny | 維運助手 | 運作中 |

## 常用指令

```bash
# 啟動全部
docker compose up -d --build

# 看特定角色 logs
docker compose logs -f cartman

# 重啟特定角色
docker compose restart cartman

# 更新 OpenAB 到最新版
docker compose build --pull
docker compose up -d
```

## 新增角色

參考 [docs/new-agent-sop.md](docs/new-agent-sop.md)。

## 授權

MIT
