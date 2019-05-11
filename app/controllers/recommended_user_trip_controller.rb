require 'singleton'

class RecommendedUserTripController < TripsController 
    #Recommandation based on Trip
include Singleton
#child class template method
    def getAllUser
        @users = User.all
        return @users
    end
    #child class template method
    def getAllTripsForUser(user_id)
         @trips = Trip.where(:user_id =>user_id)
        return @trips
    end
end
