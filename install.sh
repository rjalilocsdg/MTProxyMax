#!/bin/bash
set -e

echo "🚀 Starting MTProxyMax binary on Railway..."

# Map Railway's dynamic port
if [ -n "$PORT" ] && [ -z "$PROXY_PORT" ]; then
    export PROXY_PORT="$PORT"
    echo "✅ PROXY_PORT set to $PROXY_PORT"
fi

# Check required variables
if [ -z "$PROXY_DOMAIN" ] || [ -z "$ADMIN_TELEGRAM_ID" ]; then
    echo "❌ ERROR: PROXY_DOMAIN and ADMIN_TELEGRAM_ID must be set!"
    exit 1
fi

echo "📡 Domain: $PROXY_DOMAIN"
echo "🆔 Admin ID: $ADMIN_TELEGRAM_ID"
echo "🔌 Port: $PROXY_PORT"

# Run the binary directly.
# The binary reads these environment variables internally.
exec ./mtproxymax
