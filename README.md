# JSP Guestbook

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main)
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/new)
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.org/)
[![Maven](https://img.shields.io/badge/Maven-3.x-blue.svg)](https://maven.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

[中文文档](README_CN.md) | English

A simple guestbook web application built with JSP/Servlet and SQLite database.

## 🚀 Free Hosting Options

Deploy a live demo for free on these platforms:

- **[Railway.app](https://railway.app)** - Easiest deployment, $5/month free credit
- **[Render.com](https://render.com)** - 750 hours/month free tier
- **[Fly.io](https://fly.io)** - Generous free tier with persistent storage
- **[Google Cloud Run](https://cloud.google.com/run)** - 2M requests/month free

📖 **[Complete Deployment Guide →](DEPLOYMENT.md)**

## Project Modernization

This project has been upgraded from a legacy IDE-based project to a modern, standalone web application:

### Key Improvements

1. **DevContainer Support** - Zero-config cloud development with GitHub Codespaces and VS Code Remote Containers
2. **Maven Build Support** - Added `pom.xml` for dependency management and builds
3. **Cross-platform Database Path** - Fixed hardcoded Windows path to dynamic, cross-platform path
4. **Compilation Script** - Standalone compilation without IDE
5. **Run Script** - One-command application startup
6. **VS Code Integration** - Pre-configured tasks and debug configurations

## Quick Start

### Option 1: Cloud Development (Recommended) ☁️

Use GitHub Codespaces or VS Code Remote Containers for zero-configuration development:

**GitHub Codespaces:**
1. Click the "Code" button on the repository page
2. Select "Codespaces" → "Create codespace"
3. Wait for container to build (auto-compiles the project)
4. Run `./run.sh` to start the application
5. Click the port forwarding notification to open in browser

**VS Code Remote Containers:**
1. Install Docker Desktop and Remote Containers extension
2. Open the project in VS Code
3. Press `F1` → "Remote-Containers: Reopen in Container"
4. After container starts, run `./run.sh`

For detailed instructions, see [DevContainer Documentation](.devcontainer/README.md)

### Option 2: Using Run Script

The simplest local method - script automatically downloads Jetty server and starts the application:

```bash
./run.sh
```

Then visit: http://localhost:8080/guestbook/

### Option 3: Manual Compilation and Deployment

#### 1. Compile Project

```bash
./compile.sh
```

Or using Maven:

```bash
mvn clean package
```

#### 2. Deploy to Servlet Container

Deploy the `web` directory to any Servlet 3.0+ container (e.g., Tomcat, Jetty):

**Using Tomcat:**
```bash
# Copy web directory to Tomcat's webapps directory
cp -r web $TOMCAT_HOME/webapps/guestbook
# Start Tomcat
$TOMCAT_HOME/bin/catalina.sh run
```

**Using Maven Jetty Plugin:**
```bash
mvn jetty:run
```

## Project Structure

```
jspGuestbook/
├── src/                      # Java source code
│   ├── control/             # Servlet controllers
│   ├── db/                  # Database access layer
│   ├── model/               # Data models
│   └── Exception/           # Custom exceptions
├── web/                     # Web resources
│   ├── WEB-INF/
│   │   ├── web.xml         # Web application configuration
│   │   ├── classes/        # Compiled class files
│   │   └── lib/            # Dependency libraries
│   ├── css/                # Stylesheets
│   ├── js/                 # JavaScript files
│   ├── fonts/              # Font files
│   └── *.jsp               # JSP pages
├── lib/                     # Project dependencies
├── test/                    # Test code
├── pom.xml                  # Maven configuration
├── compile.sh              # Compilation script
└── run.sh                  # Run script
```

## Technology Stack

- **Java**: 1.8+ (compatible with Java 21)
- **Servlet API**: 3.1
- **JSP**: 2.3
- **Database**: SQLite 3.x
- **Build Tool**: Maven 3.x
- **Testing**: JUnit 4.x

## Database Configuration

The application uses SQLite database with default path `~/guestbook.db` (user home directory).

### Custom Database Path

You can specify the database path using Java system property:

```bash
java -Ddb.path=/path/to/your/database.db -jar ...
```

Or set it in the startup script:

```bash
export JAVA_OPTIONS="-Ddb.path=./data/guestbook.db"
./run.sh
```

## Features

- User registration and login
- Post messages/notes
- View all messages
- Clean Bootstrap UI

## Development Guide

### Build Requirements

- JDK 1.8 or higher
- Maven 3.x (optional)
- Servlet container (Tomcat 7+, Jetty 9+, etc.)

### Recompile After Changes

```bash
# Clean old compiled files
rm -rf web/WEB-INF/classes/*

# Recompile
./compile.sh
```

## Troubleshooting

### Compilation Errors

If you encounter `servlet-api` not found error, the compilation script will download it automatically. If download fails, manually download:

```bash
wget https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar \
  -O web/WEB-INF/lib/servlet-api.jar
```

### Database Connection Errors

Check database file path and permissions:

```bash
ls -la ~/guestbook.db
```

If the database doesn't exist, the application will automatically create the table structure.

### Port Conflicts

If port 8080 is occupied, you can modify the port configuration in `run.sh`, or start with a different port:

```bash
# Edit pom.xml to modify Jetty plugin port configuration
# Or specify port directly
mvn jetty:run -Djetty.http.port=9090
```

## License

This project is for educational and reference purposes only.

## Contributing

Issues and Pull Requests are welcome!
