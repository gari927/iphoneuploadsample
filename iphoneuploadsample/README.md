# じゃんけんゲーム iOS アプリ

SwiftUI と SwiftData を使用したじゃんけんゲームのiOSアプリです。

## 特徴

- **じゃんけんゲーム**: グー・チョキ・パーでコンピューターと対戦
- **スコア表示**: プレイヤーとコンピューターの勝利数を記録
- **アニメーション**: 結果表示時のスムーズなアニメーション
- **タブナビゲーション**: じゃんけんゲームとアイテムリストの切り替え
- **SwiftData統合**: データ永続化のデモンストレーション

## スクリーンショット

### じゃんけんゲーム
- 手を選択するボタン（グー・チョキ・パー）
- リアルタイムスコア表示
- 勝敗結果の色分け表示
- リセット機能

### アイテムリスト
- SwiftDataを使用したアイテム管理
- タイムスタンプ付きアイテムの追加・削除
- NavigationSplitViewを使用したマスター・ディテール表示

## 技術仕様

- **開発言語**: Swift
- **フレームワーク**: SwiftUI, SwiftData
- **対応OS**: iOS 17.5+
- **アーキテクチャ**: MVVM with SwiftUI

## ファイル構成

```
iphoneuploadsample/
├── iphoneuploadsample/
│   ├── ContentView.swift          # メインUI（じゃんけんゲーム + アイテムリスト）
│   ├── Item.swift                 # SwiftDataモデル
│   ├── iphoneuploadsampleApp.swift # アプリエントリーポイント
│   └── Assets.xcassets/           # アプリアイコンとリソース
├── iphoneuploadsampleTests/        # ユニットテスト
├── iphoneuploadsampleUITests/      # UIテスト
└── CLAUDE.md                      # 開発ガイドライン
```

## セットアップ

### 必要条件
- Xcode 15.0+
- iOS 17.5+ (シミュレーター or 実機)
- macOS Sonoma+

### インストール

1. リポジトリをクローン:
```bash
git clone <repository-url>
cd iphoneuploadsample
```

2. Xcodeでプロジェクトを開く:
```bash
open iphoneuploadsample.xcodeproj
```

3. シミュレーターまたは実機でビルド・実行

## ビルド & 実行

### コマンドライン
```bash
# ビルド
xcodebuild -project iphoneuploadsample.xcodeproj -scheme iphoneuploadsample -destination 'platform=iOS Simulator,name=iPhone 15' build

# テスト実行
xcodebuild test -project iphoneuploadsample.xcodeproj -scheme iphoneuploadsample -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Xcode
1. Xcodeでプロジェクトを開く
2. シミュレーターを選択
3. ⌘+R でビルド・実行

## ゲームルール

### じゃんけん
- グー（✊）、チョキ（✌️）、パー（✋）から選択
- コンピューターがランダムに手を選択
- 勝敗判定:
  - グー > チョキ
  - チョキ > パー  
  - パー > グー
- スコアが自動的に更新される

## アーキテクチャ詳細

### SwiftUI Components
- `RockPaperScissorsView`: じゃんけんゲームのメインUI
- `ItemListView`: SwiftDataを使用したアイテム管理UI
- `ContentView`: タブナビゲーションのルートビュー

### Game Logic
- `Hand`: じゃんけんの手を表すenum
- `GameResult`: 勝敗結果を表すenum
- `RockPaperScissorsGame`: ゲームロジックを処理するstruct

### Data Model
- `Item`: SwiftDataモデル（タイムスタンプ付きアイテム）

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 開発

開発に関する詳細は [CLAUDE.md](CLAUDE.md) を参照してください。