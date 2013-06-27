class Notification::AttendStatus < Notification::Base
  include Notification::EmailSendable

  class << self
    private
    def target(attendance)
      [attendance.user]
    end
  end
end
