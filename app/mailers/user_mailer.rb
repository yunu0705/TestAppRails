class UserMailer < ApplicationMailer
  default from: "noreply@alc-streamersland.com"

  def registration_confirmation(user)
    @user = user
    mail(
      to: @user.landEmail_address, 
      subject: "【ストリーマーズランド】ユーザー登録が完了しました", 
      content_type: "text/html"
    )
  end
end
