# 🚀 自動化部署測試 - 完整教學指南

這是一個完整的教學指南，讓你一步一步設定並測試自動化部署流程。

## 📋 前置需求

- ✅ Git 已安裝
- ✅ Node.js 已安裝
- ✅ GitHub 帳號
- ✅ Vercel 帳號 (免費註冊)

## 🎯 目標

完成這個教學後，你將能夠：

- 設定 Vercel 自動部署
- 測試完整的 1-6 步驟自動化流程
- 觀察 beta/delta 環境的差異
- 理解自動化部署的完整流程

---

## 📝 步驟 1: 準備 GitHub 專案

### 1.1 建立 GitHub Repository

```bash
# 在 GitHub 建立新的 repository
# 名稱: test-automation-app
# 設為 Public (免費功能)
```

### 1.2 推送專案到 GitHub

```bash
cd auto-sprint
git init
git add .
git commit -m "Initial commit: React automation test app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/test-automation-app.git
git push -u origin main
```

**替換變數：**

- `YOUR_USERNAME` → 你的 GitHub 用戶名

---

## 📝 步驟 2: 設定 Vercel 部署

### 2.1 註冊 Vercel

1. 前往 [vercel.com](https://vercel.com)
2. 使用 GitHub 帳號註冊
3. 完成註冊流程

### 2.2 建立 Vercel 專案

```bash
# 安裝 Vercel CLI
npm i -g vercel

# 登入 Vercel
vercel login

# 在專案目錄初始化
cd auto-sprint
vercel
```

**設定選項：**

- Project name: `test-automation-app`
- Directory: `./` (當前目錄)
- Override settings: `No`

### 2.3 取得必要資訊

```bash
# 取得 Project ID
vercel ls

# 記錄下 Project ID (例如: prj_abc123...)
```

### 2.4 取得 Vercel Token

1. 前往 [vercel.com/account/tokens](https://vercel.com/account/tokens)
2. 點擊 "Create Token"
3. 名稱: `automation-test`
4. 選擇 "Full Account" 權限
5. 複製 Token

---

## 📝 步驟 3: 更新配置檔案

### 3.1 更新專案名稱

```bash
# 編輯 package.json
"name": "test-automation-app"
```

### 3.2 更新 Vercel 配置

```bash
# 編輯 config/weekly-tasks.yaml
vercel:
  project_id: "你的ProjectID"  # 從步驟 2.3 取得
  token: "你的VercelToken"     # 從步驟 2.4 取得
```

### 3.3 設定環境變數

```bash
# 建立 .env 檔案
echo "VERCEL_PROJECT_ID=你的ProjectID" > .env
echo "VERCEL_TOKEN=你的VercelToken" >> .env

# 或直接設定環境變數
export VERCEL_PROJECT_ID="你的ProjectID"
export VERCEL_TOKEN="你的VercelToken"
```

---

## 📝 步驟 4: 建立測試分支

### 4.1 建立 feature 分支

```bash
# 建立測試分支
git checkout -b feat/test-page
git push -u origin feat/test-page

# 建立另一個測試分支
git checkout -b fix/update-styles
git push -u origin fix/update-styles
```

### 4.2 更新配置檔案

```bash
# 編輯 config/weekly-tasks.yaml
current_sprint: "2501"

beta_branches:
  - "feat/test-page"

delta_branches:
  - "fix/update-styles"
```

---

## 📝 步驟 5: 測試自動化流程

### 5.1 測試單一步驟

```bash
# 測試步驟 1: 建立分支
yarn step1

# 測試步驟 2: Merge beta
yarn step2

# 測試步驟 3: 部署 beta
yarn step3

# 測試步驟 4: 建立 delta
yarn step4

# 測試步驟 5: Merge delta
yarn step5

# 測試步驟 6: 部署 delta
yarn step6
```

### 5.2 測試完整流程

```bash
# 執行完整流程
yarn run-all
```

---

## 📝 步驟 6: 觀察結果

### 6.1 檢查 Git 分支

```bash
# 查看所有分支
git branch -a

# 應該看到：
# - beta/sprint-2501
# - delta/sprint-2501
```

### 6.2 檢查 Vercel 部署

1. 前往 [vercel.com/dashboard](https://vercel.com/dashboard)
2. 點擊你的專案
3. 查看 Deployments 頁面
4. 應該看到兩個部署：
   - Preview (beta 環境)
   - Production (delta 環境)

### 6.3 訪問部署的網站

- **Beta 環境**: `https://你的專案名-git-feat-test-page-你的用戶名.vercel.app`
- **Delta 環境**: `https://你的專案名.vercel.app`

---

## 📝 步驟 7: 設定 GitHub Actions

### 7.1 推送配置到 GitHub

```bash
git add .
git commit -m "Add automation scripts and config"
git push origin main
```

### 7.2 檢查 GitHub Actions

1. 前往你的 GitHub repository
2. 點擊 "Actions" 標籤
3. 應該看到 "Weekly Automation" workflow
4. 可以手動觸發測試

---

## 🎯 預期結果

完成所有步驟後，你應該看到：

### ✅ Git 分支結構

```
main
├── beta/sprint-2501 (包含 feat/test-page)
└── delta/sprint-2501 (包含 feat/test-page + fix/update-styles)
```

### ✅ Vercel 部署

- **Preview 環境**: 顯示 "beta (preview)" 標籤
- **Production 環境**: 顯示 "delta (production)" 標籤

### ✅ 自動化流程

- 每週一早上 9:00 自動執行
- 支援手動觸發
- 完整的錯誤處理

---

## 🚨 故障排除

### 常見問題

1. **Vercel Token 無效**

   ```bash
   # 重新生成 Token
   # 前往 vercel.com/account/tokens
   ```

2. **分支不存在**

   ```bash
   # 確保分支已推送到 GitHub
   git push -u origin feat/test-page
   ```

3. **部署失敗**

   ```bash
   # 檢查環境變數
   echo $VERCEL_PROJECT_ID
   echo $VERCEL_TOKEN
   ```

4. **Git 權限問題**
   ```bash
   # 設定 Git 用戶資訊
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

---

## 🎉 完成！

恭喜！你已經成功設定並測試了完整的自動化部署流程。

### 下一步

- 修改 React 應用內容
- 測試不同的分支組合
- 自定義部署腳本
- 整合到實際專案

### 學習重點

- ✅ Git 分支管理
- ✅ Shell 腳本自動化
- ✅ CI/CD 流程
- ✅ 多環境部署
- ✅ 配置管理

現在你可以將這個流程應用到你的實際專案中了！
