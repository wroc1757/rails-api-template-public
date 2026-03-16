# Rails API Template

Ruby on Rails による MVP 開発用テンプレートです。

## 技術スタック

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
3. アプリ名を一括置換
   - `config/application.rb` — モジュール名
   - `config/render.yaml` — `<app-name>` を置換
   - `config/database.yml` — DB名
4. master.key を再生成
```bash
   rm config/credentials.yml.enc
   rails credentials:edit
```
5. 環境変数を設定
```bash
   cp .env.development.sample .env.development
   # DATABASE_URL / DEVISE_JWT_SECRET_KEY を編集
```
6. DB作成・起動
```bash
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

## 認証エンドポイント
```
POST   /api/v1/users/sign_in    # ログイン（JWTを Authorization ヘッダで返す）
DELETE /api/v1/users/sign_out   # ログアウト
POST   /api/v1/users/sign_up    # 新規登録
GET    /admin/sign_in           # 管理画面ログイン（Session認証）
```

## ヘルスチェック
```
GET /up → 200 OK
```
