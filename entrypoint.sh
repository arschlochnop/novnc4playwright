#!/usr/bin/env bash
set -e

# 启动虚拟 X 服务
Xvfb :99 -screen 0 1920x1080x24 -ac &

# 启动 x11vnc
x11vnc -display :99 -nopw -forever -shared &

# 启动 noVNC
/opt/novnc/utils/novnc_proxy \
  --web /opt/novnc \
  --vnc localhost:5900 \
  --listen 6080 &

sleep 2

# 切换 DISPLAY 并执行传入命令
export DISPLAY=:99
exec "$@"
