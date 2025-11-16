# DevContainer Configuration

This directory contains the configuration for running this project in a development container.

## What is a Dev Container?

A development container (or dev container for short) allows you to use a container as a full-featured development environment. It can be used to run an application, separate tools, libraries, or runtimes needed for working with a codebase, and aid in continuous integration and testing.

## How to Use

### GitHub Codespaces (Recommended for Cloud Development)

1. **Open in GitHub Codespaces:**
   - Go to your GitHub repository
   - Click the green "Code" button
   - Select "Codespaces" tab
   - Click "Create codespace on [branch-name]"

2. **Wait for Setup:**
   - The container will build automatically
   - Post-create script will compile the project
   - This may take 2-3 minutes on first run

3. **Run the Application:**
   ```bash
   ./run.sh
   ```
   - The app will be available on port 8080
   - GitHub Codespaces will automatically forward the port
   - Click the notification to open in browser

### VS Code Remote - Containers (Local Development)

1. **Prerequisites:**
   - Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
   - Install [VS Code](https://code.visualstudio.com/)
   - Install the [Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Open in Container:**
   - Open the project folder in VS Code
   - Press `F1` and select "Remote-Containers: Reopen in Container"
   - Wait for the container to build and setup to complete

3. **Run the Application:**
   - Use VS Code task: `Ctrl+Shift+P` → "Tasks: Run Task" → "Run Application"
   - Or run in terminal: `./run.sh`
   - Access at: http://localhost:8080/guestbook/

## Features

### Pre-installed Tools
- ✅ Java 21 (OpenJDK)
- ✅ Maven 3.x
- ✅ Git
- ✅ SQLite3
- ✅ wget/curl

### VS Code Extensions
- Java Extension Pack
- Maven for Java
- Language Support for Java
- Java Debugger
- XML Tools

### VS Code Tasks
Available via `Ctrl+Shift+P` → "Tasks: Run Task":
- **Compile Project** - Compile all Java sources
- **Run Application** - Start the app with Jetty
- **Run with Maven Jetty** - Start using Maven plugin
- **Clean Build** - Remove old classes and recompile
- **Maven Clean Package** - Build WAR file
- **View Database** - Open SQLite database

## Configuration Files

- `devcontainer.json` - Main configuration file
- `Dockerfile` - Container image definition
- `post-create.sh` - Setup script that runs after container creation
- `../.vscode/tasks.json` - VS Code task definitions
- `../.vscode/launch.json` - Debug configurations
- `../.vscode/settings.json` - Editor settings

## Customization

### Change Java Version
Edit `Dockerfile`:
```dockerfile
FROM mcr.microsoft.com/devcontainers/java:1-17-bullseye  # Use Java 17
```

### Add More Extensions
Edit `devcontainer.json`:
```json
"extensions": [
  "vscjava.vscode-java-pack",
  "your-extension-id"
]
```

### Change Port
Edit `devcontainer.json`:
```json
"forwardPorts": [9090],
```

And update the server port in your run scripts.

## Troubleshooting

### Container won't build
- Check Docker is running
- Try rebuilding: `Ctrl+Shift+P` → "Remote-Containers: Rebuild Container"

### Port not forwarding
- Check the Ports panel in VS Code
- Manually forward: `Ctrl+Shift+P` → "Forward a Port"

### Compilation errors
- Run clean build: Execute "Clean Build" task
- Check Java version: `java -version`

### Database issues
- Check database location: `echo $HOME/guestbook.db`
- View database: Run "View Database" task

## Resources

- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Dev Container Specification](https://containers.dev/)
