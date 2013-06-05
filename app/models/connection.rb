class Connection < ActiveRecord::Base
  extend Enumerize
  PROVIDERS = [:twitter].freeze
  enumerize :provider, in: self::PROVIDERS

  belongs_to :user
end
