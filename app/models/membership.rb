class Membership < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  LEVELS = [:owner, :member].freeze
  enumerize :level, in: self::LEVELS

  belongs_to :group
  belongs_to :user
end
