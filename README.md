# 🚀 自動化部署測試專案

這是一個用於測試自動化部署流程的 React 專案。

## 🎯 專案特色

- ✅ React 18 + 現代化 UI
- ✅ 自動化 Git 分支管理
- ✅ Vercel 多環境部署
- ✅ Shell 腳本自動化
- ✅ GitHub Actions 整合

## 🚀 快速開始

### 1. 安裝依賴

```bash
npm install
```

### 2. 本地開發

```bash
npm start
```

### 3. 測試自動化流程

```bash
# 完整流程
npm run run-all

# 個別步驟
npm run step1  # 建立分支
npm run step2  # Merge beta
npm run step3  # 部署 beta
npm run step4  # 建立 delta
npm run step5  # Merge delta
npm run step6  # 部署 delta
```

## 📋 詳細教學

請參考 [STEP-BY-STEP-GUIDE.md](./STEP-BY-STEP-GUIDE.md) 進行完整的設定和測試。

## 🎨 專案結構

```
test-app/
├── src/                    # React 源碼
│   ├── App.js             # 主應用
│   ├── App.css            # 樣式
│   └── index.js           # 入口
├── scripts/               # 自動化腳本
│   ├── run-all-steps.sh   # 完整流程
│   ├── step-1-*.sh        # 步驟 1-6
│   └── deploy-*.sh        # 部署腳本
├── config/                # 配置檔案
│   └── weekly-tasks.yaml  # 每週任務
├── .github/               # GitHub Actions
└── package.json           # 專案配置
```

## 🌍 環境對應

| 環境  | Vercel 環境 | URL 格式                              |
| ----- | ----------- | ------------------------------------- |
| Beta  | Preview     | `專案名-git-分支名-用戶名.vercel.app` |
| Delta | Production  | `專案名.vercel.app`                   |

## 🔧 配置說明

### weekly-tasks.yaml

```yaml
current_sprint: "2501" # Sprint 編號
beta_branches: # Beta 分支
  - "feat/test-page"
delta_branches: # Delta 分支
  - "fix/update-styles"
environments: # 環境配置
  beta:
    name: "beta"
    tag: "CD"
    vercel_env: "preview"
  delta:
    name: "delta"
    tag: "CD"
    vercel_env: "production"
```

## 🎯 測試流程

1. **建立測試分支**

   ```bash
   git checkout -b feat/test-page
   git push -u origin feat/test-page
   ```

2. **更新配置**

   ```bash
   # 編輯 config/weekly-tasks.yaml
   beta_branches:
     - "feat/test-page"
   ```

3. **執行自動化**

   ```bash
   npm run run-all
   ```

4. **觀察結果**
   - 檢查 Git 分支
   - 查看 Vercel 部署
   - 訪問部署的網站

## 🚨 故障排除

### 常見問題

1. **Vercel Token 無效**

   - 重新生成 Token
   - 檢查環境變數設定

2. **分支不存在**

   - 確保分支已推送到 GitHub
   - 檢查分支名稱拼寫

3. **部署失敗**
   - 檢查 Vercel 專案設定
   - 確認環境變數正確

## 📚 學習資源

- [Vercel 部署指南](./vercel-setup.md)
- [完整教學指南](./STEP-BY-STEP-GUIDE.md)
- [自動化腳本說明](../README.md)

## 🎉 完成測試

完成所有步驟後，你將擁有：

- ✅ 完整的自動化部署流程
- ✅ 多環境部署經驗
- ✅ Shell 腳本開發技能
- ✅ CI/CD 流程理解

現在可以將這個流程應用到你的實際專案中了！
