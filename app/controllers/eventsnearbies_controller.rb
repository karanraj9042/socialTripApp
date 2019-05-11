#Event controller for shoing near by ebents with help of EventBrite.
class EventsnearbiesController < ApplicationController
  before_action :authenticate_user!

  # GET /eventsnearbies
  # GET /eventsnearbies.json
  def index
     #EventBrite Info
     #Eventbrite.token = Rails.application.secrets.evenrbrite_secret
    Eventbrite.token = Rails.application.credentials[Rails.env.to_sym][:evenrbrite_secret]
     #Events Info
     @trip = Trip.find(params[:trip_id])
     @profile = Profile.find_by_user_id(@trip.user_id)
     @custom_events = Array.new
     @events_categoies= Array.new
     @recommended = ""
    
    #load result based on search parameter.
     if params[:search].present?
       @events = Eventbrite::Event.search({q: "#{params[:search]}#{@trip.destination}", expand: 'venue'})
       @custom_events << @events
       @recommended = "#{params[:search]}"
     else
       my_string = @profile.likedevent
       @recommended = my_string
         if my_string.include? ","
             elements = my_string.split(",")
             elements.delete_if{|e| e.length == 0}
             elements.each do |value|
                @events_categoies << value
                @events = Eventbrite::Event.search({q: "#{value}#{@trip.destination}", expand: 'venue'})
                @custom_events << @events
             end
          else
             @events = Eventbrite::Event.search({q:"#{my_string}#{@trip.destination}", expand: 'venue'})
             @custom_events << @events
             @recommended = "Recommended #{my_string}"
         end
     end
  end
end
