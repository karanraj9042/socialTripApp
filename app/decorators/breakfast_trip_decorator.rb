#Decorate the trip with breakfast only features.
class BreakfastTripDecorator < BasicTripDecorator
    def initialize(trip)
		@trip = trip
		@feature = "Your trip has Breakfast included "
		@extra_cost = 500
	end
	
	# override the getTripDetails method to include the description of the extra feature and its corresponding price
    def getTripDetails
		return @feature 
	end	
	
	def getTripcost
		return @extra_cost 
	end	
end