class Notification::EventComment < Notification::Base
  include Notification::EmailSendable

  class << self
    private
    def target(comment)
      event = comment.commentable
      event.users
    end
  end
end
