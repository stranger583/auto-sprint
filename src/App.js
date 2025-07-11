import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [environment, setEnvironment] = useState('development');
  const [deployTime, setDeployTime] = useState('');

  useEffect(() => {
    // 從環境變數或 URL 判斷環境
    const hostname = window.location.hostname;
    if (hostname.includes('vercel.app')) {
      if (hostname.includes('-git-')) {
        setEnvironment('beta (preview)');
      } else {
        setEnvironment('delta (production)');
      }
    }

    // 設定部署時間
    setDeployTime(new Date().toLocaleString());
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>🚀 自動化部署測試專案</h1>

        <div className="environment-info">
          <h2>當前環境: <span className="env-badge">{environment}</span></h2>
          <p>部署時間: {deployTime}</p>
        </div>

        <div className="features">
          <h3>功能展示</h3>
          <div className="feature-grid">
            <div className="feature-card">
              <h4>✅ 自動化 Merge</h4>
              <p>每週一自動執行 merge 流程</p>
            </div>
            <div className="feature-card">
              <h4>🔄 多環境部署</h4>
              <p>Beta → Delta 環境自動部署</p>
            </div>
            <div className="feature-card">
              <h4>📝 配置管理</h4>
              <p>YAML 配置檔案管理</p>
            </div>
            <div className="feature-card">
              <h4>🚀 Shell 腳本</h4>
              <p>純 Shell 自動化執行</p>
            </div>
          </div>
        </div>

        <div className="deployment-info">
          <h3>部署資訊</h3>
          <p>Branch: {process.env.REACT_APP_BRANCH || 'main'}</p>
          <p>Commit: {process.env.REACT_APP_COMMIT || 'local'}</p>
          <p>Build Time: {process.env.REACT_APP_BUILD_TIME || 'development'}</p>
        </div>

        <div className="instructions">
          <h3>📋 測試步驟</h3>
          <ol>
            <li>建立 feature 分支</li>
            <li>修改配置檔案</li>
            <li>執行自動化腳本</li>
            <li>觀察部署結果</li>
          </ol>
        </div>
      </header>
    </div>
  );
}

export default App;
