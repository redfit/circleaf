class UserMailer < ActionMailer::Base
  default from: "info@ishikitakai.com"

  def email_confirmation(user)
    @user = user
    set_locale
    subject = I18n.t("mailer.user.email_confirmation.subject")
    mail(:to => "#{user.name} <#{user.unconfirmed_email}>", subject: "[#{I18n.t('site_info.title')}] #{subject}")
  end

  private
  def set_locale
    I18n.locale = @user.locale if @user.locale
  end
end
