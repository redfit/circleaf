class NotificationMailer < ActionMailer::Base
  layout 'notification_mailer'
  default from: "info@ishikitakai.com"

  def attend_status(user, attendance)
    event = attendance.event
    subject = I18n.t("mailer.notification.attend_status.subject", event_name: event.name)
    send_event_info_to_user(user, event, subject)
  end

  def event_comment(user, comment)
    event = comment.commentable
    subject = I18n.t("mailer.notification.event_comment.subject", event_name: event.name)
    send_event_info_to_user(user, event, subject)
  end

  def event_attendance(user, attendance)
    event = attendance.event
    subject = I18n.t("mailer.notification.event_attendance.subject", event_name: event.name)
    send_event_info_to_user(user, event, subject)
  end

  def group_event(user, event)
    subject = I18n.t("mailer.notification.group_event.subject", group_name: event.group.name)
    send_event_info_to_user(user, event, subject)
  end

  private
  def send_event_info_to_user(user, event, subject)
    @user = user
    @event = event
    set_locale
    mail(:to => "#{@user.name} <#{@user.email}>", subject: subject)
  end

  def set_locale
    I18n.locale = @user.locale if @user.locale
  end
end
