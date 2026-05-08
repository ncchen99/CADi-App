# CADi — Flutter 開發任務清單

> **更新日期：** 2026-05-08  
> **狀態標籤：** `[ ]` 待辦　`[~]` 進行中　`[x]` 完成　`[!]` 阻塞（需釐清）

---

## Phase 0：專案初始化

- [ ] **T0-1** 建立 Flutter 專案（`flutter create cadi`）
- [ ] **T0-2** 設定 `pubspec.yaml`：宣告所有 assets（圖片、影片、字體）
- [ ] **T0-3** 建立資料夾結構（`lib/client/`、`lib/family/`、`lib/shared/`）
- [ ] **T0-4** 安裝核心套件：
  - `go_router` — 路由
  - `riverpod` + `hooks_riverpod` — 狀態管理
  - `google_fonts` — Lexend 字體
  - `video_player` — 影片播放
  - `flutter_local_notifications` — 本地推播
  - `table_calendar` — 日曆
  - `flutter_animate` — 動畫
  - `hive` + `hive_flutter` — 本地儲存
- [ ] **T0-5** 建立全域 `ThemeData`（`lib/shared/theme.dart`）：字體、顏色、圓角
- [ ] **T0-6** 確認 Taipei Sans TC Beta 字體取得與授權 `[!]`
- [ ] **T0-7** 設定模式選擇入口（`main.dart`：Client / Family 兩個進入點）

---

## Phase 1：共用元件（Shared）

- [ ] **T1-1** `CadiBottomNavBar` — 底部 Tab Bar（3 Tab，支援 Client/Family 不同 icon）
- [ ] **T1-2** `GlowBackground` — 光球背景 Widget（`光球.png` + 透明度 + BlendMode）
- [ ] **T1-3** `EmotionPicker` — 情緒選擇列（5 種情緒，帶圖片插圖）
- [ ] **T1-4** `CadiAvatar` — 機器人頭像 Widget（可傳入 assetPath）
- [ ] **T1-5** `ChatBubble` — 對話泡泡（左/右兩種方向）
- [ ] **T1-6** `LockScreenNotification` — 鎖屏樣式通知（for Prototype 展示）
- [ ] **T1-7** 建立 `router.dart` — 所有路由定義（go_router）

---

## Phase 2：CLIENT 模式畫面

### 2-A 初始設定（Onboarding）

- [ ] **T2-A1** `OnboardingScreen` — 3 步驟 PageView，底部進度點
- [ ] **T2-A2** `OnboardingStep1` — 文字輸入：「想像一個物品代表你的狀態」
- [ ] **T2-A3** `OnboardingStep2` — 圖片上傳（相簿 / 拍照），使用 `image_picker`
- [ ] **T2-A4** `OnboardingStep3` — 為圖片加說明文字（TextFormField）
- [ ] **T2-A5** `EmotionTagScreen` — 情緒標籤多選（`FilterChip` + 計數顯示）

### 2-B 主畫面

- [ ] **T2-B1** `ClientHomeScreen` — Hi 歡迎頁（`光球機器人.png`，動態入場）
- [ ] **T2-B2** `DailyCheckInScreen` — 今日心情確認（「今天感覺怎麼樣」+ 情緒選項）

### 2-C AI 對話

- [ ] **T2-C1** `ClientChatScreen` — AI 對話介面（ListView + 輸入框）
- [ ] **T2-C2** 對接後端 AI API（HTTP POST，顯示 loading 指示）`[!]`

### 2-D 記憶與日記

- [ ] **T2-D1** `MemoryCalendarScreen` — 月曆視圖（`table_calendar`），點選日期
- [ ] **T2-D2** `DiaryEntryScreen` — 單日記憶詳情（照片 + 文字）
- [ ] **T2-D3** `DiaryAddScreen` — 新增當日記憶（拍照 + 文字）

### 2-E 生命故事典藏

- [ ] **T2-E1** `LifeStoryMenuScreen` — 五大主題選單（使用 `典藏圖示?.png`，垂直滾動）
- [ ] **T2-E2** `LifeStoryTopicScreen` — 單一主題內頁（卡片列表）
- [ ] **T2-E3** `LifeStoryAddScreen` — 新增故事（文字 / 照片 / 語音三種形式）

### 2-F 聆聽療癒

- [ ] **T2-F1** `ListenEntryScreen` — 聆聽入口（`平靜圖.png` 背景 + 開始按鈕）
- [ ] **T2-F2** `ListeningScreen` — 播放中音波動態（`AnimatedContainer` 隨機高度）

### 2-G 勵志動畫

- [ ] **T2-G1** `MotivationAnimScreen` — 圓圈展開動畫（`ScaleTransition` / `flutter_animate`）
- [ ] **T2-G2** `EncouragementCardScreen` — 鼓勵文字全螢幕卡片
  - 考慮以 `時光隧道+鼓勵文字.mp4` 作為底層影片背景

### 2-H 傳記頁

- [ ] **T2-H1** `BiographyScreen` — 個人傳記（`生企圖.png` + 文字區塊）

---

## Phase 3：FAMILY 模式畫面

### 3-A 首頁與狀態

- [ ] **T3-A1** `FamilyHomeScreen` — 家屬首頁（`機器人2d.png` 全身，底部 Tab）
- [ ] **T3-A2** `PatientStatusScreen` — 病人狀態總覽（情緒、位置、時間卡片）
- [ ] **T3-A3** 狀態推播接收（Firebase Cloud Messaging）`[!]`

### 3-B AI 對話

- [ ] **T3-B1** `FamilyChatScreen` — 照護建議 AI 對話（`機器人2d.png` 頭像）
- [ ] **T3-B2** 對接後端 AI API（同 CLIENT，但系統 prompt 為照護者視角）`[!]`

### 3-C 記憶影片

- [ ] **T3-C1** `TunnelVideoScreen` — 全螢幕影片播放（`video_player`，播 `時光隧道.mp4`）
- [ ] **T3-C2** 影片播完後顯示鼓勵卡片或返回首頁

### 3-D 典藏相片牆

- [ ] **T3-D1** `PhotoGalleryScreen` — 兩欄格線（`GridView.count`）
- [ ] **T3-D2** `PhotoFullScreen` — 全螢幕瀏覽（`InteractiveViewer` 支援縮放）

### 3-E 來自病人的信

- [ ] **T3-E1** `PatientLetterScreen` — 全螢幕長文信件（`SingleChildScrollView`，大字排版）

### 3-F 聆聽療癒

- [ ] **T3-F1** `FamilyListenScreen` — 家屬版聆聽入口（`橫式陪看機器人.png`）
- [ ] **T3-F2** `FamilyListeningScreen` — 播放中視覺化

---

## Phase 4：通知系統

- [ ] **T4-1** 設定 `flutter_local_notifications`（iOS 權限申請）
- [ ] **T4-2** CLIENT 每日心情確認定時通知（早上固定時間）
- [ ] **T4-3** FAMILY 病人狀態更新通知（後端推播觸發）
- [ ] **T4-4** 通知點擊後路由至對應畫面

---

## Phase 5：資料層

- [ ] **T5-1** 定義 Hive `dataModel`（EmotionRecord、DiaryEntry、LifeStoryItem）
- [ ] **T5-2** `StorageService` — 封裝本地 Hive 讀寫
- [ ] **T5-3** 初始設定資料持久化（Onboarding 完成後存檔）
- [ ] **T5-4** 後端 API Service（Dio + interceptor）`[!]`

---

## Phase 6：整合測試與打包

- [ ] **T6-1** 完整 CLIENT 流程 E2E 手動測試
- [ ] **T6-2** 完整 FAMILY 流程 E2E 手動測試
- [ ] **T6-3** 實機測試（iPhone，最低 iOS 16）
- [ ] **T6-4** 修正字體顯示問題（Taipei Sans TC 中文顯示確認）
- [ ] **T6-5** 動畫效能確認（60fps，老舊裝置）
- [ ] **T6-6** App Icon 設定（使用 `logo圖.png`）
- [ ] **T6-7** iOS `Info.plist` 設定（相機、相簿、通知、麥克風權限）
- [ ] **T6-8** 打包 TestFlight 測試版

---

## 優先開發順序建議

```
T0 (初始化) → T1 (共用元件)
  → CLIENT: T2-B → T2-C → T2-A → T2-D → T2-E → T2-F → T2-G
  → FAMILY: T3-A → T3-B → T3-C → T3-D → T3-E
  → T4 (通知) → T5 (資料) → T6 (測試打包)
```

**MVP 最小可展示版本（Demo 用）：**
- CLIENT: T2-B1、T2-B2、T2-C1（mock AI）、T2-E1
- FAMILY: T3-A1、T3-A2、T3-C1、T3-E1

---

## 阻塞項目追蹤

| ID | 問題 | 負責人 | 狀態 |
|----|------|--------|------|
| B1 | 後端 AI API endpoint 與 Auth 規格 | 後端 | 待定 |
| B2 | Taipei Sans TC Beta 字體授權 | 設計 | 待確認 |
| B3 | Firebase 專案設定與 FCM 金鑰 | 後端 | 待定 |
| B4 | 病人與家屬帳號綁定機制 | 全端 | 待定 |
| B5 | 「生氣」情緒圖片素材未匯出 | 設計 | 待補充 |
