#Controller used for Social account login as GitHUb,Facebook
class CallbacksController < Devise::OmniauthCallbacksController
    require 'my_logger'
    
    #implemented github login
    def github
        getSocialLogin
    end
    
   
    
    private
    def getSocialLogin
        @user = User.from_omniauth(request.env["omniauth.auth"])
        logger = MyLogger.instance
        logger.logInformation("Login with GitHub started for email :, "+@user.email)
        sign_in_and_redirect @user
    end
end
