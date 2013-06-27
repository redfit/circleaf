class Notification::GroupEvent < Notification::Base
  include Notification::EmailSendable

  class << self
    private
    def target(event)
      event.group.users
    end
  end
end
