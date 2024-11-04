class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token  # CSRFトークンの検証をスキップ（API用）

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      UserMailer.registration_confirmation(user).deliver_now  # メールを即時送信
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:landAccount_name, :landEmail_address, :password)
  end  
end
