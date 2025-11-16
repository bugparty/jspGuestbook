#!/bin/bash

# JSP Guestbook Compilation Script
# This script compiles the Java sources without Maven

set -e

echo "=== Compiling JSP Guestbook ==="

# Create output directories
mkdir -p web/WEB-INF/classes
mkdir -p web/WEB-INF/lib

# Copy libraries to WEB-INF/lib
echo "Copying libraries..."
cp -f lib/*.jar web/WEB-INF/lib/

# Download Servlet API if not present
SERVLET_JAR="web/WEB-INF/lib/servlet-api.jar"
if [ ! -f "$SERVLET_JAR" ]; then
    echo "Downloading Servlet API..."
    wget -q https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar -O "$SERVLET_JAR" || \
    curl -s -o "$SERVLET_JAR" https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar || \
    echo "WARNING: Could not download servlet-api.jar. Please download manually."
fi

# Set classpath
CLASSPATH="web/WEB-INF/lib/*"

# Find all Java files
echo "Finding Java source files..."
JAVA_FILES=$(find src -name "*.java")

# Compile
echo "Compiling Java sources..."
javac -encoding UTF-8 -source 1.8 -target 1.8 -cp "$CLASSPATH" -d web/WEB-INF/classes $JAVA_FILES

if [ $? -eq 0 ]; then
    echo "=== Compilation successful! ==="
    echo ""
    echo "Compiled classes are in: web/WEB-INF/classes"
    echo "You can now deploy the 'web' directory to a servlet container (Tomcat, Jetty, etc.)"
else
    echo "=== Compilation failed! ==="
    exit 1
fi
