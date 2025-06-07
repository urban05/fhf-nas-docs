#!/bin/bash
WEBHOOK_URL="https://discord.com/api/webhooks/[URL]"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
MESSAGE=$1

curl -H "Content-Type: application/json" \
     -X POST \
     -d "{\"content\": \"$TIMESTAMP — $MESSAGE\"}" \
     $WEBHOOK_URL
