#!/bin/bash

# 執行所有步驟的完整腳本
# 完全用 shell 執行，不依賴 Node.js

set -e

echo "🚀 開始執行週一自動化流程 (純 Shell 版本)..."
echo "=================================="

# 檢查必要工具
echo "檢查環境..."
if ! command -v git &> /dev/null; then
    echo "❌ Git 未安裝"
    exit 1
fi

if ! command -v yarn &> /dev/null; then
    echo "❌ Yarn 未安裝"
    exit 1
fi

# 檢查配置檔案
CONFIG_FILE="config/weekly-tasks.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 配置檔案不存在: $CONFIG_FILE"
    exit 1
fi

echo "✅ 環境檢查完成"

# 步驟 1: 建立 sprint 分支
echo ""
echo "📝 步驟 1: 建立 sprint 分支..."
bash scripts/step-1-create-branches.sh

# 步驟 2: Merge beta 分支
echo ""
echo "🔄 步驟 2: Merge beta 分支..."
bash scripts/step-2-merge-beta.sh

# 步驟 3: 部署到 beta 環境
echo ""
echo "🚀 步驟 3: 部署到 beta 環境..."
bash scripts/step-3-deploy-beta.sh

# 步驟 4: 建立 delta 分支
echo ""
echo "📝 步驟 4: 建立 delta 分支..."
bash scripts/step-4-create-delta.sh

# 步驟 5: Merge delta 分支
echo ""
echo "🔄 步驟 5: Merge delta 分支..."
bash scripts/step-5-merge-delta.sh

# 步驟 6: 部署到 delta 環境
echo ""
echo "🚀 步驟 6: 部署到 delta 環境..."
bash scripts/step-6-deploy-delta.sh

echo ""
echo "=================================="
echo "✅ 週一自動化流程完成！"
echo "==================================" 