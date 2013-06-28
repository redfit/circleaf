class Group < ActiveRecord::Base
  include Authority::Abilities
  authorizer_name = :GroupAuthorizer

  include Markdownable
  markdownable :content

  extend Enumerize
  extend ActiveModel::Naming
  PRIVACY_SCOPES = [:public, :private].freeze
  enumerize :privacy_scope, in: self::PRIVACY_SCOPES

  attr_accessor :user

  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts
  has_many :events

  validates_presence_of :name, :privacy_scope

  before_create :join_as_owner

  def join(user, level = 'member')
    self.memberships << Membership.new(user: user, level: level) unless user.groups.include?(self)
  end

  def leave(user)
    user.groups.delete(self)
  end

  def membership_for(user)
    return unless user
    user.memberships.where(group_id: self.id, user_id: user.id).first
  end

  private
  def join_as_owner
    self.join(self.user, 'owner') if self.user
  end
end
