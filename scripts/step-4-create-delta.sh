#!/bin/bash

# 步驟 4: 建立 delta sprint 分支
# 從 beta/sprint-{yy}XX 開出 delta/sprint-{yy}XX

set -e

echo "📝 步驟 4: 建立 delta sprint 分支..."

# 載入配置
CONFIG_FILE="config/weekly-tasks.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 配置檔案不存在: $CONFIG_FILE"
    exit 1
fi

# 讀取 sprint 編號 (改善的 yaml 解析)
SPRINT_NUMBER=$(grep "current_sprint:" "$CONFIG_FILE" | sed 's/current_sprint:[[:space:]]*"\([^"]*\)".*/\1/')
BETA_BRANCH="beta/sprint-${SPRINT_NUMBER}"
DELTA_BRANCH="delta/sprint-${SPRINT_NUMBER}"

echo "Sprint 編號: $SPRINT_NUMBER"
echo "Beta 分支: $BETA_BRANCH"
echo "Delta 分支: $DELTA_BRANCH"

# 從 beta sprint 分支建立 delta sprint 分支
echo "從 beta sprint 分支建立 delta sprint 分支..."
git checkout "$BETA_BRANCH"
git checkout -b "$DELTA_BRANCH"
git push -u origin "$DELTA_BRANCH"

echo "✅ 已建立分支: $DELTA_BRANCH"
