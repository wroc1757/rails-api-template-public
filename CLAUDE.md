## ベーステンプレートの前提

このプロジェクトは以下のRailsテンプレートをベースにしています。
新しいコードを生成する際は必ずこの構成に沿ってください。

### 技術スタック
- Ruby 3.4.9 / Rails 8.1.2
- PostgreSQL
- Devise + devise-jwt（認証）
- rack-cors（Flutter向けCORS）
- jsonapi-serializer（APIレスポンス）
- ActiveStorage + Cloudflare R2（ファイルストレージ）
- RSpec + FactoryBot + Faker（テスト）
- Render（デプロイ先）

### ルーティング構成
- Flutter向けAPI: `/api/v1/*`（JWT認証）
- 管理画面: `/admin/*`（Session認証）

### 認証の仕様
- FlutterはJWT（devise-jwt）を使用
  - ログイン: `POST /api/v1/users/sign_in`
  - 登録: `POST /api/v1/users/sign_up`
  - ログアウト: `DELETE /api/v1/users/sign_out`
  - 認証済みリクエストは `Authorization: Bearer <token>` ヘッダを付与
- 管理画面はDeviseのSession認証
  - `Admin::BaseController` を継承すると `before_action :authenticate_admin_user!` が効く

### コントローラの規約
- APIコントローラは `Api::V1::` 名前空間
- 管理画面コントローラは `Admin::BaseController` を継承
- APIレスポンスは `jsonapi-serializer` を使用

### モデルの規約
- `User` モデル: JTIMatcher（JWT revocation）込みのDevise設定済み
- `AdminUser` モデル: Deviseのみ（JWTなし）

### ファイルストレージ
- ローカル: ActiveStorage local（Disk）
- 本番: Cloudflare R2（S3互換）
- `has_one_attached` / `has_many_attached` をそのまま使用可能

### テストの規約
- RSpec + FactoryBot
- `spec/factories/` にファクトリを作成
- モデルスペックは `shoulda-matchers` を活用
- APIスペックはrequest specで書く（`spec/requests/api/v1/`）

### 環境変数
- ローカル: `.env.development`
- 本番: Renderダッシュボードで設定
- 新しい環境変数を追加する場合は `.env.development.sample` と `config/render.yaml` の両方に追記

### やってはいけないこと
- `--api` フラグ前提のコードは書かない（通常のRailsアプリ）
- Nginxの設定は不要（Renderがエッジで処理）
- `kamal` / `thruster` は使わない（Render前提）
- 管理画面gemは使わない（administrate / ActiveAdmin）
