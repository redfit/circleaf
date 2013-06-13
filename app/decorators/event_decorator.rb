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
end
