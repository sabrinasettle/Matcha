module MainHelper

    def suggestions(all_users, profile)
        if profile.gay?
            if profile.male?
                suggestions = all_users.male.gay
            end
            if profile.female?
                suggestions = all_users.female.gay
            end
        end
        if profile.str?
            if profile.male?
                suggestions = all_users.female.straight
            end
            if profile.female?
                suggestions = all_users.male.straight
            end
        end
        if profile.bi?
            suggestions = all_users
        end
        
        suggestions
    end

    def user_rating_decrease
        created_at = profile.created_at
        today = Time.now
        #for each day since the the profile.created we decrease from the 5 at start
        if profile.user_rating > 0
            user.decrement!(:user_rating, 0.1)
        end
    end

end


