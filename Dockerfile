# 使用满足要求的 Node 版本
FROM node:22-slim

# 安装必要工具
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN npm install -g openclaw@latest

# 创建配置目录（这是它寻找配置的默认老巢）
RUN mkdir -p /root/.openclaw

# 核心：物理注入配置文件，强制关掉 Token、强制绑定 0.0.0.0
# 这样就不再需要桥接器，它自己就会乖乖开门接客
RUN echo "gateway:\n  bind: 0.0.0.0\n  port: 7860\n  noOpen: true\n  token: false" > /root/.openclaw/openclaw.yaml

# 暴露端口
EXPOSE 7860

# 启动命令：不需要任何参数，它会自动读取上面的配置文件
CMD ["openclaw", "dashboard"]
