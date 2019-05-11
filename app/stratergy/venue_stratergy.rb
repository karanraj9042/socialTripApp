class VenueStratergy
    def self.getRecommendation(likedTripId,currentUserId)
         @liked_trip = Trip.find(likedTripId)
         @liked_profile = Profile.find_by_user_id(@liked_trip.user_id)
         @current_user_profile = Profile.find_by_user_id(currentUserId)
         
         #if current profile isn't containing the liked profile venue then add into current profile likedvenue.
         if !(@liked_profile.likedvenue.include? @current_user_profile.likedvenue)
             @current_user_profile.likedvenue = "#{@current_user_profile.likedvenue},#{@liked_profile.likedvenue}"
              @current_user_profile.save
         end
         
    end
end