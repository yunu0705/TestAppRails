class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token  # CSRFトークンの検証をスキップ（API用）

  def create
    user = User.find_by(landAccount_name: params[:landAccount_name])
    
    if user && user.authenticate(params[:password])
      # ログイン成功時の処理
      render json: { message: 'ログイン成功', user_name: user.landAccount_name }, status: :ok
    else
      # ログイン失敗時の処理
      render json: { error: 'ログイン失敗' }, status: :unauthorized
    end
  end

  def destroy
    reset_session
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  private

  def user_params
    params.permit(:landAccount_name, :password)
  end
end
