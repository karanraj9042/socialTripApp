class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable, :timeoutable,  :omniauthable, :omniauth_providers => [:github,:facebook]
     
   has_many :trips
   has_one :profile
   has_many :messages
   has_many :comments
   after_update :create
   
   validate :password_complexity 

#   Password_compexity check and it should match with below regex.
    def password_complexity 
      if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\W])/) 
         errors.add :password, "must include at least one lowercase letter, one uppercase letter and one symbol" 
      end 
    end 
    
  #Usermailer welcome email
   after_create :send_admin_mail
   def send_admin_mail
     UserMailer.send_welcome_email(self).deliver
   end
   
   def create
     puts("create ====================================================")
 end
   
   #Get GitHub Login
   def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
   end
   
  def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
  end
end
