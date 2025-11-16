#!/bin/bash

# JSP Guestbook Run Script
# This script downloads and runs Jetty server with the application

set -e

JETTY_VERSION="9.4.53.v20231009"
JETTY_DIR="jetty-distribution-${JETTY_VERSION}"
JETTY_TAR="${JETTY_DIR}.tar.gz"
JETTY_URL="https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/${JETTY_TAR}"

echo "=== JSP Guestbook Launcher ==="

# Compile first
if [ ! -d "web/WEB-INF/classes" ]; then
    echo "Compiling project..."
    bash compile.sh
fi

# Download Jetty if not present
if [ ! -d "$JETTY_DIR" ]; then
    echo "Downloading Jetty ${JETTY_VERSION}..."
    if command -v wget &> /dev/null; then
        wget -q "$JETTY_URL" -O "$JETTY_TAR"
    elif command -v curl &> /dev/null; then
        curl -s -L -o "$JETTY_TAR" "$JETTY_URL"
    else
        echo "ERROR: Neither wget nor curl is available. Please install one of them."
        exit 1
    fi

    echo "Extracting Jetty..."
    tar -xzf "$JETTY_TAR"
    rm "$JETTY_TAR"
fi

# Create webapps directory if it doesn't exist
mkdir -p "${JETTY_DIR}/webapps"

# Create symbolic link or copy web directory
WEBAPP_DIR="${JETTY_DIR}/webapps/guestbook"
if [ -L "$WEBAPP_DIR" ]; then
    rm "$WEBAPP_DIR"
fi
if [ -d "$WEBAPP_DIR" ]; then
    rm -rf "$WEBAPP_DIR"
fi

echo "Deploying application..."
cp -r web "$WEBAPP_DIR"

# Set database path
export JAVA_OPTIONS="-Ddb.path=./guestbook.db"

echo ""
echo "==================================="
echo "Starting Jetty server..."
echo "Application will be available at:"
echo "  http://localhost:8080/guestbook/"
echo "==================================="
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

cd "$JETTY_DIR"
java $JAVA_OPTIONS -jar start.jar
