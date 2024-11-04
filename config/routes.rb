Rails.application.routes.draw do
  get 'home/index'
  get 'sessions/create'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root 'articles#index'

  # Authentication routes
  get 'register', to: 'registrations#new'  # ここでフォーム表示用のGETルートを追加
  post 'register', to: 'registrations#create'

  post 'login', to: 'sessions#create'

  # APIエンドポイントを `/api` 名前空間で分ける
  namespace :api do
    resources :schedules, only: [:index, :update, :create, :destroy]
    resources :news, only: [:index, :create, :update, :destroy] 
    resource :template_settings, only: [:update, :show] 
    resources :inquiries, only: [:create]
    resources :inquiries_image, only: [:create]  # 画像を含むお問い合わせ用のエンドポイントを追加
  end

  # Dashboard route for React
  get '/dashboard', to: 'home#index'  # Reactアプリケーションをロードするルート

  # ログアウト
  delete '/logout', to: 'sessions#destroy'

  # パスワードリセットのルート
  post 'forgot_password', to: 'password_resets#create'  # パスワードリセットメール送信用
  get 'password_resets/:token/edit', to: 'password_resets#edit', as: :edit_password_reset  # トークン付きのURL
  patch 'password_resets/:token', to: 'password_resets#update'  # 新しいパスワード設定用
end
