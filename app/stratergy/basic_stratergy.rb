#basic stratergy thorugh which our stratergy classes will load.
class BasicStratergy
    def initialize
     @strategies = {}
     @strategies['Event'] = EventStratergy
     @strategies['Venue'] = VenueStratergy
    end
    
    def executeStratergy(likedType,likedTripId,currentUserId)
        strategy = @strategies[likedType]
        strategy.getRecommendation(likedTripId,currentUserId)
    end
end