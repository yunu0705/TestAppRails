class InquiryMailer < ApplicationMailer
  default from: 'noreply@alc-streamersland.com'  # 送信元メールアドレスを設定（ここはオプション）

  def send_inquiry_email
    @inquiry_type = params[:inquiry_type]
    @user_name = params[:user_name]
    @content = params[:content]

    # 添付ファイルがある場合のみ添付
    if params[:screenshot].present?
      # Active Storageからファイルをダウンロードして添付
      attachments[params[:screenshot].filename.to_s] = params[:screenshot].download
      Rails.logger.info "添付ファイルがメールに追加されました: #{params[:screenshot].filename}"
    else
      Rails.logger.info "添付ファイルはありません"
    end

    # サポートチームに送信
    mail(
      from: params[:email],
      to: 'support-stremerland@alc-streamersland.com',
      subject: 'お問い合わせ内容の確認',
      reply_to: params[:email]
    )
  end

  def send_confirmation_to_user
    @inquiry_type = params[:inquiry_type]
    @user_name = params[:user_name]
    @content = params[:content]

    # 添付ファイルがある場合のみ添付
    if params[:screenshot].present?
      attachments[params[:screenshot].filename.to_s] = params[:screenshot].download
    end

    # ユーザーに問い合わせ内容を送信
    mail(
      from: 'noreply@alc-streamersland.com',  # 送信元アドレス（固定が望ましい）
      to: params[:email],               # ユーザーのメールアドレス
      subject: 'お問い合わせ内容のコピー',
      reply_to: 'support-stremerland@alc-streamersland.com'  # サポートへの返信用
    )
  end
end
