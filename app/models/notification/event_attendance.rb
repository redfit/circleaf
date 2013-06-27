class Notification::EventAttendance < Notification::Base
  include Notification::EmailSendable

  class << self
    private
    def target(attendance)
      event = attendance.event
      event.attend_users.order('updated_at DESC').offset(1)
    end
  end
end
