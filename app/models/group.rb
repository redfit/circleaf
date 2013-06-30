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
  mount_uploader :image, GroupImageUploader

  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts
  has_many :events

  validates_presence_of :name, :privacy_scope

  before_create :join_as_owner

  def join(user, level = 'member')
    if user.groups.include?(self)
      self.membership_for(user).update_column(:level, level)
    else
      self.memberships << Membership.new(user: user, level: level)
    end
  end

  def leave(user)
    owners = self.memberships.where(level: 'owner') - [self.membership_for(user)]
    if owners.present? 
      user.groups.delete(self)
    else
      return
    end
  end

  def membership_for(user)
    return unless user
    user.memberships.where(group_id: self.id, user_id: user.id).first
  end

  def owner?(user)
    self.membership_for(user).try(:level).try(:owner?)
  end

  def join?(user)
    self.membership_for(user).present?
  end

  private
  def join_as_owner
    self.join(self.user, 'owner') if self.user
  end
end
