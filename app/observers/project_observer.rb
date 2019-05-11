class ProjectObserver < ActiveRecord::Observer
 observe :trip
 
 #called when a trip is upated.
  def after_update(trip)
   
    @user=User.find(trip.user_id)
    if(trip.previous_changes.any?)
		  UserMailer.trip_update(trip,@user).deliver
		  
    end
  end
  
  

end


  
 