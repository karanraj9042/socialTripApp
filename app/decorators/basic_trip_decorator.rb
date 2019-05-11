#Base Decorator the trip in whihc decoartion isn ot yet started.
class BasicTripDecorator
    def initialize(trip)
		@trip = trip
		@extra_cost = 0
		@feature = "No Add on Included."
    end
	
	# override the getTripDetails method to include the  of the extra feature	
	def getTripDetails
		return @feature
	end
	
end