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

    def users_with_common_interests(profile, array)
        # len = profile.interest_list.length
        # order
        # len.each do |interest|
            
        # end
    end

end


