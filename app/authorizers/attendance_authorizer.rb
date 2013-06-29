class AttendanceAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    group.owner?(user)
  end

  def creatable_by?(user)
    group.privacy_scope.public? || group.join?(user)
  end

  def updatable_by?(user)
    readable_by?(user)
  end

  def deletable_by?(user)
    creatable_by?(user)
  end

  private
  def group
    resource.event.group
  end
end
