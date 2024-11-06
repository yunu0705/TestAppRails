class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token  # CSRFトークンの検証をスキップ（API用）

  def create
    user = User.find_by(landAccount_name: params[:landAccount_name])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # セッションにユーザーIDを保存
      render json: { message: 'ログイン成功', user_name: user.landAccount_name }, status: :ok
    else
      render json: { error: 'ログイン失敗: ユーザー名またはパスワードが間違っています' }, status: :unauthorized
    end
  end

  def destroy
    reset_session
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  # ログイン状態を確認するエンドポイント
  def check_login
    if session[:user_id] && current_user
      render json: { logged_in: true, user_name: current_user.landAccount_name }, status: :ok
    else
      render json: { logged_in: false }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:landAccount_name, :password)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
