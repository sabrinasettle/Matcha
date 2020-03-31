# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#  { name: 'Lord of the Rings' },])
#   Character.create(name: 'Luke', movie: movies.first)




# if Interest.exists? == false
    # Interest.create!(name: 'Being Outdoors', tag_list: 'Being Outdoors') 
    # Interest.create!(name: 'Video Games', tag_list: 'Video Games')
    # Interest.create!(name: 'Reading', tag_list: 'Reading')
    # Interest.create!(name: 'Cooking', tag_list: 'Cooking')
    # Interest.create!(name: 'Music', tag_list: 'Music')
    # Interest.create!(name: 'Movies and TV', tag_list: 'Movies and TV')
    # Interest.create!(name: 'Puzzles', tag_list: 'Puzzles')
    # Interest.create!(name: 'Exercising', tag_list: 'Exercising')
    # Interest.create!(name: 'Dancing', tag_list: 'Dancing')
    # Interest.create!(name: 'Sports', tag_list: 'Sports')
    # Interest.create!(name: 'Travel', tag_list: 'Travel')
    # Interest.create!(name: 'Family', tag_list: 'Family')
# end
# i_a = [
#     { name: 'Being Outdoors'},
#     # { name: 'Video Games'},
#     # { name: 'Reading'},
#     # { name: 'Cooking',
#     # { name: 'Music'},
#     # { name: 'Movies and TV'},
#     # { name: 'Puzzles'},
#     # { name: 'Exercising'},
#     # { name: 'Dancing'},
#     # { name: 'Sports'},
#     # { name: 'Travel'},
#     # { name: 'Family'},
# ]
# #12

# i_a.each do |attributes|
#   Interest.where(attributes).first_or_create!
# end


# Users testing
# user_att = [
#     { first_name: 'Jake', last_name: 'Peralta', email:'genius-slash-detective@gmail.com', user_name:'AwesomePossum69', password_digest: BCrypt::Password.create('JakeRules!69'), email_confirmed: true, profile_created: true},
#     { first_name: 'Amy', last_name: 'Santiago', email:'BindersAreHawt@gmail.com', user_name:'CrosswordFreak99', password_digest: BCrypt::Password.create('99BrookBookworm'), email_confirmed: true, profile_created: true},

#     { first_name: 'Captain', last_name: 'Holt', email:'FranzBluheimRocks@gmail.com', user_name:'CaptHolt', password_digest: BCrypt::Password.create('ChedderForever99'), email_confirmed: true, profile_created: true},
#     { first_name: 'Kevin', last_name: 'Cozner', email:'ActaNonVerba@gmail.com', user_name:'BeowulfKev', password_digest: BCrypt::Password.create('CorgiesForever99'), email_confirmed: true, profile_created: true},

#     { first_name: 'Charles', last_name: 'Boyle', email:'JakesBestFriend@gmail.com', user_name:'FlatAssBoyle', password_digest: BCrypt::Password.create('MrsPottsIsHot'), email_confirmed: true, profile_created: true},
#     { first_name: 'Gina', last_name: 'Linetti', email:'ImTheBestEver@gmail.com', user_name:'WolfRiderGina', password_digest: BCrypt::Password.create('BadBoys99'), email_confirmed: true, profile_created: true},

#     { first_name: 'Rosa', last_name: 'Diaz', email:'Knives@gmail.com', user_name:'CutandSlash', password_digest: BCrypt::Password.create('KnivesAreAwesome99'), email_confirmed: true, profile_created: true},
# ]

# user_att.each do |attributes|
#     User.where(attributes).first_or_create!
# end


# Admin testing
# User.create!(first_name: 'Sabrina', last_name: 'Settle', email:'ssettle93@gmail.com', user_name:'ssettle32', password_digest: BCrypt::Password.create('Sabrina123!'), email_confirmed: false, profile_created: false) 




# #Profiles
# if Profile.find(:all).empty?
    Profile.create(user_id: 1, gender: 1, bio: "I'm amazballz and super smort. Die Hard is my favorite film evvvverrrrrrrr" , sexual_preferences: 0, age: 28, avatar: Rails.root.join("app/assets/images/jp/jakeav.png").open, interest_ids: [2, 6, 7, 11], postal_code: "94555", user_name: "AwesomePossum69")
    Profile.create(user_id: 2, gender: 0, bio: "If you like the stationary store you stop by and say hi ;). I was hall monitor if you know what I mean" , sexual_preferences: 0, age: 35, avatar: Rails.root.join("app/assets/images/amy/amyav.jpg").open, interest_ids: [3, 4, 7, 8, 9, 11], postal_code: "94555", user_name:"CrosswordFreak99")
    
#     Profile.create(user_id: 3, gender: 1, bio: "I am hilarious and great at parties. My favorite color is tan." , sexual_preferences: 1, age: 57, avatar: Rails.root.join("app/assets/images/caph/caph-2.jpg").open, interest_ids: [1, 3, 7, 8], postal_code: "94555")
#     Profile.create(user_id: 4, gender: 1, bio: "I am interested in reading classics and owning a dog" , sexual_preferences: 1, age: 50, avatar: Rails.root.join("app/assets/images/kev/kev-1.jpg").open, interest_ids: [1, 3, 7, 8], postal_code: "94555")

#     Profile.create(user_id: 5, gender: 1, bio: "My best friend is jake. I love to cook and I just want to explore the erogenous zone of your feet" , sexual_preferences: 0, age: 45, avatar: Rails.root.join("app/assets/images/boyle/boyle-1.jpg").open, interest_ids: [3, 4, 5, 11, 12], postal_code: "94555")
#     Profile.create(user_id: 6, gender: 0, bio: "My spirit animal is a wolf and I know best" , sexual_preferences: 0, age: 29, avatar: Rails.root.join("app/assets/images/gina/gina-1.jpg").open, interest_ids: [2, 5, 6, 7, 8, 9], postal_code: "94555")

#     Profile.create!(user_id: 6, gender: 0, bio: "I dont like talking. Bios are stupid" , sexual_preferences: 2, age: 33, avatar: Rails.root.join("app/assets/images/gina/gina-1.jpg").open, interest_ids: [1, 2, 4, 6, 7, 8, 9, 12], postal_code: "94555")
# end
# #Profile Images
# for 
# Picture.create!(profile_id: 1, image: Rails.root.join("app/assets/images/jp/jp1.png").open)
# Picture.create!(profile_id: 2, image: Rails.root.join("app/assets/images/amy/amy1.png").open)

# Visit.create!(profile_id: 1, visitor_id: 2)
# Visit.create!(profile_id: 2, visitor_id: 1)

# Like.create!(profile_id: 2, user_id: 1)
# Like.create!(profile_id: 1, user_id: 2)



                  