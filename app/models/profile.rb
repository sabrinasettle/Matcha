class Profile < ApplicationRecord
    
    # Geocoding for later when hosted
    # geocoded_by :ip_address, :latitude => :lat, :longitude => :lon
    # after_validation :geocode

    # reverse_geocoded_by :latitude, :longitude
    # after_validation :reverse_geocode
    

    belongs_to :user
    acts_as_taggable_on :interests

    # Validations.all
    validates :user_id, :bio, :sexual_preferences, :gender, presence: true
    # validates_numericality_of :age, greater_than_or_equal_to: 18, less_than_or_equal_to: 100, message: 'Must be older than 18 years old'
    validates :age, numericality: { greater_than: 17, less_than_or_equal_to: 90 }

    enum gender: [:Female, :Male]
    enum sexual_preferences: [:Straight, :Gay, :Bisexual]
    
    # Add validation to bio so only numbers and letters can be added I think
    validates :bio, length: { maximum: 500,
        message: "%{count} characters is the maximum allowed" }
    validates :postal_code, presence: true
    validates_format_of :postal_code,
                    :with => /[0-9]{5}(-[0-9]{4})?/, #needs to be tested
                    :message => "should be 12345 or 12345-1234"          
    
    #profile pictures(avatar/gallery)
    has_attached_file :avatar, styles: { large: '200x200#', medium: '152x152#', thumb: "50x50#", tiny: "28x28#" }, 
    :default_url => '/assets/images/no-image-icon.png', attachment_presence: true, dependent: :destroy
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
    validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]

    has_many :pictures, dependent: :destroy
    validates :pictures, :length => { :maximum => 4 }

    has_and_belongs_to_many :interests, dependent: :destroy

    # Each Profile as many of these models, which means the Profile id is in these tables
    has_many :visits, dependent: :destroy
    has_many :visitors, through: :visits, dependent: :destroy
    
    has_many :likes, dependent: :destroy 
    has_many :blocks, dependent: :destroy

    def set_interest_tags
        list = self.interests.pluck(:name)
        self.interest_list.add(list)
        self.save
    end

    interests = ["Being Outdoors", "Video Games", "Reading", "Cooking", "Music", "Movies and TV", "Puzzles", "Exercising", "Dancing", "Sports", "Travel", "Family"]


    
    # Filtering
    # pg_search_scope :user_filter,
    # against: [:first_name, :user_name, :user_rating, :age],
    # using: {
        #   tsearch: {any_word: true},
        
        # }
        # associated_against: { interests: :name }

        
        
        # scopes should go as such location, gender/sex, interests
        # scope :distance_to, ->(point) { select("#{table_name}.*").select("(#{distance_from_sql(point)}) as distance") }
        # scope :straight_people, ->(point) { select("#{table_name}.*").select("(#{distance_from_sql(point)}) as distance") }
    # scope :gay_people, ->(point) { select("#{table_name}.*").select("(#{distance_from_sql(point)}) as distance") }
    # scope :common_amount_of interests, ->(point) { select("#{table_name}.*").select("(#{distance_from_sql(point)}) as distance") }
    

    # For Sorting

    # Searching and Filtering logic
    # acts_as_taggable_on :interests
    # acts_as_taggable_on :genders
    # for searches
    # $interest_titles = ['Being Outdoors', 'Video Games','Reading','Cooking', 'Music', 'Movies and TV', 'Puzzles', 'Exercising','Dancing', 'Sports', 'Travel', 'Family']
    # $genders = [:Female, :Male]
    # $sexual_p = [:straight, :gay, :bisexual]
    
    def previously_flagged?
        self.is_flagged == false ? true : false    
    end
    
    
    # --- Blocking Logic ---
    # Validates if a user is blocked
    # validate :is_blocked_by_current_user
    
    
    
    # Method for determing the profiles to ignore because they are blocked
    def is_blocked_by_current_user(profile)
        # Blocks.all.where(user_id: current_user.id).pluck(:blocked_user)
        #other way would be to include blocks.all as an object turned into an array
        
        #Check if the user is blocked or no, and write the logic
        if profile.blocks.any?
            
        end
        
        #self.errors.add()
        
    end
    
    def self.all_except(user)
        # add blocked users to this
        unseen_users = user.blocks.pluck(:profile_id)
        unseen_users << user.id
        where.not(has_activity: false, user_id: unseen_users ) # add any that are blocked by the user#and where.not(user_id: user)
    end

    
    
    
    # sorting
    # https://www.chrisjmendez.com/2016/12/31/rails-order-by-desc/
    #but by location
    #scope :desc, order(name: :desc)
    
    # def self.search(search)
    #     where("user_name LIKE ?", "%#{search}%") 
    #     # where("content LIKE ?", "%#{search}%")
    # end
    
    # https://medium.com/swlh/advanced-filtering-for-your-rails-5-application-28c8da2d29b6
    #     pg_search_scope :user_search,
    #     against: [:first_name, :user_name, :age],
    #     associated_against: {
        #       interests: [:name]
        #     },
        #     using: {
            #       tsearch: {any_word: true}
            #   }
            
            
            
            # See if the user is online, and if not see the date and time of the last connection.
            
            
            
            # Profile Display help from here down
        def gender_of
            if self.gender == "female"
                gen = "F"
            elsif self.gender == "male"
                gen = "M"
            end
            gen
        end
        
        def sex_pref
            if self.sexual_preferences == "Straight"
                pref = "Straight"
            elsif self.sexual_preferences == "Gay"
                pref = "Gay"
            else
                pref = "Bi"
            end
            pref
        end
        
        def round_num
            rating = self.user_rating.round.to_int 
        end
            
            # Adds to the user_rating when doing somehting like likeing/messaging
        def add_to_rating(user)
            
            if user_rating < 10
                user.update(user.user_rating + 0.2)
            end
            
        end

            # --- Logic for suggestions ---

        def male?
            self.gender == "Male"
        end

        def female?
            self.gender == "Female"
        end

        def gay?
            self.sexual_preferences == "Gay"
        end

        def str?
            self.sexual_preferences == "Straight"
        end

        def bi?
            self.sexual_preferences == "Bisexual"
        end
            
            # --- Searching and Filtering ---
            include PgSearch::Model 
        
            # Searching
            pg_search_scope :user_search,
            against: [:first_name, :user_name, :user_rating, :age, :postal_code],
            associated_against: {
              interests: [:name]
            },
            using: {
              tsearch: {any_word: true},
            #   dmetaphone: {any_word: true},
            #   trigram: {threshold: 0.2}
            }

            # table interests_profiles
            # select interests.user_id, interests.count(*) , users.user_name
            # from  interests  
            # inner join users on users.user_id = interests.user_id
            # where interest_id in (select interest_id from interests where user_id = 123)
            # group by interests.user_id,

            # need a method? scope? for interests and common interests
            
            # Suggestions and Feed
            scope :male, -> { where gender: 'Male' }
            scope :female, -> { where gender: 'Female' }
            scope :gay, -> { where sexual_preferences: 'Gay' }
            scope :straight, -> { where sexual_preferences: 'Straight'}
            scope :ordered_by_rating, -> { order(user_rating: :desc) }
            scope :order_by_interests_in_common, -> (user){ where id: user.find_related_interests.to_a.pluck(:id)}
            # scope :order_by_distance, 
            
            # Sorting
            scope :order_by_age, -> { order(age: :asc) }
            # Filtering
            scope :for_age_range, ->(min_age, max_age) {where(age: min_age..max_age).order(age: :asc)}



            # https://stackoverflow.com/questions/31879150/group-by-and-count-using-activerecord


            # SELECT ui.userid, COUNT(*) AS common_interests
            # FROM users_interests ui
            # WHERE ui.interestid IN (
            #     SELECT ui2.interestid FROM users_interests ui2 WHERE ui2.userid = 2
            # ) 
            # AND ui.userid <> 2
            # GROUP BY ui.userid
            # HAVING common_interests     > 3;


            # @activites = Activity.joins(:votes)
            # .group("activites.id")
            # .having("count(votes.id) > ?", params[:vote_count])
            # .order("created_at desc")
            # .where(created_at: 3.months.ago..Time.zone.now.to_date)
            # .page(params[:page])
            # .per_page(72)



            # SELECT users.username, group_concat(movies.name), count(movies.name)
            # FROM user_fave_movies t1
            # INNER JOIN user_fave_movies t2 ON (t2.movie_id = t1.movie_id) 
            # INNER JOIN users ON users.user_id = t2.user_id
            # INNER JOIN movies ON movies.id = t1.movie_id 
            # WHERE t1.user_id = 1 
            # AND t2.user_id <> 1
            # group by users.username
            # order by count(movies.name) desc

            # https://stackoverflow.com/questions/12252465/acts-as-taggable-on-tagged-with-orderrandom

            # https://stackoverflow.com/questions/39748719/count-interest-in-common-in-two-table
            # # select ui.id_users, COUNT(up.id_interest) from users_usersInterest ui left join (SELECT id_interest FROM `users_usersInterest` WHERE id_users = 6) up on up.id_interest = ui.id_interest group by ui.id_users



            # SELECT DISTINCT u.* 
            # FROM
            # (
            #     SELECT t1.user_id id1, t2.user_id id2, COUNT(*) count
            #     FROM interest_user t1 JOIN interest_user t2
            #         ON t1.user_id < t2.user_id
            #     AND t1.interest_id = t2.interest_id 
            #     GROUP BY t1.user_id, t2.user_id
            # ) q JOIN users u
            #     ON q.count >= 2 -- change 2 to how many mutual interests you want to have 
            # AND u.id IN(id1, id2);


            # select interests.user_id, interests.count(*) , users.user_name
            # from  interests  
            # inner join users on users.user_id = interests.user_id
            # where interest_id in (select interest_id from interests where user_id = 1)
            # group by interests.user_id,




            # could need to just 
            # scope :ordered_by_rating, -> { reorder(user_rating: :asc) }

            # scope :common_interests, -> { where sexual_preferences: 'Straight'}
            # scope :high_rating, -> {where}

            # https://stackoverflow.com/questions/2283305/order-by-count-per-value
            # SELECT c.id, c.city
            # FROM cities c
            # JOIN ( SELECT city, COUNT(*) AS cnt
            #     FROM cities
            #     GROUP BY city
            #     ) c2 ON ( c2.city = c.city )
            # ORDER BY c2.cnt DESC;


            # irb(main):081:0> Profile.select(:gender).group(:gender).count
            # Profile.select(:id)
            # Mine
            # SELECT c.user_id
            # FROM profiles c
            # JOIN (SELECT interest, COUNT(*) AS cnt)
            #     FROM


            # https://stackoverflow.com/questions/30734075/need-a-little-sql-help-getting-number-of-items-in-common/30750230#30750230



            # added for filtering

            # scope :for_age_range, -> min, max {
            #     where("date_part('year', age(birthdate)) >= ? AND date_part('year', age(birthdate)) <= ?", min, max)
            # }
end