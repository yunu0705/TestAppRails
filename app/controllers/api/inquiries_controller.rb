class Api::InquiriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    inquiry = Inquiry.new(
      inquiryType: params[:inquiryType],
      userName: params[:userName],
      email: params[:email],
      content: params[:content]
    )

    if inquiry.save
      # サービスクラスを使ってメール送信
      InquiryMailerService.send_emails(params, inquiry.screenshot)
      render json: { message: 'お問い合わせが送信されました' }, status: :ok
    else
      render json: { errors: inquiry.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
