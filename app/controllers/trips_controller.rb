require_relative '../decorators/airbnb_trip_decorator.rb'
require_relative '../decorators/all_inclusive_trip_decorator.rb'
require_relative '../decorators/breakfast_trip_decorator.rb'

class TripsController < ApplicationController
  require 'my_logger'
   @@trip_decorated = "No Add on."
  
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  after_action :verify_authorized , except: [:index ,:likedvenue ,:likedevent]

  # GET /trips
  # GET /trips.json
  
 
  def getRecommendedTripsByUsers
    # Using Template Pattern here calling the child class method of RecommendedTripController
    # Made RecommendedTripControllerByUsers class as "Singleton" so that only 1 instance is created
    users = RecommendedUserTripController.instance.getAllUser
    @recommended_trips = Array.new
    @users_id = users.ids
    
    @users_id.each do |user_id|
      if !(user_id == current_user.id) 
         # Using Template Pattern here calling the child class method of RecommendedTripController
          getAllRecommendedTrips = RecommendedUserTripController.instance.getAllTripsForUser(user_id)
          @recommended_trips << getAllRecommendedTrips
      end
    end  
  end
  
  
  def getRecommendedTripsBySameDestination
    # Using Template Pattern here calling the child class method of RecommendedTripByDestinationController
    # Made RecommendedTripByDestinationController class as "Singleton" so that only 1 instance is created
    users = RecommendedTripByDestinationController.instance.getAllUser
    @recommended_trips_by_destination = Array.new
    @users_id = users.ids
    @current_user_trips = RecommendedTripByDestinationController.instance.getAllTripsForLoggedUser(current_user.id)
    @users_id.each do |user_id|
      if !(user_id == current_user.id) 
         # Using Template Pattern here calling the child class method of RecommendedTripByDestinationController
          getAllRecommendedTrips = RecommendedTripByDestinationController.instance.getAllTripsForUser(user_id)
          
            
            @current_user_trips.each do |userTrip|
              getAllRecommendedTrips.each do |reccTripsByDest|
               if (userTrip.destination == reccTripsByDest.destination)
                @recommended_trips_by_destination << reccTripsByDest
               end
            end  
          end  
         
      end
    end  
  end 
   
  def index
   #restrict user for first create profile then only he can see the trips or create trips.
    profile = Profile.find_by_user_id(current_user.id)
    if profile.nil?
         flash[:error] =  "Sorry!! But First create a profile for you."
         redirect_to profiles_url and return 
    else
     @trips = Trip.search(params[:search])
    # @trip_created_at = Array.new
    # @trips.each do |trip|
    # start_date = trip.startdate
    # @trip_created_at << start_date
    # end
    # puts("created at"+@trip_created_at.to_s)
     getRecommendedTripsByUsers
     getRecommendedTripsBySameDestination
     
    
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    #sho current weather for the trip
    @trip_add_on = @@trip_decorated
    
    #Weather Report for Particluar location
    @summary = weatherReport.currently.summary.to_s
    @icon = weatherReport.currently.icon
    @windSpeed = weatherReport.currently.windSpeed
    @temperature = weatherReport.currently.temperature
    @timezone = weatherReport.timezone
  end

  # GET /trips/new
  def new
    @trip = current_user.trips.new
    #authorize trip policy
    authorize @trip
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = current_user.trips.create(trip_params)
    #authorize trip policy
    authorize @trip
    
    trip_decorated = getTripDetails
    
    #Trip Decoration with add on feature for AirBNB ,All inclusive and Breakfast only
    trip_decorated = BasicTripDecorator.new(@trip)
    
    if params[:trip][:all].to_s.length > 0 then
         trip_decoratedA = AllInclusiveTripDecorator.new(@trip)
         flag1 = 1;
    end
    if params[:trip][:airbnb].to_s.length > 0 then
        trip_decoratedB = AirbnbDecorator.new(@trip)
        flag2 =2;
    end
    if params[:trip][:breakfast].to_s.length > 0 then
       trip_decoratedC = BreakfastTripDecorator.new(@trip)
       flag3 =3;
    end
    
    if(flag1==1 && flag2==2 && flag3 ==3)
        total_cost = trip_decoratedA.getTripcost.to_i+trip_decoratedB.getTripcost.to_i+trip_decoratedC.getTripcost.to_i
        @@trip_decorated = "#{trip_decoratedA.getTripDetails.to_s} and #{trip_decoratedB.getTripDetails.to_s} and #{trip_decoratedC.getTripDetails.to_s} and Total trip cost is :  #{total_cost.to_s} EUR."
         
    elsif (flag1==1 && flag2==2)
    total_cost = trip_decoratedA.getTripcost.to_i+trip_decoratedB.getTripcost.to_i
         @@trip_decorated = "#{trip_decoratedA.getTripDetails.to_s} and #{trip_decoratedB.getTripDetails.to_s} and Total trip cost is :  #{total_cost.to_s} EUR."
         
    
    elsif(flag2==2 && flag3 ==3)
        total_cost = trip_decoratedB.getTripcost.to_i+trip_decoratedC.getTripcost.to_i
         @@trip_decorated = "#{trip_decoratedB.getTripDetails.to_s} and #{trip_decoratedC.getTripDetails.to_s} and Total trip cost is :  #{total_cost.to_s} EUR."
        
      elsif(flag1==1 && flag3 ==3)
        total_cost = trip_decoratedA.getTripcost.to_i+trip_decoratedC.getTripcost.to_i
         @@trip_decorated = "#{trip_decoratedA.getTripDetails.to_s} and #{trip_decoratedC.getTripDetails.to_s} and Total trip cost is :  #{total_cost.to_s} EUR."
        
         
    elsif (flag1==1)
         @@trip_decorated = "#{trip_decoratedA.getTripDetails.to_s}"
    
    elsif(flag2==2)
         @@trip_decorated = "#{trip_decoratedB.getTripDetails.to_s}"
    elsif(flag3==3)
         @@trip_decorated = "#{trip_decoratedC.getTripDetails.to_s}"
    else
     
     @@trip_decorated = trip_decorated.getTripDetails
     
    end
   if !@trip.longitude.to_s.empty? && !@trip.latitude.to_s.empty?
    logger = MyLogger.instance
    logger.logInformation("Trip has been created with destination."+@trip.destination.to_s+"with longitude : "+@trip.longitude.to_s+
                           "and latitude: "+@trip.latitude.to_s)
     respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
     end
   else
     @trip.destroy
     flash[:error] =  "There is some problem while retriving your location,Please enter correct location."
     redirect_to(new_trip_path) and return 
   end
 
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    logger = MyLogger.instance
   
    respond_to do |format|
      if @trip.update(trip_params)
         logger.logInformation("Trip has been updated for destination."+@trip.destination.to_s)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
         logger.logInformation("While Updating Trip it got some error."+@trip.errors.to_s)
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    logger = MyLogger.instance
    logger.logInformation("Trip has been deleted for destination."+@trip.destination.to_s)
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def like
  end  

   def getAllUser
    raise 'Must implement'
   end
  
  def getAllTripsForUser(user_id)
     raise 'Must Find Trips'
  end
  
  #stratery pattern for based on like event or venue it will load the class.
  def likedvenue
    BasicStratergy.new.executeStratergy("Venue", params[:id], current_user.id)
  end
  
   def likedevent
    BasicStratergy.new.executeStratergy("Event", params[:id], current_user.id)
   end
   
   def getTripDetails
     return "Basic Trip Added."
   end
   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
      authorize @trip
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:destination, :startdate, :enddate, :latitude,:ratings, :longitude,:user_id,:search,images:[])
    end
    
    #Weather Report
    def weatherReport
        ForecastIO.forecast(@trip.latitude, @trip.longitude, params:{units:'si'})
    end
    
end