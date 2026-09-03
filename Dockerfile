FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only the essentials (curl, unzip) to download the binary
RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download the latest pre-built binary from GitHub Releases
# Replace the URL with the actual latest release asset name if different.
# Check https://github.com/SamNet-dev/MTProxyMax/releases for the correct filename.
RUN curl -L https://github.com/SamNet-dev/MTProxyMax/releases/download/v1.4.0-LTS/mtproxymax-linux-amd64 -o mtproxymax && \
    chmod +x mtproxymax

# Copy your entrypoint script (we'll adjust it)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 443
ENTRYPOINT ["/entrypoint.sh"]
