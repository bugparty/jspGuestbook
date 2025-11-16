#!/bin/bash

# Post-create script for DevContainer
# This runs after the container is created

set -e

echo "🔧 Setting up JSP Guestbook development environment..."

# Make scripts executable
chmod +x compile.sh run.sh

# Pre-download Servlet API to speed up first compilation
echo "📦 Downloading dependencies..."
if [ ! -f "web/WEB-INF/lib/servlet-api.jar" ]; then
    mkdir -p web/WEB-INF/lib
    wget -q https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar \
        -O web/WEB-INF/lib/servlet-api.jar 2>/dev/null || \
    curl -s -o web/WEB-INF/lib/servlet-api.jar \
        https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar || \
    echo "⚠️  Could not download servlet-api.jar, will be downloaded on first compile"
fi

# Compile the project
echo "🔨 Compiling project..."
bash compile.sh

# Create initial database if it doesn't exist
if [ ! -f "$HOME/guestbook.db" ]; then
    echo "📚 Creating initial database..."
    # Database will be created automatically when the app first runs
fi

echo "✅ Setup complete!"
echo ""
echo "📖 Quick Start Guide:"
echo "  1. Run the application: ./run.sh"
echo "  2. Open browser to: http://localhost:8080/guestbook/"
echo "  3. Or use Maven: mvn jetty:run"
echo ""
echo "📂 Project structure:"
echo "  - src/         : Java source code"
echo "  - web/         : JSP pages and static resources"
echo "  - compile.sh   : Compile the project"
echo "  - run.sh       : Run with embedded Jetty"
echo ""
