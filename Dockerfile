# ===== 支持动态配置版本 =====
ARG PLAYWRIGHT_VERSION=1.54.1-noble
ARG PLAYWRIGHT_CLI_VERSION=1.54.1
ARG NOVNC_VERSION=master
ARG WEBSOCKIFY_VERSION=master

FROM mcr.microsoft.com/playwright:${PLAYWRIGHT_VERSION}

# 安装依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
      xvfb \
      x11vnc \
      websockify \
      dos2unix \
    && rm -rf /var/lib/apt/lists/*

# 安装 noVNC
RUN git clone --depth 1 --branch ${NOVNC_VERSION} https://github.com/novnc/noVNC.git /opt/novnc \
 && git clone --depth 1 --branch ${WEBSOCKIFY_VERSION} https://github.com/novnc/websockify.git /opt/novnc/utils/websockify

# 安装 Playwright CLI
RUN npm install -g playwright@${PLAYWRIGHT_CLI_VERSION} \
 && npx playwright install --with-deps

WORKDIR /app

# 复制并转换行尾、赋可执行权限
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN dos2unix /usr/local/bin/entrypoint.sh \
 && chmod +x    /usr/local/bin/entrypoint.sh

EXPOSE 6080

# 明确指定解释器来运行脚本
ENTRYPOINT ["bash", "/usr/local/bin/entrypoint.sh"]

# 默认命令：可被 `docker run ... <your cmd>` 覆盖
CMD ["npx", "playwright", "test", "--headed"]
