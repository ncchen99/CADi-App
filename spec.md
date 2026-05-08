# CADi — App 規格文件

> **版本：** v0.2  
> **更新日期：** 2026-05-08  
> **目標平台：** Flutter（iOS 優先，次要 Android）  
> **Figma：** https://www.figma.com/design/oVIXroLpoLOUorqNzKC37V/Untitled  
> **開發策略：** 直接截取 Figma frame 截圖作為頁面視覺依據建構；互動元件（按鈕、輸入框、導航列）以 Flutter widget 實作疊加

---

## 1. 專案概覽

**CADi** 是一款針對失智症患者（Client）與其家屬（Family）設計的雙模式陪伴 App。

| 面向 | 描述 |
|------|------|
| 目標族群 | 輕度至中度失智症患者（60+）及其主要照護家屬 |
| 核心價值 | 情緒陪伴、生命故事保存、照護資訊支援 |
| 互動核心 | CADi AI 機器人作為情感代理 |
| 語言 | 繁體中文為主 |

---

## 2. App 架構

### 2.1 兩種模式

```
App 啟動
  ├── 選擇「病人模式」 → CLIENT（lib/client/）
  └── 選擇「家屬模式」 → FAMILY（lib/family/）
```

### 2.2 資料夾結構

```
cadi_app/
├── assets/
│   └── videos/
│       └── 時光隧道.mp4        # 唯一需要本地引用的素材
├── lib/
│   ├── main.dart
│   ├── shared/
│   │   ├── theme.dart
│   │   └── widgets/
│   ├── client/
│   │   ├── screens/
│   │   └── client_router.dart
│   └── family/
│       ├── screens/
│       └── family_router.dart
└── design-ref/                 # Figma 截圖參考（不打包進 App）
    ├── client/
    └── family/
```

---

## 3. Figma 圖層對照表

> **所有視覺元素直接取自 Figma，以下記錄各畫面對應的 Figma Node ID，**  
> **需要匯出圖片時請從 Figma 直接匯出對應 frame。**

### 3.1 CLIENT 模式畫面

| 畫面 ID | Figma Node | 說明 |
|--------|-----------|------|
| A1 | `1:1098` | 啟動畫面 — 光球背景 + 通知 |
| A2 | `1:1130` | 初始設定① — 「想像一個物品」 |
| A3 | `1:1135` | 初始設定② — 上傳圖片 |
| A4 | `1:1143` | 初始設定③ — 加說明文字 |
| A5 | `1:938` | 情緒標籤選擇 |
| A6 | `1:1082` | 主畫面 — Hi 歡迎 |
| A7 | `1:1162` | 今日心情確認 |
| A8 | `1:906` | 記憶日曆 |
| A9 | `1:750` | 生命故事選單（五大主題）|
| A10 | `1:832`、`1:871` | AI 對話 |
| A11 | `1:764` | 聆聽療癒入口 |
| A12 | `1:796` | 聆聽中 |
| A13–A14 | ⬇️ 見下方 | 勵志動畫（使用 mp4 替代）|
| A15 | `1:256` | 鎖定畫面通知 |
| A16 | `1:302` | 完整日曆頁 |
| A17 | `1:1055` | 傳記頁 |

#### 勵志動畫（A13–A14）— 使用本地影片取代 Figma 靜態設計

Figma 中的 Frame `1:1683`（Frame 65）、`1:1694`（Frame 76）、`1:1226`（Frame 57）、`1:1230`（Frame 58）為動畫設計稿，已轉存為：

```
assets/videos/時光隧道.mp4
```

**此影片為 App 中唯一需要本地引用的素材。** 其餘畫面的視覺元素皆應從 Figma 對應 Node ID 匯出。

### 3.2 FAMILY 模式畫面

| 畫面 ID | Figma Node | 說明 |
|--------|-----------|------|
| B1 | `158:650` | 家屬首頁 |
| B2 | `1:1384` | 病人狀態總覽 |
| B3 | `1:1706`、`1:1726` | 記憶空間視覺化 |
| B5 | `1:1437`、`1:1409` | AI 對話（照護建議）|
| B6 | `1:1484` | 聆聽療癒入口 |
| B7 | `1:1538` | 聆聽中 |
| B8 | `1:698` | 典藏相片牆 |
| B9 | `1:1012`、`1:996` | 相片全螢幕 |
| B10 | `1:1020` | 來自病人的信 |
| B11 | `1:956` | 鎖定畫面通知 |

### 3.3 共用元件

| 元件 | Figma Node | 說明 |
|------|-----------|------|
| 情緒選擇列 | `1:1643` | 開心／驚訝／生氣／平靜／難過 + 對應插圖 |
| Client Tab Bar | `1:1605` | 3 Tab 變體 |
| Family Tab Bar | `1:1592` | 3 Tab 變體 |

---

## 4. 視覺設計規格

### 4.1 字體

| 用途 | 字體 |
|------|------|
| 主要中文 | `Taipei Sans TC Beta`（需自行取得並打包）|
| 英數 / 標題 | `Lexend`（Google Fonts）|

### 4.2 文字樣式

| 層級 | 大小 | 字重 |
|------|------|------|
| Heading 1 | 20px | Bold |
| Heading 2 | 16px | Medium |
| Heading 3 | 12px | Regular |

### 4.3 色彩

| 名稱 | 色碼 |
|------|------|
| Primary Text | `#3A3939` |
| Background | `#FFFFFF` |

### 4.4 設計尺寸

- 基準：393 × 852 px（iPhone 14）
- Flutter 一律使用 `MediaQuery` 相對縮放

---

## 5. 核心功能規格

### 5.1 CLIENT 模式

| 功能 | 說明 |
|------|------|
| Onboarding（A2–A5）| 3 步 PageView + 情緒 FilterChip |
| 每日 Check-in（A7）| 情緒選擇 → AI 對話或主畫面 |
| AI 對話（A10）| ListView 對話泡泡 + 文字輸入，接後端 LLM |
| 生命故事（A9）| 五大主題，各主題下可新增文字／照片／語音 |
| 記憶日曆（A8）| table_calendar + 單日記憶詳情 |
| 聆聽療癒（A11–A12）| 全螢幕音波動畫 + 音頻播放 |
| 勵志動畫（A13–A14）| 播放 `時光隧道.mp4`（video_player）|

### 5.2 FAMILY 模式

| 功能 | 說明 |
|------|------|
| 病人狀態（B2）| 情緒／位置／時間卡片，FCM 即時更新 |
| AI 對話（B5）| 同 CLIENT，system prompt 為照護者視角 |
| 相片牆（B8–B9）| 兩欄 GridView + InteractiveViewer 全螢幕 |
| 來自病人的信（B10）| 全螢幕長文，SingleChildScrollView |

---

## 6. 技術選型

| 項目 | 選擇 |
|------|------|
| 框架 | Flutter 3.35 / Dart 3.9 |
| 狀態管理 | Riverpod 2.x |
| 路由 | go_router |
| 本地儲存 | Hive |
| 影片播放 | video_player |
| 日曆 | table_calendar |
| 動畫 | flutter_animate |
| 通知 | flutter_local_notifications + FCM |
| 字體 | google_fonts（Lexend）|

---

## 7. 影片素材使用（Flutter）

```dart
// pubspec.yaml
flutter:
  assets:
    - assets/videos/時光隧道.mp4

// motivation_screen.dart
final _controller = VideoPlayerController.asset('assets/videos/時光隧道.mp4')
  ..initialize().then((_) {
    _controller.play();
    setState(() {});
  });
```

---

## 8. 待釐清事項

| # | 問題 | 優先 |
|---|------|------|
| 1 | Taipei Sans TC Beta 授權（商用打包）| 高 |
| 2 | 後端 AI API endpoint + auth 規格 | 高 |
| 3 | 病人與家屬帳號綁定機制 | 高 |
| 4 | 典藏相片是否上傳雲端 | 中 |
| 5 | 本地資料是否需加密（個資敏感）| 高 |
