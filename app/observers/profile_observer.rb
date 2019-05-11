class ProfileObserver < ActiveRecord::Observer
 observe :profile
 
 # called when a profile is updated
   def after_save(profile)
    @user=User.find(profile.user_id)
      if(profile.previous_changes.any?)
           UserMailer.profile_update(profile,@user).deliver
      end
   end
end


  
 