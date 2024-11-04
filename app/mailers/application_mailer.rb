class ApplicationMailer < ActionMailer::Base
  default from: "noreply@alc-streamersland.com"
  layout "mailer"

  def test_email
    mail(to: "noreply@alc-streamersland.com", subject: "Test Email", body: "This is a test email.")
  end
end
