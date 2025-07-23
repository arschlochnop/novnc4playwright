# novnc4playwright

> 基于 Playwright 官方镜像，集成 noVNC + Xvfb + x11vnc，支持 Web 远程可视化自动化测试环境的 Docker 镜像。

## 项目简介

本项目旨在为 Playwright 自动化测试/爬虫等场景，提供一个即开即用的 Web 可视化远程桌面环境。通过 noVNC，用户可直接在浏览器中远程访问容器内的浏览器界面，便于调试、演示和教学。

- **Playwright**：主流浏览器自动化测试框架。
- **Xvfb**：虚拟 X11 显示服务器，支持无头环境下 GUI 程序运行。
- **x11vnc**：将 X11 显示输出转为 VNC 协议。
- **noVNC**：将 VNC 画面转为 WebSocket，浏览器可直接访问。

## 主要特性

- 一键部署 Playwright + noVNC 环境，无需本地安装浏览器。
- 支持 Web 端远程访问 GUI，便于调试和演示。
- 兼容原生 Playwright CLI 和脚本。
- 端口 6080 暴露 Web VNC 服务。
- **支持动态配置 Playwright、noVNC、websockify 版本**（见下文）。

## 快速开始

### 1. 构建镜像

```bash
git clone <your-repo-url>
cd novnc4playwright
# 默认构建（使用官方推荐版本）
docker build -t novnc4playwright .
# 自定义版本构建示例：
docker build --build-arg PLAYWRIGHT_VERSION=1.42.0-jammy \
             --build-arg PLAYWRIGHT_CLI_VERSION=1.42.0 \
             --build-arg NOVNC_VERSION=v1.4.0 \
             --build-arg WEBSOCKIFY_VERSION=v0.11.0 \
             -t novnc4playwright:custom .
```

### 2. 运行容器

```bash
docker run -it --rm -p 6080:6080 novnc4playwright
```

- 默认会启动 noVNC 服务，Web 端口为 6080。
- 可通过 `docker run ... <your-cmd>` 覆盖默认命令，如运行自定义 Playwright 脚本。

### 3. 访问 Web VNC

在浏览器中打开：

```
http://localhost:6080
```

即可看到容器内的桌面和浏览器界面。

## 典型用例

- Playwright 自动化脚本的远程可视化调试
- 教学/演示自动化测试流程
- 远程运行爬虫并实时观察浏览器行为

## 技术细节

- 基于 `mcr.microsoft.com/playwright:<版本>` 官方镜像
- 集成 Xvfb、x11vnc、noVNC、Playwright CLI
- entrypoint.sh 启动虚拟 X 服务、VNC、noVNC 并执行传入命令
- 暴露 6080 端口供 Web 访问
- **支持以下构建参数：**
  - `PLAYWRIGHT_VERSION`（基础镜像版本，默认1.54.1-noble）
  - `PLAYWRIGHT_CLI_VERSION`（Playwright CLI 版本，默认1.54.1）
  - `NOVNC_VERSION`（noVNC 分支/标签，默认master）
  - `WEBSOCKIFY_VERSION`（websockify 分支/标签，默认master）

## 文件结构

```
novnc4playwright/
├── Dockerfile         # 构建主镜像
├── entrypoint.sh      # 启动 Xvfb/VNC/noVNC 并执行命令
```

## 贡献与协议

欢迎 Issue 和 PR！

- 代码遵循 MIT 协议
- 如有建议或问题请提交 Issue

---

# English Summary

**novnc4playwright** provides a ready-to-use Docker image for Playwright automation with a web-based VNC (noVNC) interface. Easily debug and demo browser automation in your browser, no local GUI required.

- Based on Playwright official image
- Includes Xvfb, x11vnc, noVNC
- Exposes port 6080 for web VNC access
- **Supports dynamic version configuration via build args**

## Quick Start

```bash
docker build -t novnc4playwright .
# Or with custom versions:
docker build --build-arg PLAYWRIGHT_VERSION=1.42.0-jammy \
             --build-arg PLAYWRIGHT_CLI_VERSION=1.42.0 \
             --build-arg NOVNC_VERSION=v1.4.0 \
             --build-arg WEBSOCKIFY_VERSION=v0.11.0 \
             -t novnc4playwright:custom .
docker run -it --rm -p 6080:6080 novnc4playwright
# Visit http://localhost:6080 in your browser
```

---

如需更多功能或定制，欢迎 Fork 与贡献！
