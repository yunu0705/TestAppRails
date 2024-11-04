class RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token  # CSRFトークンの検証をスキップ（API用）

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      begin
        UserMailer.registration_confirmation(user).deliver_now  # メールを即時送信
        render json: { message: 'User created successfully' }, status: :created
      rescue StandardError => e
        user.destroy
        render json: { errors: ["User created but failed to send confirmation email: #{e.message}"] }, status: :unprocessable_entity
      end
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:landAccount_name, :landEmail_address, :password)
  end  
end
