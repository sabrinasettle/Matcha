module ProfilesHelper

    def has_visibility(profile)
        #send the cureent_user some where else if they are blocked
        if current_user.profile.blocks.where(user_id: profile.user_id).any?
            redirect_to main_path
        end
        if current_user.id != profile.user_id and current_user.profile_created == false
            redirect_to profile_path(current_user.user_name)
        end
    end

    def can_like?
        #Work on -- take the logic for disabling the like button and put it here
        # take it out of the view
        # maybe a separete parital for the profiles?
        # and just redirect to thta??
    end

    def allowed(profile)
        unless current_user.user_name == profile.user_name
            redirect_to profile_path(current_user.user_name)
        end
    end

    def convert_postal_code(user)
        lat = user.postal_code.to_lat
        lon = user.postal_code.to_lon

        user.update(latitude: lat, longitude: lon)
    end

    # def gender_of(profile)
    #     if profile.gender == "female"
    #         @gen = "F"
    #     elsif profile.gender == "male"
    #         @gen = "M"
    #     end
    #     # if profile.sexual_preferences == "bisexual"
    #     #     @partner = "male and female"
    #     # end
    #     @gen
    # end

    # def het_to_straight(profile)
    #     if profile.sexual_preferences == "Straight"
    #         pref = "Straight"
    #     elsif profile.sexual_preferences == "Gay"
    #         pref = "Gay"
    #     else
    #         pref = "Bi"
    #     end
    #     pref
    # end

    def profile_and_is_user(user)
        # if user.profile_created == false
    end

    def user_rating(profile)
        rating = profile.user_rating
        start_time = profile.created_at
        present_day = Time.now
        # decrease slightly by day
        #if rating > 0
            #then decrease slightly by .1 for everyday of inactivity from start_time to present_day
        # end
    end
    
end
