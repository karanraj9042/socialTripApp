class CaffesController < ApplicationController
  before_action :authenticate_user!

  # GET /caffes
  # GET /caffes.json
  #This Index method will load near by venue according to the users profile.
  def index
    @trip = Trip.find(params[:trip_id])
    @profile = Profile.find_by_user_id(@trip.user_id)
     @custom_venues = Array.new
     @venue_categoies= Array.new
     @recommended = ""
     
     #This method will load results according to search paramater .
     if params[:search].present?
      @cafes = venueReport.search_venues(near: @trip.destination, query: params[:search] ,limit: 15)
      if @cafes.nil?
          flash[:error] =  "Sorry!! We didn't find any results for you."
         redirect_to caffes_url and return 
      else
       @custom_venues << @cafes
       @recommended = params[:search]
      end
      
     else
         #Load all the recomandations based on User's like.
         my_string = @profile.likedvenue
         @recommended = my_string
         if my_string.include? ","
             elements = my_string.split(",")
             elements.delete_if{|e| e.length == 0}
             elements.each do |value|
                @venue_categoies << value
                @cafes = venueReport.search_venues(near: @trip.destination, query: value ,limit: 15) 
                @custom_venues << @cafes
             end
          else
            @cafes = venueReport.search_venues(near: @trip.destination, query: @profile.likedvenue ,limit: 15) 
            @custom_venues << @cafes
            @recommended = "Recommended #{my_string}"
         end
     end
  end
  

#Foursquare 2 API is used to fetching the venue result.
  private
    def venueReport
      Foursquare2::Client.new(:client_id => Rails.application.secrets.client_id , :client_secret => Rails.application.secrets.client_secret,:api_version => '20190308')
    end
  

  
end
