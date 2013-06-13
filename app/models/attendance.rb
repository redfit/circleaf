class Attendance < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  STATUSES = [:attend, :pending, :cancel].freeze
  enumerize :status, in: self::STATUSES

  belongs_to :event
  belongs_to :user
end
