#!/bin/bash

# 步驟 6: 部署到 delta 環境
# 執行 yarn move-tag delta

set -e

echo "🚀 步驟 6: 部署到 delta 環境..."

# 檢查 yarn 是否安裝
if ! command -v yarn &> /dev/null; then
    echo "❌ Yarn 未安裝"
    exit 1
fi

# 檢查 package.json 是否存在
if [ ! -f "package.json" ]; then
    echo "❌ package.json 不存在"
    exit 1
fi

# 執行 move-tag 腳本
echo "執行 yarn move-tag delta..."
yarn move-tag delta

echo "✅ Delta 環境部署完成" 