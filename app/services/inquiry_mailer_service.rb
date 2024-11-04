# app/services/inquiry_mailer_service.rb
class InquiryMailerService
    def self.send_emails(params, screenshot = nil)
      # サポートチームへのメール送信
      Rails.logger.info "サポートチームへのメール送信を開始します"
      InquiryMailer.with(
        inquiry_type: params[:inquiryType],
        user_name: params[:userName],
        email: params[:email],
        content: params[:content],
        screenshot: screenshot
      ).send_inquiry_email.deliver_now
      Rails.logger.info "サポートチームへのメール送信が完了しました"
  
      # ユーザーへのリマインドメール送信
      begin
        Rails.logger.info "ユーザーへのリマインドメール送信を開始します"
        InquiryMailer.with(
          inquiry_type: params[:inquiryType],
          user_name: params[:userName],
          email: params[:email],
          content: params[:content],
          screenshot: screenshot
        ).send_confirmation_to_user.deliver_now
        Rails.logger.info "ユーザーへのリマインドメール送信が完了しました"
      rescue => e
        Rails.logger.error "ユーザーへのリマインドメール送信に失敗しました: #{e.message}"
      end
    end
  end
  