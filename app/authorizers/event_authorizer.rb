class EventAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    group.privacy_scope.public? || group.join?(user)
  end

  def updatable_by?(user)
    group.owner?(user)
  end

  def deletable_by?(user)
    updatable_by?(user)
  end

  private
  def group
    resource.group
  end
end
