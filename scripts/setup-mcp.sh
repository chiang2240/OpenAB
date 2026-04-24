#!/bin/sh
# 從環境變數生成 Claude Code MCP 設定
# 每次容器啟動時執行，避免 token 寫進 git

mkdir -p /home/agent/.claude

node -e "
const config = { mcpServers: {} };

if (process.env.FIGMA_API_KEY) {
  config.mcpServers.figma = {
    command: 'figma-developer-mcp',
    args: ['--stdio'],
    env: { FIGMA_API_KEY: process.env.FIGMA_API_KEY }
  };
}

if (process.env.ATLASSIAN_SITE_NAME && process.env.ATLASSIAN_API_TOKEN) {
  config.mcpServers.jira = {
    command: 'npx',
    args: ['-y', '@aashari/mcp-server-atlassian-jira'],
    env: {
      ATLASSIAN_SITE_NAME: process.env.ATLASSIAN_SITE_NAME,
      ATLASSIAN_USER_EMAIL: process.env.ATLASSIAN_USER_EMAIL,
      ATLASSIAN_API_TOKEN: process.env.ATLASSIAN_API_TOKEN
    }
  };
}

require('fs').writeFileSync(
  '/home/agent/.claude/settings.local.json',
  JSON.stringify(config, null, 2)
);
console.log('MCP 設定完成:', Object.keys(config.mcpServers).join(', ') || '（無 MCP）');
"
