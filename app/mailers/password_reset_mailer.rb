class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user = params[:user]
    mail(to: @user.landEmail_address, subject: '【ストリーマーズランド】パスワードリセットのご案内')
  end

  def reset_confirmation_email
    @user = params[:user]
    mail(to: @user.landEmail_address, subject: '【ストリーマーズランド】パスワードリセットが完了しました')
  end
end