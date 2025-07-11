#!/bin/bash

# 步驟 5: Merge delta 分支
# 把指定分支 merge 進 delta/sprint-{yy}XX

set -e

echo "🔄 步驟 5: Merge delta 分支..."

# 載入配置
CONFIG_FILE="config/weekly-tasks.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 配置檔案不存在: $CONFIG_FILE"
    exit 1
fi

# 讀取 sprint 編號 (改善的 yaml 解析)
SPRINT_NUMBER=$(grep "current_sprint:" "$CONFIG_FILE" | sed 's/current_sprint:[[:space:]]*"\([^"]*\)".*/\1/')
DELTA_BRANCH="delta/sprint-${SPRINT_NUMBER}"

echo "Delta 分支: $DELTA_BRANCH"

# 切換到 delta 分支
git checkout "$DELTA_BRANCH"

# 讀取要 merge 的 delta 分支列表
echo "讀取要 merge 的 delta 分支..."
DELTA_BRANCHES=()
while IFS= read -r line; do
    if [[ $line =~ ^[[:space:]]{2}-[[:space:]]*\"([^\"]+)\" ]]; then
        branch="${BASH_REMATCH[1]}"
        DELTA_BRANCHES+=("$branch")
    fi
done < <(sed -n '/delta_branches:/,/^[^[:space:]]/p' "$CONFIG_FILE" | grep "  -")

if [ ${#DELTA_BRANCHES[@]} -eq 0 ]; then
    echo "⚠️ 沒有找到要 merge 的 delta 分支"
    exit 0
fi

echo "要 merge 的 delta 分支:"
for branch in "${DELTA_BRANCHES[@]}"; do
    echo "  - $branch"
done

# 逐一 merge 分支
for branch in "${DELTA_BRANCHES[@]}"; do
    echo ""
    echo "正在 merge $branch 到 $DELTA_BRANCH..."
    
    # 確保分支存在
    git fetch origin "$branch"
    
    # Merge 分支
    if git merge "origin/$branch" --no-edit; then
        echo "✅ 成功 merge $branch"
    else
        echo "❌ Merge $branch 失敗"
        exit 1
    fi
done

# Push 更新
echo ""
echo "推送更新到遠端..."
git push origin "$DELTA_BRANCH"

echo "✅ Delta 分支 merge 完成"
