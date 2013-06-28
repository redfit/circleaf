class UserMailer < ActionMailer::Base
  default from: "info@ishikitakai.com"

  def email_confirmation(user)
    @user = user
    set_locale
    mail(:to => "#{user.name} <#{user.unconfirmed_email}>", :subject => "Confirm your email address")
  end

  private
  def set_locale
    I18n.locale = @user.locale if @user.locale
  end
end
