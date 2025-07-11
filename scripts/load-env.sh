#!/bin/bash

# 載入環境變數腳本
# 優先從 .env 檔案載入，如果不存在則使用現有環境變數

ENV_FILE=".env"

echo "🔧 載入環境變數..."

# 檢查 .env 檔案是否存在
if [ -f "$ENV_FILE" ]; then
    echo "📁 從 .env 檔案載入環境變數..."
    export $(cat "$ENV_FILE" | grep -v '^#' | xargs)
    echo "✅ 環境變數載入完成"
else
    echo "⚠️ .env 檔案不存在，使用現有環境變數"
fi

# 檢查必要的環境變數
if [ -z "$VERCEL_PROJECT_ID" ]; then
    echo "❌ 警告: VERCEL_PROJECT_ID 未設定"
fi

if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ 警告: VERCEL_TOKEN 未設定"
fi

echo "🔧 環境變數載入完成" 