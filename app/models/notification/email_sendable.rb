module Notification::EmailSendable
  extend ActiveSupport::Concern
  module ClassMethods
    def notify(trigger)
      super(trigger)
      users = target(trigger)
      users.each do|user|
        method_name = self.to_s.split('::')[1].underscore
        user_setting_column_name = "mail_#{method_name}"
        if user.email.present? && user.setting.send(user_setting_column_name)
          NotificationMailer.send(method_name, user, trigger).deliver
        end
      end
    end
  end
end
