class Event < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  PRIVACY_SCOPES = [:public, :private].freeze
  enumerize :privacy_scope, in: self::PRIVACY_SCOPES

  belongs_to :user
  belongs_to :group
  has_many :attendances, -> { order(updated_at: :asc) }
  has_many :users, through: :attendances
  has_many :attend_attendances, -> { where(status: 'attend').order(updated_at: :asc, id: :asc) }, class_name: 'Attendance'
  has_many :attend_users, through: :attend_attendances, source: :user
  has_many :pending_attendances, -> { where(status: 'pending').order(updated_at: :asc, id: :asc) }, class_name: 'Attendance'
  has_many :pending_users, through: :pending_attendances, source: :user
  has_many :cancel_attendances, -> { where(status: 'cancel').order(updated_at: :asc, id: :asc) }, class_name: 'Attendance'
  has_many :cancel_users, through: :cancel_attendances, source: :user
  has_one :post, as: :postable

  validates_presence_of :user, :name, :begin_at, :end_at, :capacity_max

  after_initialize :format_date
  after_update :update_attendances

  def join(user)
    attendance = user.attendances.find_or_initialize_by(event_id: self.id)
    attendance.status = 'attend'
    attendance.save
  end

  def leave(user)
    return unless attendance = attendance_for(user)
    attendance.status = 'cancel'
    attendance.save
  end

  def attendance_for(user)
    user.attendances.where(event_id: self.id).first
  end

  private
  def format_date
    [:begin_at, :end_at].each do |d|
      self[d] = self[d].try(:strftime, '%Y-%m-%d %H:%M')
    end
  end

  def update_attendances
    if capacity_max_changed? && capacity_max > capacity_max_was
      # capacity_maxが増えていれば繰り上がりの可能性がある
      diff = capacity_max - capacity_max_was
      self.pending_attendances.limit(diff).each do |attendance|
        attendance.update_attributes(status: 'attend')
      end
    end
  end
end
