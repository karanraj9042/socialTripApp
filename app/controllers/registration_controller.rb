class RegistrationController < Devise::RegistrationsController 
    #verify captcha while sign up
    def create
       if verify_recaptcha()
         super
       else
         self.resource = resource_class.new sign_up_params
         resource.validate
         resource.errors.add(:base, "Registration Error. Please try again")
         respond_with_navigational(resource) { render :new }  
       end
    end
end
