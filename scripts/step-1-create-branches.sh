#!/bin/bash

# 步驟 1: 建立 sprint 分支
# 從 master 開出 beta/sprint-{yy}XX 分支

set -e

echo "📝 步驟 1: 建立 sprint 分支..."

# 載入配置
CONFIG_FILE="config/weekly-tasks.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 配置檔案不存在: $CONFIG_FILE"
    exit 1
fi

# 讀取 sprint 編號 (改善的 yaml 解析)
SPRINT_NUMBER=$(grep "current_sprint:" "$CONFIG_FILE" | sed 's/current_sprint:[[:space:]]*"\([^"]*\)".*/\1/')
if [ -z "$SPRINT_NUMBER" ]; then
    echo "❌ 無法讀取 sprint 編號"
    exit 1
fi

BETA_BRANCH="beta/sprint-${SPRINT_NUMBER}"

echo "Sprint 編號: $SPRINT_NUMBER"
echo "Beta 分支: $BETA_BRANCH"

# 確保在 master 分支
echo "切換到 master 分支..."
git checkout master
git pull origin master

# 建立 beta sprint 分支
echo "建立 beta sprint 分支..."
git checkout -b "$BETA_BRANCH"
git push -u origin "$BETA_BRANCH"

echo "✅ 已建立分支: $BETA_BRANCH"
