#Decorate the trip with All features.
class AllInclusiveTripDecorator <  BasicTripDecorator
    def initialize(trip)
		@trip = trip
		@feature = "Your trip has All Inclusive"
		@extra_cost = 2000
	end
	
	# override the details method to include the description of the extra feature and its corresponding price
	def getTripDetails
		return @feature  
	end	
	
	def getTripcost
		return @extra_cost 
	end	

end