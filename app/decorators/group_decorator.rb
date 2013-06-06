module GroupDecorator
  def link_join_or_leave(current_user)
    return unless current_user
    if self.membership_for(current_user)
      link_to group_memberships_path(self), method: :delete, class: 'leave_btn btn btn-danger' do
        t('nav.groups.leave') 
      end
    else
      link_to group_memberships_path(self), method: :post, class: 'join_btn btn btn-primary' do
        t('nav.groups.join') 
      end
    end
  end
end
