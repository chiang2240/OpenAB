# 🏔️ 南方公園開發團隊 — 一鍵安裝腳本
# 在 PowerShell 執行：.\setup.ps1

$ErrorActionPreference = "Stop"
$ProjectDir = "C:\Users\$env:USERNAME\OpenAB"

Write-Host "=== 南方公園開發團隊 安裝中 ===" -ForegroundColor Cyan

# 1. Clone repo（如果不存在）
if (-not (Test-Path $ProjectDir)) {
    Write-Host "[1/4] Clone repo..." -ForegroundColor Yellow
    git clone https://github.com/chiang2240/OpenAB.git $ProjectDir
} else {
    Write-Host "[1/4] Repo 已存在，跳過 clone" -ForegroundColor Green
}

Set-Location $ProjectDir
git checkout claude/review-adapt-code-LxTfO
git pull

# 2. 確認 .env 存在
if (-not (Test-Path "$ProjectDir\.env")) {
    Write-Host ""
    Write-Host "[2/4] 找不到 .env！" -ForegroundColor Red
    Write-Host "請複製 .env.example 並填入 token：" -ForegroundColor Red
    Write-Host "  copy .env.example .env" -ForegroundColor Yellow
    Write-Host "  然後用記事本填入 Discord Bot Token 和 Channel ID" -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "[2/4] .env 存在，繼續..." -ForegroundColor Green
}

# 3. 啟動容器
Write-Host "[3/4] 啟動容器（第一次 build 需要幾分鐘）..." -ForegroundColor Yellow
docker compose up -d --build

# 4. 等待並顯示 log
Write-Host "[4/4] 等待 cartman 啟動..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
Write-Host ""
Write-Host "=== cartman log（Ctrl+C 結束）===" -ForegroundColor Cyan
docker compose logs -f cartman
