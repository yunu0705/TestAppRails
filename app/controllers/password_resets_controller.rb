class PasswordResetsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def create
    user = User.find_by(landEmail_address: params[:password_reset][:email])
    if user
      user.generate_password_reset_token!  # トークン生成
      PasswordResetMailer.with(user: user).reset_email.deliver_later  # メール送信
      render json: { message: 'パスワードリセットのメールを送信しました。' }, status: :ok
    else
      render json: { error: 'メールアドレスが見つかりません。' }, status: :not_found
    end
  end
  

  def edit
    @user = User.find_by(password_reset_token: params[:token])
    if @user && @user.password_reset_token_valid?
      # トークンが有効であればパスワードリセットフォームを表示
    else
      render json: { error: 'トークンが無効です。' }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:token])
    if @user && @user.password_reset_token_valid?
      if @user.update(password_params)
        @user.clear_password_reset_token!  # トークンをクリア

        # リセット完了の確認メールを送信
      PasswordResetMailer.with(user: @user).reset_confirmation_email.deliver_later

        render json: { message: 'パスワードが更新されました。' }, status: :ok
      else
        render json: { error: 'パスワードの更新に失敗しました。' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'このリンクは無効となっております。' }, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
