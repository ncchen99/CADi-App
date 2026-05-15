# CADi

針對**輕度至中度失智症患者（60+）**及其**主要照護家屬**設計的雙模式陪伴 App，以 CADi AI 機器人作為情感代理，提供情緒陪伴、生命故事保存與照護資訊支援。

> 🎨 **Figma：** https://www.figma.com/design/oVIXroLpoLOUorqNzKC37V/Untitled
> 📱 **目標平台：** Flutter（iOS 優先，次要 Android）
> 🌐 **語言：** 繁體中文

---

## 專案結構

```
CADi/
├── cadi_app/              # Flutter 主專案
│   ├── lib/
│   │   ├── main.dart
│   │   ├── router.dart    # go_router 路由總表
│   │   ├── shared/        # 共用：theme / storage / widgets
│   │   ├── client/        # 病人模式畫面
│   │   └── family/        # 家屬模式畫面
│   ├── assets/
│   │   └── videos/        # 時光隧道.mp4 等動畫素材
│   └── pubspec.yaml
├── assets/                # 設計來源素材
├── design-ref/            # Figma frame 截圖參考（不打包進 App）
├── spec.md                # App 規格文件（含 Figma Node ID 對照）
├── tasks.md               # 開發任務清單
└── user-flow.md           # 使用流程
```

詳細規格與 Figma 對照表請見 [spec.md](spec.md)。

---

## 兩種模式

| 模式 | 入口 | 功能 |
|------|------|------|
| **CLIENT（病人）** | `/client` | Onboarding、每日心情 Check-in、AI 對話、生命故事、記憶日曆、聆聽療癒、勵志動畫 |
| **FAMILY（家屬）** | `/family` | 病人狀態、AI 照護對話、典藏相片牆、來自病人的信、影片回顧 |

App 啟動先進入 `/mode-select`，選擇後寫入 Hive（`AppStorage.lastMode`），下次自動帶入。

---

## 開發環境

| 項目 | 版本 |
|------|------|
| Flutter | 3.35+ |
| Dart | 3.9+ |

### 啟動

```bash
cd cadi_app
flutter pub get
flutter run                # iOS / Android 模擬器
```

### 主要套件

| 用途 | 套件 |
|------|------|
| 路由 | `go_router` |
| 狀態管理 | `flutter_riverpod` + `hooks_riverpod` + `flutter_hooks` |
| 本地儲存 | `hive_flutter` |
| 影片 | `video_player` |
| 動畫 | `flutter_animate` |
| 日曆 | `table_calendar` |
| 字體 | `google_fonts`（Lexend）+ Taipei Sans TC Beta（中文，需自行打包） |

---

## 視覺設計

- **基準尺寸：** 393 × 852（iPhone 14），以 `MediaQuery` 相對縮放
- **主文字色：** `#3A3939`　**背景：** `#FFFFFF`
- **字級：** H1 20 Bold / H2 16 Medium / H3 12 Regular

各畫面視覺以 Figma frame 截圖為依據實作，互動元件以 Flutter widget 疊加。Figma Node ID 對照表見 [spec.md](spec.md#3-figma-圖層對照表)。

---

## 待釐清

| # | 問題 |
|---|------|
| 1 | Taipei Sans TC Beta 商用授權 |
| 2 | 後端 AI API endpoint + auth 規格 |
| 3 | 病人 / 家屬帳號綁定機制 |
| 4 | 典藏相片是否上雲 |
| 5 | 本地資料加密（個資敏感） |
