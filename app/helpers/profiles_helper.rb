module ProfilesHelper

    def looking_for(profile)
        if profile.gender == "female"
            profile.sexual_preferences == "gay" ? @partner = "female" : @partner = "male"
        elsif profile.gender == "male"
            profile.sexual_preferences == "gay" ? @partner = "male" : @partner = "female"
        end
        if profile.sexual_preferences == "bisexual"
            @partner = "male and female"
        end
        @partner
    end

    def profile_and_is_user(user)
        # if user.profile_created == false
    end
    
end
