class Membership < ActiveRecord::Base
  extend Enumerize
  SCOPES = [:owner, :member].freeze
  enumerize :scope, in: self::SCOPES

  belongs_to :group
  belongs_to :user
end
