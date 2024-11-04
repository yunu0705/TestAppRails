class Api::InquiriesImageController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    inquiry_image = InquiryImage.new(
      inquiryType: params[:inquiryType],
      userName: params[:userName],
      email: params[:email],
      content: params[:content]
    )

    # スクリーンショットが添付されているかをチェックして添付
    if params[:screenshot].present?
      inquiry_image.screenshot.attach(params[:screenshot])
      screenshot_status = inquiry_image.screenshot.attached? ? "スクリーンショットが正常に添付されました。" : "スクリーンショットの添付に失敗しました。"
      Rails.logger.debug "スクリーンショットの添付状況: #{screenshot_status}"
    else
      screenshot_status = "スクリーンショットは添付されていません。"
    end

    if inquiry_image.save
      Rails.logger.debug "InquiryImageの保存に成功しました: #{inquiry_image.inspect}"
      screenshot_url = inquiry_image.screenshot.attached? ? url_for(inquiry_image.screenshot) : nil

      # サービスクラスを使ってメール送信
      InquiryMailerService.send_emails(params, inquiry_image.screenshot)

      render json: { 
        message: 'お問い合わせが送信されました！', 
        screenshot_status: screenshot_status, 
        screenshot_url: screenshot_url 
      }, status: :created
    else
      Rails.logger.debug "InquiryImageの保存に失敗しました: #{inquiry_image.errors.full_messages.join(', ')}"
      render json: { errors: inquiry_image.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
