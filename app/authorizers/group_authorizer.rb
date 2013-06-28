class GroupAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    return true if resource.privacy_scope.public?
    return true if resource.membership_for(user).present?
    return false
  end

  def updatable_by?(user)
    membership = resource.membership_for(user)
    return true if membership.try(:level) == 'owner'
    return false
  end

  def deletable_by?(user)
    return updatable_by?(user)
  end
end
