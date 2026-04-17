FROM ghcr.io/openabdev/openab:latest
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g @anthropic-ai/claude-code @agentclientprotocol/claude-agent-acp && \
    rm -rf /var/lib/apt/lists/*
USER agent
