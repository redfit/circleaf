class Membership < ActiveRecord::Base
  include Authority::Abilities
  authorizer_name = :MembershipAuthorizer

  extend Enumerize
  extend ActiveModel::Naming
  LEVELS = [:owner, :member].freeze
  enumerize :level, in: self::LEVELS

  belongs_to :group
  belongs_to :user
end
