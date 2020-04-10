module ProfilesHelper

    def gender_of(profile)
        if profile.gender == "female"
            @gen = "F"
        elsif profile.gender == "male"
            @gen = "M"
        end
        # if profile.sexual_preferences == "bisexual"
        #     @partner = "male and female"
        # end
        @gen
    end

    def het_to_straight(profile)
        if profile.sexual_preferences == "heterosexual"
            pref = "Straight"
        elsif profile.sexual_preferences == "gay"
            pref = "Gay"
        else
            pref = "Bi"
        end
        pref
    end

    def profile_and_is_user(user)
        # if user.profile_created == false
    end
    
end
