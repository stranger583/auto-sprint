# Vercel 部署設定指南

## 🚀 快速開始

### 1. 註冊 Vercel 帳號

- 前往 [vercel.com](https://vercel.com)
- 使用 GitHub 帳號註冊 (免費)

### 2. 建立專案

```bash
# 安裝 Vercel CLI
npm i -g vercel

# 登入 Vercel
vercel login

# 在專案目錄初始化
vercel
```

### 3. 取得必要資訊

```bash
# 取得 Project ID
vercel ls

# 取得 Token
# 前往 https://vercel.com/account/tokens
# 建立新的 Token
```

### 4. 設定環境變數

```bash
# 設定環境變數
export VERCEL_PROJECT_ID="your_project_id"
export VERCEL_TOKEN="your_vercel_token"

# 或加入 .env 檔案
echo "VERCEL_PROJECT_ID=your_project_id" >> .env
echo "VERCEL_TOKEN=your_vercel_token" >> .env
```

### 5. 測試部署

```bash
# 測試 beta 部署
bash scripts/deploy-beta.sh "CD-2024-01-15"

# 測試 delta 部署
bash scripts/deploy-delta.sh "CD-2024-01-15"
```

## 📋 環境對應

| 你的環境 | Vercel 環境 | 用途     |
| -------- | ----------- | -------- |
| beta     | preview     | 測試環境 |
| delta    | production  | 正式環境 |

## 🔧 其他免費部署選項

### 2. **Netlify** (也很推薦)

```bash
# Netlify 部署腳本範例
curl -X POST "https://api.netlify.com/api/v1/sites/${SITE_ID}/deploys" \
  -H "Authorization: Bearer ${NETLIFY_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"ref\": \"${TAG_NAME}\"}"
```

### 3. **GitHub Pages** (靜態網站)

```bash
# GitHub Pages 部署
git push origin gh-pages
```

### 4. **Railway** (全端應用)

```bash
# Railway 部署
railway up
```

### 5. **Render** (免費容器)

```bash
# Render 部署
curl -X POST "https://api.render.com/deploy/srv-xxx" \
  -H "Authorization: Bearer ${RENDER_TOKEN}"
```

## 🎯 推薦順序

1. **Vercel** - 最簡單，支援多環境
2. **Netlify** - 功能豐富，免費額度大
3. **GitHub Pages** - 完全免費，適合靜態網站
4. **Railway** - 適合全端應用
5. **Render** - 免費容器部署

## 💡 練習建議

1. 先用 Vercel 練習基本流程
2. 建立一個簡單的 React/Vue 專案
3. 設定 GitHub Actions 自動觸發
4. 測試完整的 1-6 步驟流程
5. 觀察部署結果和環境差異
