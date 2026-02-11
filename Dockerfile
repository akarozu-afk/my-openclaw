# 使用最新的 Node 环境
FROM node:22-slim

# 安装必要工具和流量转发器 socat
RUN apt-get update && apt-get install -y git socat && rm -rf /var/lib/apt/lists/*
RUN npm install -g openclaw@latest

# 设置工作目录
WORKDIR /app

# 核心步骤：将程序赶到内部端口 18789，把 7860 留给桥接器
ENV OPENCLAW_GATEWAY_PORT=18789
ENV OPENCLAW_GATEWAY_TOKEN=false
ENV OPENCLAW_GATEWAY_NO_OPEN=true

# 告知 Railway 对外开放 7860
EXPOSE 7860

# 启动逻辑：
# 1. 后台运行 openclaw，让它守在内部 127.0.0.1:18789
# 2. 等待 10 秒确保它启动完毕
# 3. 运行 socat，把 7860 端口的流量死死地“焊”在内部 18789 端口上
CMD ["sh", "-c", "openclaw dashboard --no-open & sleep 10 && socat TCP-LISTEN:7860,fork,reuseaddr TCP:127.0.0.1:18789"]
