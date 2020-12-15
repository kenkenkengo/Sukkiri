# アプリケーションの概要
家庭内の書類を記録して管理できる書類投稿SNSサービス。<https://sukkiri.herokuapp.com/>

# 技術的ポイント
- **Docker**を使用したコンテナ上での開発
- **Rubocop**を使用したコード規約に沿った開発
- **RSpec**でModel, Request, Systemテスト記述(計202examples)
- **trait**によるRSpecテストデータ生成の場合分け
- **CircleCI**を使用したビルド, テスト, デプロイの自動化
- **GitHub Issues**を活用した擬似チーム開発
- **Ajax**を用いた非同期処理(like登録/unlike登録、コメント登録の切り替え表示)
- **Bootstrap**によるレスポンシブ対応と写真のモーダル表示

# アプリケーションの機能
- 家庭内の書類を投稿
- 画像整形を3パターン用意(CarrierWaveを使用)
- 画像クリックでモーダルによる画像拡大表示
- グループ登録(グループ作成者によって許可されたユーザーのみグループに入室できる)
- like登録(Ajax)
- コメント(Ajax)  
- 通知（like登録 or コメントがあった場合)
- 検索（Ransackを使用)
- 並べ替え
- ログイン認証(deviseを使用)
- モデルに対するバリデーション

# 環境
■フレームワーク  
 Ruby on Rails  
■データベース  
 PostgreSQL
