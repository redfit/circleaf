class Group < ActiveRecord::Base
  extend Enumerize
  LEVELS = [:public, :private].freeze
  enumerize :level, in: self::LEVELS
end
