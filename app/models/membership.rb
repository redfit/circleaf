class Membership < ActiveRecord::Base
  extend Enumerize
  include Levelable
  LEVELS = [:owner, :member].freeze
  enumerize :level, in: self::LEVELS

  belongs_to :group
  belongs_to :user
end
