#Profile decoration with last name only
class ProfilesDecorator
    def initialize(real_profile)
		@real_profile = real_profile
		@description = "Profile name with last name only"
    end

    # override the full name method to include the first nam and last name of the user profile	
	def full_name
	    return "#{@real_profile.firstname} "
	end

end