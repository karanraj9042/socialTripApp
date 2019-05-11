#rofile decoration with Full name
class FullNameDecorator < ProfilesDecorator
    def initialize(real_profile)
        super(real_profile)
        @description = "Profile name with full name "
	end
	
	def full_name
	    return "#{@real_profile.firstname} #{@real_profile.lastname}"
	end
end