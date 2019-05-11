class Trip < ApplicationRecord
    
    geocoded_by :destination
    after_validation :geocode, :if => :destination_changed?
    belongs_to :user
    
    #validate if end date is after the start date
    validate :end_date_is_after_start_date
    has_many_attached :images
    #validate image count
    validate :image_count
    
    def thumbnail input
        return self.images[input].variant(resize: '300X300!').processed
    end
    
    private
    def image_count
        if images.size > 4
            errors.add(:images, "more than 4 not allowed")
        end
    
       images.each  do |image|
        if !image.content_type.in?(%('image/jpeg image/png'))
            errors.add(:images, "needs to be a JPG or PNG")
        end
       end
    end
    
    def end_date_is_after_start_date
      return if enddate.blank? || startdate.blank?

      if enddate < startdate
         errors.add(:enddate, "cannot be before the start date") 
      end 
    end
    
    def self.search(search)
        if search
          where('destination LIKE ?', "%#{search}%")
            else
            Trip.all
        end
    end
    
end


