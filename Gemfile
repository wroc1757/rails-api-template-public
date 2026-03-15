source "https://rubygems.org"

ruby "3.4.9"

# ── Core ──────────────────────────────────────────
gem "rails", "~> 8.1.2"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# ── Ruby 3.4 stdlib 分離対応 ──────────────────────
gem "csv"
gem "ostruct"
gem "logger"

# ── JavaScript / View ─────────────────────────────
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

# ── Solid adapters ────────────────────────────────
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# ── API（Flutter向け） ────────────────────────────
gem "rack-cors"
gem "jsonapi-serializer"

# ── 認証 ──────────────────────────────────────────
gem "devise"
gem "devise-jwt"

# ── ファイルストレージ ─────────────────────────────
gem "aws-sdk-s3", require: false
gem "image_processing", "~> 1.2"

# ── 環境変数 ──────────────────────────────────────
gem "dotenv-rails", groups: [:development, :test]

# ── タイムゾーン ──────────────────────────────────
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
end

group :test do
  gem "shoulda-matchers"
  gem "capybara"
  gem "selenium-webdriver"
end
