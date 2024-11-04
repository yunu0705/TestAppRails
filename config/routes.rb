Rails.application.routes.draw do
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication routes
  get 'register', to: 'registrations#new'  # フォーム表示用
  post 'register', to: 'registrations#create'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # APIエンドポイント
  namespace :api do
    resources :schedules, only: [:index, :update, :create, :destroy]
    resources :news, only: [:index, :create, :update, :destroy]
    resource :template_settings, only: [:update, :show]
    resources :inquiries, only: [:create]
    resources :inquiries_image, only: [:create]
  end

  # React のエントリポイント
  get '/dashboard', to: 'home#index'  # Reactアプリケーションをロードするルート

  # パスワードリセットのルート
  post 'forgot_password', to: 'password_resets#create'  # パスワードリセットメール送信用
  get 'password_resets/:token/edit', to: 'password_resets#edit', as: :edit_password_reset  # トークン付きのURL
  patch 'password_resets/:token', to: 'password_resets#update'  # 新しいパスワード設定用

  # Root パスをReactのビューへ変更
  root 'home#index'  # Reactのメインエントリポイントをルートに設定
end
