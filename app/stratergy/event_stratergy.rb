#Event stratergy thorugh which profile ill updated.
class EventStratergy
    def self.getRecommendation(likedTripId,currentUserId)
         @liked_trip = Trip.find(likedTripId)
         @liked_profile = Profile.find_by_user_id(@liked_trip.user_id)
         @current_user_profile = Profile.find_by_user_id(currentUserId)

         #if current profile isn't containing the liked profile event then add into current profile likedevent.
         if !(@liked_profile.likedevent.include? @current_user_profile.likedevent)
             @current_user_profile.likedevent = "#{@current_user_profile.likedevent},#{@liked_profile.likedevent}"
              @current_user_profile.save
         end
        
    end
end