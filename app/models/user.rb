class User < ApplicationRecord
  # パスワードのセキュリティを強化するための設定
  has_secure_password

  # バリデーションルールの設定
  validates :landAccount_name, presence: true, length: { minimum: 3, maximum: 10 }, format: { with: /\A[a-zA-Z0-9]+\z/, message: "は半角英数字のみ使用できます" }, uniqueness: { message: "同じユーザー名があります。別のユーザー名に変えて下さい" }
  validates :landEmail_address, presence: true, uniqueness: { message: "このメールアドレスは既に登録されています" }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8, maximum: 10 }, if: -> { password.present? }

  # パスワードリセットトークンを生成し、送信時間を記録
  def generate_password_reset_token!
    update!(
      password_reset_token: SecureRandom.urlsafe_base64,  # ランダムトークン生成
      password_reset_sent_at: Time.current  # トークン発行時間を記録
    )
  rescue ActiveRecord::RecordInvalid => e
    # エラー処理: エラーメッセージのログや通知などを行う
    Rails.logger.error "Failed to generate password reset token: #{e.message}"
  end

  # トークンが24時間以内に発行されているか確認
  def password_reset_token_valid?
    password_reset_sent_at.present? && (password_reset_sent_at + 24.hours) > Time.current
  end

  # パスワードリセットトークンをクリア（リセット完了後）
  def clear_password_reset_token!
    update!(
      password_reset_token: nil,
      password_reset_sent_at: nil
    )
  rescue ActiveRecord::RecordInvalid => e
    # エラー処理: エラーメッセージのログや通知などを行う
    Rails.logger.error "Failed to clear password reset token: #{e.message}"
  end
end
