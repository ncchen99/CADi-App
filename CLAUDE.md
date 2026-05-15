# CADi — Claude 開發守則

雙模式（病人 / 家屬）失智症陪伴 App。Flutter 專案位於 `cadi_app/`，根目錄為設計素材與規格文件。

## 必讀文件

- [spec.md](spec.md) — App 規格、Figma Node ID 對照表、技術選型、待釐清事項
- [user-flow.md](user-flow.md) — 使用流程
- [tasks.md](tasks.md) — 開發任務清單
- `design-ref/` — Figma frame 截圖；實作前先看對應畫面，不打包進 App

## 專案結構約定

```
cadi_app/lib/
├── main.dart
├── router.dart               # 所有路由集中於此（go_router）
├── shared/                   # 雙模式共用：theme / storage / widgets
├── client/screens/           # 病人模式畫面（檔名對應 spec 畫面 ID 註解）
├── client/widgets/
├── family/screens/           # 家屬模式畫面
└── family/widgets/
```

- **新增畫面：** 放入對應的 `client/screens/` 或 `family/screens/`，並在 `lib/router.dart` 註冊路由。路徑慣例：`/client/...` 或 `/family/...`。
- **共用元件**（聊天泡泡、底部 nav、TabBar 等）放 `shared/widgets/`；模式專屬 chrome（如 `client_chrome.dart`、`family_chrome.dart`）放各自的 `widgets/`。
- **本地儲存**統一走 `shared/storage/app_storage.dart`（Hive）。模式選擇、onboarding 狀態都從這裡讀寫。

## 程式碼風格

- **狀態管理：** Riverpod 2.x（含 `hooks_riverpod` + `flutter_hooks`）；不要混入 Provider / BLoC / setState 之外的方案。
- **路由：** 只用 `go_router`，所有路由集中於 `lib/router.dart`。新畫面在這裡加 `GoRoute`，不要在畫面內自行 `Navigator.push`。
- **色彩 / 字級：** 用 `shared/theme/app_theme.dart` 提供的 token，不要散落硬編碼顏色（主色 `#3A3939`、背景 `#FFFFFF`）。
- **尺寸：** 基準 393×852，用 `MediaQuery` 相對縮放，不要寫死絕對 px。
- **字體：** 英數 / 標題用 `google_fonts` 的 Lexend；中文用 Taipei Sans TC Beta（透過 pubspec 打包）。
- **語言：** UI 文案一律繁體中文。

## Figma 對應

每個畫面對應一個 Figma Node ID（見 [spec.md §3](spec.md#3-figma-圖層對照表)）。實作畫面時：

1. 先看 `design-ref/` 對應截圖或 Figma frame
2. 視覺以截圖為準，互動元件（按鈕、輸入框、TabBar）以 Flutter widget 實作疊加
3. 需匯出新圖時從 Figma 對應 Node 匯出

**唯一本地引用的動畫素材：** `assets/videos/時光隧道.mp4`（A13–A14、N2 勵志動畫使用）。

## 不要做

- 不要新增 Markdown 文件（README、設計筆記、planning doc）除非用戶要求
- 不要改 `lib/router.dart` 以外的地方做導航
- 不要硬編碼顏色 / 字級 / 字體，繞過 `shared/theme/`
- 不要在 `assets/videos/` 之外引用本地媒體素材（其餘畫面從 Figma 匯出）
- 不要碰 `build/`、`.dart_tool/`、`ios/Pods/` 等產出物

## 常用指令

```bash
cd cadi_app
flutter pub get
flutter run
flutter analyze        # lint（flutter_lints）
flutter test
```

## 待釐清（影響架構決策時先問用戶）

- 後端 AI API（endpoint / auth）
- 病人 ↔ 家屬帳號綁定機制
- 典藏相片上雲與否
- 本地資料是否加密（個資敏感）
