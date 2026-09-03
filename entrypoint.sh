#!/bin/bash
set -e

echo "🚀 Starting MTProxyMax deployment on Railway..."

# Critical: Map Railway's dynamic PORT to the proxy's port variable
if [ -n "$PORT" ] && [ -z "$PROXY_PORT" ]; then
    export PROXY_PORT="$PORT"
    echo "✅ PROXY_PORT set to Railway PORT: $PROXY_PORT"
fi

# Check required environment variables
if [ -z "$PROXY_DOMAIN" ] || [ -z "$ADMIN_TELEGRAM_ID" ]; then
    echo "❌ ERROR: PROXY_DOMAIN and ADMIN_TELEGRAM_ID must be set in Railway Variables!"
    exit 1
fi

echo "📡 Domain: $PROXY_DOMAIN"
echo "🆔 Admin ID: $ADMIN_TELEGRAM_ID"
echo "🔌 Port: $PROXY_PORT"

# Run the official install script non-interactively
# It reads PROXY_DOMAIN, ADMIN_TELEGRAM_ID, PROXY_TAG, and PROXY_PORT from the environment
echo "⚙️  Running install.sh..."
sudo bash -c "PROXY_DOMAIN=\"$PROXY_DOMAIN\" \
              ADMIN_TELEGRAM_ID=\"$ADMIN_TELEGRAM_ID\" \
              PROXY_TAG=\"$PROXY_TAG\" \
              PROXY_PORT=\"$PROXY_PORT\" \
              bash ./install.sh"

# The install script usually starts the proxy, but if it exits, we manually take over.
if [ -x "./mtproxymax" ]; then
    echo "✅ Installation complete. Starting MTProxyMax in foreground..."
    exec ./mtproxymax
else
    echo "❌ mtproxymax binary not found. Keeping container alive for logs."
    tail -f /dev/null
fi