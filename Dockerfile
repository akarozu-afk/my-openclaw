# 1. 使用符合 OpenClaw 要求的最新环境
FROM node:22-slim

# 2. 安装必要的基础工具
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN npm install -g openclaw@latest

# 3. 设置工作目录
WORKDIR /app

# 4. 核心：通过环境变量强制“开门”并关闭验证
# Railway 会自动处理外部访问，我们只需要让程序监听 0.0.0.0
ENV OPENCLAW_GATEWAY_TOKEN=false
ENV OPENCLAW_GATEWAY_NO_OPEN=true
ENV OPENCLAW_GATEWAY_BIND=0.0.0.0

# 5. 告知 Railway 使用 7860 端口
EXPOSE 7860

# 6. 启动指令：强制使用 7860 端口启动
CMD ["openclaw", "dashboard", "--port", "7860"]
