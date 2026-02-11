# 使用满足要求的 Node 版本
FROM node:22-slim

# 安装必要工具
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN npm install -g openclaw@latest

# 设置工作目录
WORKDIR /app

# 核心：使用环境变量来指定端口和禁用验证，避开参数报错
ENV OPENCLAW_GATEWAY_PORT=7860
ENV OPENCLAW_GATEWAY_TOKEN=false
ENV OPENCLAW_GATEWAY_NO_OPEN=true
ENV OPENCLAW_GATEWAY_BIND=0.0.0.0

# 告知 Railway 使用的端口
EXPOSE 7860

# 启动命令：删除所有带 -- 的参数，让它直接读环境变量启动
CMD ["openclaw", "dashboard"]
