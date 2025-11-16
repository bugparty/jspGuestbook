# Use official Microsoft DevContainer Java image
FROM mcr.microsoft.com/devcontainers/java:1-21-bullseye

# Install additional tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    maven \
    wget \
    curl \
    git \
    sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${PATH}"

# Create workspace directory
RUN mkdir -p /workspace
WORKDIR /workspace

# Set up non-root user (vscode user is already created in the base image)
USER vscode

# Expose port for the web application
EXPOSE 8080

# Default command
CMD ["/bin/bash"]
