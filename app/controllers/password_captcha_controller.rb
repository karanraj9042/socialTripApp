class PasswordCaptchaController < Devise::PasswordsController 
    
    prepend_before_action :check_captcha, only: [:create]

  private
#Validate captcha before sending password revovery mail to user
  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new
      #resource.validate
      resource.errors.add(:base, "Passord Reset Error. Please try again")
      respond_with_navigational(resource) { render :new }
    end
  end
end
