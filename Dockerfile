FROM python:3.13.5-slim-bookworm

# 1. 安装需要的工具：sshd + git + gcc 完整编译工具链
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openssh-server \
    git \
    gcc \
    g++ \
    make && \
    rm -rf /var/lib/apt/lists/*  # 清理缓存，最小化镜像

# 2. 配置SSH（允许root登录，设置密码） jkfdhgjkd
RUN mkdir -p /run/sshd && \
    echo "root:123456" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 3. 暴露端口 + 启动SSH
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
