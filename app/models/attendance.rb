class Attendance < ActiveRecord::Base
  include Authority::Abilities
  authorizer_name = :AttendanceAuthorizer

  extend Enumerize
  extend ActiveModel::Naming
  STATUSES = [:attend, :pending, :cancel].freeze
  enumerize :status, in: self::STATUSES

  belongs_to :event
  belongs_to :user

  before_save :check_capacity, if: -> (a) { a.status != 'cancel' }
  before_save :update_pending_attendance, if: -> (a) { a.status == 'cancel' }
  after_create :join_group
  after_save :notify

  private
  def check_capacity
    if self.event.capacity_max <= self.event.attend_attendances.count
      self.status = 'pending'
    else
      self.status = 'attend'
    end
  end

  def update_pending_attendance
    if 0 < self.event.pending_attendances.count
      first_pending_attendance = self.event.pending_attendances.first
      first_pending_attendance.update_column(:status, 'attend')
      ::Notification::AttendStatus.notify(first_pending_attendance)
    end
  end

  def notify
    if self.status == 'attend'
      ::Notification::EventAttendance.notify(self)
    end
  end

  private
  def join_group
    membership = self.event.group.membership_for(self.user)
    self.event.group.join(self.user, membership.try(:level))
  end
end
