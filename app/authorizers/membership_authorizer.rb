class MembershipAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    membership = resource.group.membership_for(user)
    return true if membership.try(:level) == 'owner'
    return false
  end

  def creatable_by?(user)
    group = resource.group
    return true if group.privacy_scope.public?
    return true if group.membership_for(user).present?
    return false
  end

  def updatable_by?(user)
    return readable_by?(user)
  end

  def deletable_by?(user)
    return creatable_by?(user)
  end
end
