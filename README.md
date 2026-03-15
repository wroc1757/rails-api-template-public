# Rails テンプレート セットアップガイド

## 概要

| 項目 | 内容 |
|---|---|
| Ruby | 3.4.9 |
| Rails | ~> 8.1.2 |
| DB | PostgreSQL |
| デプロイ | Render |
| ファイルストレージ | Cloudflare R2（ローカルはDisk） |
| 認証 | Devise + devise-jwt（Flutter向けJWT / 管理画面はSession） |
| 管理画面 | `/admin` 名前空間の骨格のみ（gemなし） |

## 新規プロジェクトの作り方

1. GitHubで「Use this template」→ 新しいリポジトリを作成
2. ローカルにclone
3. アプリ名を一括置換（`config/application.rb` / `config/render.yaml` / `config/database.yml`）
4. `rm config/credentials.yml.enc config/master.key && rails credentials:edit` で master.key を再生成
5. `bundle install`
6. `.env.development.sample` を `.env.development` にコピーして編集
7. `bin/rails db:create db:migrate db:seed`
8. `bin/rails server`

## ローカル起動
```bash
cp .env.development.sample .env.development
# DATABASE_URL を自分の環境に合わせて編集
bin/rails db:create db:migrate db:seed
bin/rails server
```

## Renderデプロイ

以下の環境変数をRenderダッシュボードで手動設定：

| 変数名 | 説明 |
|---|---|
| `RAILS_MASTER_KEY` | `config/master.key` の中身 |
| `DATABASE_URL` | RenderのPostgreSQL Internal URL |
| `ALLOWED_ORIGINS` | 本番ドメイン |
| `R2_ACCESS_KEY_ID` | Cloudflare R2 APIトークン |
| `R2_SECRET_ACCESS_KEY` | 同上 |
| `R2_BUCKET` | バケット名 |
| `R2_ENDPOINT` | `https://<account_id>.r2.cloudflarestorage.com` |

## 認証
```
Flutter  →  POST /api/v1/users/sign_in   →  JWT発行
Flutter  →  DELETE /api/v1/users/sign_out →  JWTログアウト
Flutter  →  POST /api/v1/users/sign_up   →  新規登録
管理画面  →  /admin/sign_in              →  Session認証
```

## 管理画面の拡張
```ruby
# Admin::BaseController を継承するだけで認証が効く
module Admin
  class UsersController < BaseController
    def index
      @users = User.all
    end
  end
end
```

## ヘルスチェック
```
GET /up → 200 OK（緑画面）
```
