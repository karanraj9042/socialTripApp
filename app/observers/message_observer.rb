class MessageObserver < ActiveRecord::Observer
 observe :message
  
  # called when a new message is created
  def after_create(message)
   
   @user=User.find(message.user_id)
   UserMailer.message_create(message,@user).deliver
   
  end 

end


  
 