class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale
  rescue_from Exception, with: :catch_exceptions if Rails.env.production?

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

  def catch_exceptions(e)
    logger.error e.to_yaml
        e.backtrace.each { |line| logger.error line }
    if params[:controller] == "user" && params[:action] == "show"
      render layout: false, file: "#{Rails.root}/public/404", status: 404, format:  :html
    else
      render layout: false, file: "#{Rails.root}/public/500", status: 500, format: :html
    end
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
