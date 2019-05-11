class UserMailer < ApplicationMailer
   # default from: 'test@example.com'
  #Send welcome email after sign up
  def send_welcome_email(user)
    @user = user
    mail to: @user.email, subject: "Welcome to Social Trip App", from:'test@example.com'
  end
  #Send trip update email 
  def trip_update(trip,user)
    @user = user
    @trip=trip
    mail to: @user.email, subject: "Trip Updated (Socail Trip App)", from:'test@example.com'
  end
  
  #Send weather update email for trip
  def trip_weather(trip,user,temperature,windSpeed)
    @user = user
    @trip=trip
    @temperature=temperature
    @windSpeed=windSpeed
    mail to: @user.email, subject: "Weather Update for your Upcoming Trip (Socail Trip App)", from:'test@example.com'
  end
  
  #Send   email if new comments added.
  def comment_update(message)
    @user = message.user
    @message=message
    mail to: @user.email, subject: "New comment for your Message Board (Socail Trip App)", from:'test@example.com'
    
  end
  
  #Sent email if new message created
  def message_create(message,user)
    @message=message
    @user=user
    mail to: @user.email, subject: "New Message created for your Message Board (Socail Trip App)", from:'test@example.com'
  end  
  
  #sent profile update email.
  def profile_update(profile,user)
    @profile=profile
    @user=user
    mail to: @user.email, subject: "Profile updated (Socail Trip App)", from:'test@example.com'
  end 
  
  
end
