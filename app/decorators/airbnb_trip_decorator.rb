#Decorate the trip with AirBNB features.
class AirbnbDecorator < BasicTripDecorator
    def initialize(trip)
		@trip = trip
		@feature = "Your trip has AirBnb featured added"
		@extra_cost = 750
	end
	
	# override the details method to include the description of the extra feature and its corresponding price
    def getTripDetails
		return @feature
	end	
	def getTripcost
		return @extra_cost
	end	
end