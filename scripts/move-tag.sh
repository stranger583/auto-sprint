#!/bin/bash

# Move Tag 腳本 (純 shell 版本)
# 建立 tag 並觸發部署

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "❌ 請指定環境: ./move-tag.sh <environment>"
    echo "可用環境: beta, delta"
    exit 1
fi

echo "🚀 開始部署到 $ENVIRONMENT 環境..."

# 載入配置
CONFIG_FILE="config/weekly-tasks.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 配置檔案不存在: $CONFIG_FILE"
    exit 1
fi

# 讀取環境配置 (改善的 yaml 解析)
TAG_PREFIX=""
if [ "$ENVIRONMENT" = "beta" ]; then
    TAG_PREFIX=$(grep -A 2 "beta:" "$CONFIG_FILE" | grep "tag:" | sed 's/tag:[[:space:]]*"\([^"]*\)".*/\1/' | tr -d '[:space:]')
elif [ "$ENVIRONMENT" = "delta" ]; then
    TAG_PREFIX=$(grep -A 2 "delta:" "$CONFIG_FILE" | grep "tag:" | sed 's/tag:[[:space:]]*"\([^"]*\)".*/\1/' | tr -d '[:space:]')
else
    echo "❌ 不支援的環境: $ENVIRONMENT"
    exit 1
fi

if [ -z "$TAG_PREFIX" ]; then
    echo "❌ 無法讀取 $ENVIRONMENT 環境的 tag 配置"
    exit 1
fi

# 獲取當前分支
CURRENT_BRANCH=$(git branch --show-current)
echo "當前分支: $CURRENT_BRANCH"

# 建立 tag
TAG_NAME="${TAG_PREFIX}-$(date +%Y-%m-%d)"
echo "建立 tag: $TAG_NAME"

# 刪除舊的 tag (如果存在)
if git tag -l | grep -q "^$TAG_NAME$"; then
    echo "刪除舊的 tag: $TAG_NAME"
    git tag -d "$TAG_NAME"
    git push origin ":refs/tags/$TAG_NAME" 2>/dev/null || true
fi

# 建立新 tag
git tag "$TAG_NAME"
git push origin "$TAG_NAME"

echo "✅ 成功建立並推送 tag: $TAG_NAME"

# 觸發部署
echo "🔄 觸發 $ENVIRONMENT 環境部署..."

# 執行部署腳本 (如果存在)
DEPLOY_SCRIPT="scripts/deploy-${ENVIRONMENT}.sh"
if [ -f "$DEPLOY_SCRIPT" ]; then
    echo "執行部署腳本: $DEPLOY_SCRIPT"
    bash "$DEPLOY_SCRIPT" "$TAG_NAME"
else
    echo "⚠️ 部署腳本不存在: $DEPLOY_SCRIPT"
    echo "請手動處理 $ENVIRONMENT 環境部署"
fi

echo "🎉 $ENVIRONMENT 環境部署流程完成"
