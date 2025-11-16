#!/bin/bash
# Railway startup script

set -e

echo "=== JSP Guestbook Deployment Script ==="

# Download Jetty Runner if not present
JETTY_RUNNER="jetty-runner.jar"
if [ ! -f "$JETTY_RUNNER" ]; then
    echo "Downloading Jetty Runner..."
    wget -q https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.4.51.v20230217/jetty-runner-9.4.51.v20230217.jar -O $JETTY_RUNNER
fi

# Create data directory for database
mkdir -p /app/data

# Set database path
export DB_PATH=${DB_PATH:-/app/data/guestbook.db}

# Get port from environment or use default
PORT=${PORT:-8080}

echo "Starting Jetty on port $PORT..."
echo "Database location: $DB_PATH"

# Start Jetty
exec java -Ddb.path=$DB_PATH -jar $JETTY_RUNNER --port $PORT web
