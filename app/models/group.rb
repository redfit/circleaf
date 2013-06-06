class Group < ActiveRecord::Base
  extend Enumerize
  include Levelable
  LEVELS = [:public, :private].freeze
  enumerize :level, in: self::LEVELS

  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts

  validates_presence_of :name, :level

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
