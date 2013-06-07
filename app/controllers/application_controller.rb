class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale

  private
  def set_locale
    return if Rails.env.test?
    I18n.locale = extract_locale_from_accept_language_header
    update_locale
  end

  def update_locale
    return unless user_signed_in?
    return if current_user.locale == I18n.locale.to_s
    current_user.update_column(:locale, I18n.locale.to_s)
  end

  def extract_locale_from_accept_language_header
    http_accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    if http_accept_language.present?
      http_accept_language.scan(/^[a-z]{2}/).first
    else
      :en
    end
  end
end
