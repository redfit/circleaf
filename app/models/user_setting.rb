class UserSetting < ActiveRecord::Base
  belongs_to :user
  after_initialize :set_default

  private
  def set_default
    return self.persisted?
    self.mail_attend_status = true
    self.mail_event_comment =  true
    self.mail_event_attendance = true
    self.mail_group_event = true
  end
end
