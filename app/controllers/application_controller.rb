class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery with: :exception
    
    #Cache expire on every page after Log out.
    before_action :set_cache_buster

      def set_cache_buster
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
      end
      
      #Update the user if weather is below 10 degree and load user current profile.
      def after_sign_in_path_for(resource)
       
          @trips = Trip.where(:user_id =>current_user.id)
          @user=User.find(current_user.id)
          @trips.each do |trip|
              
          @weatherReport=ForecastIO.forecast(trip.latitude, trip.longitude, params:{units:'si'})
          @windSpeed = @weatherReport.currently.windSpeed
          @temperature = @weatherReport.currently.temperature
          if @temperature.to_i < 10 && trip.enddate > Time.now.to_date
                UserMailer.trip_weather(trip,@user,@temperature,@windSpeed).deliver
          end
      end
           "/signedinuserprofile"
      end
    
    #Rescue form Pundit not Authorized error.
     rescue_from Pundit::NotAuthorizedError do 
     redirect_to root_url, alert: 'You do not have access to this page'
    end
end
