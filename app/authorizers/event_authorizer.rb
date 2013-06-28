class EventAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    return true if resource.group.privacy_scope.public?
    return true if resource.group.membership_for(user).present?
    return false
  end

  def updatable_by?(user)
    membership = resource.group.membership_for(user)
    return true if membership.try(:level) == 'owner'
    return false
  end

  def deletable_by?(user)
    return updatable_by?(user)
  end
end
