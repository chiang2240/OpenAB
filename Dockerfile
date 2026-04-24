FROM ghcr.io/openabdev/openab:latest
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g @anthropic-ai/claude-code @agentclientprotocol/claude-agent-acp \
        figma-developer-mcp @aashari/mcp-server-atlassian-jira && \
    rm -rf /var/lib/apt/lists/*
COPY scripts/setup-mcp.sh /usr/local/bin/setup-mcp.sh
RUN chmod +x /usr/local/bin/setup-mcp.sh
USER agent
