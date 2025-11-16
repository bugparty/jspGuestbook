# JSP Guestbook 留言板

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main)
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/new)
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.org/)
[![Maven](https://img.shields.io/badge/Maven-3.x-blue.svg)](https://maven.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

中文 | [English](README.md)

这是一个使用 JSP/Servlet 技术开发的简单留言板应用，使用 SQLite 作为数据库。

## 🚀 免费托管平台

可以在以下平台免费部署在线演示：

- **[Railway.app](https://railway.app)** - 最简单的部署方式，每月 $5 免费额度
- **[Render.com](https://render.com)** - 每月 750 小时免费
- **[Fly.io](https://fly.io)** - 慷慨的免费额度，支持持久化存储
- **[Google Cloud Run](https://cloud.google.com/run)** - 每月 200 万次请求免费

📖 **[完整部署指南 →](DEPLOYMENT.md)**

## 项目现代化改造

本项目已经从老旧的 IDE 项目升级为可独立运行的现代化 Web 应用：

### 主要改进

1. **添加 DevContainer 支持** - 支持 GitHub Codespaces 和 VS Code Remote Containers，云端开发零配置
2. **添加 Maven 构建支持** - 创建了 `pom.xml`，可以使用 Maven 进行依赖管理和构建
3. **修复数据库路径** - 将硬编码的 Windows 路径改为跨平台的动态路径
4. **创建编译脚本** - 提供独立的编译脚本，无需 IDE
5. **创建运行脚本** - 一键启动应用的便捷脚本
6. **VS Code 集成** - 预配置的任务和调试配置

## 快速开始

### 方法一：在云端开发（推荐）☁️

使用 GitHub Codespaces 或 VS Code Remote Containers，零配置即可开始开发：

**GitHub Codespaces:**
1. 点击仓库页面的 "Code" 按钮
2. 选择 "Codespaces" → "Create codespace"
3. 等待容器构建完成（自动编译项目）
4. 运行 `./run.sh` 启动应用
5. 点击端口转发通知打开浏览器

**VS Code Remote Containers:**
1. 安装 Docker Desktop 和 Remote Containers 扩展
2. 在 VS Code 中打开项目
3. 按 `F1` → "Remote-Containers: Reopen in Container"
4. 容器启动后运行 `./run.sh`

详细说明请查看 [DevContainer 文档](.devcontainer/README.md)

### 方法二：使用运行脚本

这是最简单的本地运行方式，脚本会自动下载 Jetty 服务器并启动应用：

```bash
./run.sh
```

然后访问：http://localhost:8080/guestbook/

### 方法三：手动编译和部署

#### 1. 编译项目

```bash
./compile.sh
```

或使用 Maven：

```bash
mvn clean package
```

#### 2. 部署到 Servlet 容器

将 `web` 目录部署到任何 Servlet 3.0+ 容器（如 Tomcat、Jetty）：

**使用 Tomcat:**
```bash
# 将 web 目录复制到 Tomcat 的 webapps 目录
cp -r web $TOMCAT_HOME/webapps/guestbook
# 启动 Tomcat
$TOMCAT_HOME/bin/catalina.sh run
```

**使用 Maven Jetty 插件:**
```bash
mvn jetty:run
```

## 项目结构

```
jspGuestbook/
├── src/                      # Java 源代码
│   ├── control/             # Servlet 控制器
│   ├── db/                  # 数据库访问层
│   ├── model/               # 数据模型
│   └── Exception/           # 自定义异常
├── web/                     # Web 资源
│   ├── WEB-INF/
│   │   ├── web.xml         # Web 应用配置
│   │   ├── classes/        # 编译后的类文件
│   │   └── lib/            # 依赖库
│   ├── css/                # 样式文件
│   ├── js/                 # JavaScript 文件
│   ├── fonts/              # 字体文件
│   └── *.jsp               # JSP 页面
├── lib/                     # 项目依赖库
├── test/                    # 测试代码
├── pom.xml                  # Maven 配置
├── compile.sh              # 编译脚本
└── run.sh                  # 运行脚本
```

## 技术栈

- **Java**: 1.8+（兼容 Java 21）
- **Servlet API**: 3.1
- **JSP**: 2.3
- **数据库**: SQLite 3.x
- **构建工具**: Maven 3.x
- **测试框架**: JUnit 4.x

## 数据库配置

应用使用 SQLite 数据库，默认路径为 `~/guestbook.db`（用户主目录）。

### 自定义数据库路径

可以通过 Java 系统属性指定数据库路径：

```bash
java -Ddb.path=/path/to/your/database.db -jar ...
```

或在启动脚本中设置：

```bash
export JAVA_OPTIONS="-Ddb.path=./data/guestbook.db"
./run.sh
```

## 功能特性

- 用户注册和登录
- 发布留言/笔记
- 查看所有留言
- 简洁的 Bootstrap 界面

## 开发说明

### 编译要求

- JDK 1.8 或更高版本
- Maven 3.x（可选）
- Servlet 容器（Tomcat 7+、Jetty 9+ 等）

### 修改后重新编译

```bash
# 清理旧的编译文件
rm -rf web/WEB-INF/classes/*

# 重新编译
./compile.sh
```

## 故障排除

### 编译错误

如果遇到 `servlet-api` 找不到的错误，编译脚本会自动下载。如果下载失败，可以手动下载：

```bash
wget https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar \
  -O web/WEB-INF/lib/servlet-api.jar
```

### 数据库连接错误

检查数据库文件路径和权限：

```bash
ls -la ~/guestbook.db
```

如果数据库不存在，应用会自动创建表结构。

### 端口冲突

如果 8080 端口被占用，可以修改 `run.sh` 中的端口配置，或使用其他端口启动：

```bash
# 编辑 pom.xml 修改 Jetty 插件的端口配置
# 或直接指定端口
mvn jetty:run -Djetty.http.port=9090
```

## 许可证

本项目仅供学习和参考使用。

## 贡献

欢迎提交 Issue 和 Pull Request！
