#!/bin/bash

# Delta 環境部署腳本 (Vercel)
# 參數: $1 = tag name

# 載入環境變數
source scripts/load-env.sh

TAG_NAME=$1
ENVIRONMENT="delta"

echo "🚀 開始部署到 $ENVIRONMENT 環境..."
echo "Tag: $TAG_NAME"

# Vercel 部署配置 - 從 GitHub Repository secrets 獲取
VERCEL_PROJECT_ID=$VERCEL_PROJECT_ID
VERCEL_TOKEN=$VERCEL_TOKEN

# 檢查環境變數
if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ 錯誤: VERCEL_TOKEN 環境變數未設定"
    echo "請在 GitHub Repository secrets 中設定 VERCEL_TOKEN"
    exit 1
fi

if [ -z "$VERCEL_PROJECT_ID" ]; then
    echo "❌ 錯誤: VERCEL_PROJECT_ID 環境變數未設定"
    echo "請在 GitHub Repository secrets 中設定 VERCEL_PROJECT_ID"
    exit 1
fi

# 部署到 Vercel Production 環境
echo "部署到 Vercel Production 環境..."
curl -X POST "https://api.vercel.com/v1/integrations/deploy/prj_${VERCEL_PROJECT_ID}" \
  -H "Authorization: Bearer ${VERCEL_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{
    \"ref\": \"${TAG_NAME}\",
    \"environment\": \"production\"
  }"

echo "✅ $ENVIRONMENT 環境部署完成"
echo "Tag: $TAG_NAME 已部署到 Vercel Production" 