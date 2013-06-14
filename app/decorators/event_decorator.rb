module EventDecorator
  def date
    begin_date = self.begin_at.strftime(t('date.short'))
    begin_time = self.begin_at.strftime(t('time.short'))
    end_date = self.end_at.strftime(t('date.short'))
    end_time = self.end_at.strftime(t('time.short'))
    
    params = {
      begin_date: begin_date,
      begin_time: begin_time,
      end_date: end_date,
      end_time: end_time,
    }

    if begin_date == end_date
      t('date.day', params)
    else
      t('date.days', params)
    end
  end

  def link_join_or_leave(current_user)
    return unless current_user
    status = self.attendance_for(current_user).try(:status)
    if %w(attend cancel).include?(status)
      link_to event_attendances_path(self), method: :delete, class: 'leave_btn btn btn-danger btn-block' do
        t('nav.eventss.leave') 
      end
    else
      link_to event_attendances_path(self), method: :post, class: 'join_btn btn btn-primary btn-block' do
        t('nav.events.join') 
      end
    end
  end
end
