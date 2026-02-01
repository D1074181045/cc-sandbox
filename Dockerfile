FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

# 1. 安裝系統基礎工具
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    git \
    vim \
    nano \
    unzip \
    zip \
    ca-certificates \
    net-tools \
    iputils-ping \
    software-properties-common \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# 2. 安裝 Python 環境
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python

# 3. 安裝 Node.js 環境
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# 5. 建立使用者、群組，並給予 sudo 權限
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

WORKDIR /workspace

# 6. 安裝 AI CLI 工具
ENV NPM_CONFIG_PREFIX="/home/$USERNAME/.npm-global"
ENV PATH="/home/$USERNAME/.npm-global/bin:$PATH"

RUN curl -fsSL https://claude.ai/install.sh | bash

RUN npm install -g @openai/codex
RUN npm install -g @google/gemini-cli

ENV PATH="/home/$USERNAME/.local/bin:$PATH"

CMD ["sleep", "infinity"]