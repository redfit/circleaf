class Notification::GroupEvent < Notification::Base
  include Notification::EmailSendable
end
