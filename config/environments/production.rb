Rails.application.configure do
  # 他の設定...

  # メールの設定 (さくらレンタルサーバーのSMTPを使用)
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'streamersland.sakura.ne.jp', # さくらのSMTPサーバー
    port: 587,
    domain: 'alc-streamersland.com', # 自分のドメインに変更
    user_name: 'noreply@alc-streamersland.com', # メールアカウントのユーザー名（フルアドレス）
    password: 'DHCf.6RQER7_', # メールアカウントのパスワード
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # メール内で生成されるURLのホスト設定
  config.action_mailer.default_url_options = { host: 'alc-streamersland.com', protocol: 'https' }

  # メール送信エラーを表示
  config.action_mailer.raise_delivery_errors = true

  # 他の設定...
end