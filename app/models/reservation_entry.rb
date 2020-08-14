class ReservationEntry < ActiveRecord::Base
    belongs_to :user

    def formatted_created_at
        self.created_at.strftime("%A, %d %b %Y %l:%M %p")
    end

    def day_reserved
      self.created_at.to_date
    end
end
