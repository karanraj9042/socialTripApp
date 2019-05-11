require 'singleton'

class RecommendedTripByDestinationController < TripsController
    
    include Singleton
#trip recoomandation based on Destination
    def getAllUser
        @users = User.all
        return @users
    end
    #child class template method
    def getAllTripsForUser(user_id)
         @trips = Trip.where(:user_id =>user_id)
        return @trips
    end
    #child class template method
    def getAllTripsForLoggedUser(user_id)
         @trips = Trip.where(:user_id =>user_id)
        return @trips
    end
    
end
