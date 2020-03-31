class Visit < ApplicationRecord
    #https://stackoverflow.com/questions/21317985/how-to-show-who-has-visited-your-profile
    #https://stackoverflow.com/questions/41944889/how-to-show-who-has-visited-a-users-profile-in-rails
    belongs_to :profile
    belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
end
