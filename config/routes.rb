Rails.application.routes.draw do
  # 管理画面（Session認証）
  devise_for :admin_users, path: "admin"
  namespace :admin do
    root to: "dashboard#index"
  end

  # Flutter向けAPI（JWT認証）
  namespace :api do
    namespace :v1 do
      devise_for :users,
        path: "users",
        path_names: {
          sign_in: "sign_in",
          sign_out: "sign_out",
          registration: "sign_up"
        },
        controllers: {
          sessions: "api/v1/auth/sessions",
          registrations: "api/v1/auth/registrations"
        }
    end
  end

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end
