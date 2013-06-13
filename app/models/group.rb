class Group < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  PRIVACY_SCOPES = [:public, :private].freeze
  enumerize :privacy_scope, in: self::PRIVACY_SCOPES

  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts

  validates_presence_of :name, :privacy_scope

  def join(user, level = 'member')
    user.memberships.create(group_id: self.id, level: level) unless user.groups.include?(self)
  end

  def leave(user)
    user.groups.delete(self)
  end

  def membership_for(user)
    user.memberships.where(group_id: self.id, user_id: user.id).first
  end
end
