class Group < ActiveRecord::Base
  extend Enumerize
  include Scopable
  SCOPES = [:public, :private].freeze
  enumerize :scope, in: self::SCOPES

  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts

  validates_presence_of :name, :scope

  def join(user, scope = 'member')
    user.memberships.create(group_id: self.id, scope: scope) unless user.groups.include?(self)
  end

  def leave(user)
    user.groups.delete(self)
  end

  def membership_for(user)
    user.memberships.where(group_id: self.id, user_id: user.id).first
  end
end
