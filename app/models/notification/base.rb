class Notification::Base
  class << self
    def notify(trigger)
    end
    
    private
    def target(trigger)
      puts 'base target'
      []
    end
  end
end
