module MainHelper
    def sort_profiles_bi(user)
        if user.profile.sexual_preferences == "bisexual"
            #find all users both male and female, then sort by things like distance
            #then sort the by the user gender
            #women f/g m/s
            #men f/s m/g
        end
    end

    def sort_profiles_str(user)
        if user.profile.gender == "male"
            #find all users that are female and str
        end
        if user.profile.gender == "female"
            #find all users that are male and str
        end
    end

    def sort_profiles_gay(user)
        if user.profile.gender == "male"
            #find all users that are male and gay
        end
        if user.profile.gender == "female"
            #find all users that are female and gay
        end
    end
end
