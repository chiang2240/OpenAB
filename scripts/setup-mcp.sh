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

if (process.env.JIRA_URL && process.env.JIRA_API_TOKEN) {
  config.mcpServers.jira = {
    command: 'npx',
    args: ['-y', '@sooperset/mcp-atlassian'],
    env: {
      JIRA_URL: process.env.JIRA_URL,
      JIRA_USERNAME: process.env.JIRA_USERNAME,
      JIRA_API_TOKEN: process.env.JIRA_API_TOKEN
    }
  };
}

require('fs').writeFileSync(
  '/home/agent/.claude/settings.local.json',
  JSON.stringify(config, null, 2)
);
console.log('MCP 設定完成:', Object.keys(config.mcpServers).join(', ') || '（無 MCP）');
"
