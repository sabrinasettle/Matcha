class Profile < ApplicationRecord
    
    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode

    belongs_to :user
    acts_as_taggable_on :interests

    validates :user_id, :bio, :sexual_preferences, :gender, presence: true
    validates :age, numericality: { greater_than: 17, less_than_or_equal_to: 90 }

    enum gender: [:Female, :Male]
    enum sexual_preferences: [:Straight, :Gay, :Bisexual]
    
    #Work on -- Add validation to bio so only numbers and letters can be added I think
    validates :bio, length: { maximum: 500,
        message: "%{count} characters is the maximum allowed" }
    validates :postal_code, presence: true
    validates_format_of :postal_code,
                    :with => /[0-9]{5}(-[0-9]{4})?/, #Work on -- needs to be tested
                    :message => "should be 12345 or 12345-1234"          
    
    has_attached_file :avatar, styles: { large: '200x200#', medium: '152x152#', thumb: "50x50#", tiny: "28x28#" }, 
    :default_url => '/assets/images/no-image-icon.png', attachment_presence: true, dependent: :destroy
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
    validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]

    has_many :pictures, dependent: :destroy
    validates :pictures, :length => { :maximum => 4 }

    has_and_belongs_to_many :interests, dependent: :destroy

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

    def set_lat_and_long
        unless postal_code.nil?
            self.latitude = postal_code.to_lat
            self.longitude = postal_code.to_lon
            self.save
        end
    end
    
    def previously_flagged?
        self.is_flagged == false ? true : false    
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
        if user.user_rating < 10
            user.increment!(:user_rating, 0.2)
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

            

            
            # Suggestions and Feed
            scope :male, -> { where gender: 'Male' }
            scope :female, -> { where gender: 'Female' }
            scope :gay, -> { where sexual_preferences: 'Gay' }
            scope :straight, -> { where sexual_preferences: 'Straight'}
            scope :order_by_rating, -> { order(user_rating: :desc) }
            scope :order_by_interests_in_common, -> (user){ where id: user.find_related_interests.to_a.pluck(:id)}
            scope :order_by_distance, -> (user){near(user.address, 100).order("distance") }
            # m = Profile.near(Profile.second.address, 50, units: :mi).order("distance")
            # Sorting
            scope :order_by_age, -> { order(age: :asc) }
            # scope :order_by_, -> { order(age: :asc) }
            # Filtering
            scope :by_age_range, ->(min_age, max_age) {where(age: min_age..max_age)}
            scope :by_rating_range, ->(low, high) {where(user_rating: low..high)}#.order(user_rating: :desc)}
            scope :by_distance_range, ->(far, user) {near(user.address, far)}

            # added for filtering

            # scope :for_age_range, -> min, max {
            #     where("date_part('year', age(birthdate)) >= ? AND date_part('year', age(birthdate)) <= ?", min, max)
            # }

            scope :filter_profiles, ->(param={}) {
            #     all
            #     + relation.sort_by(param[:sort_by],param[:sort_type]) if param[:sort_by].present?
            #     + relation.author(param[:author]) if param[:author].present?
            #     + relation.assignee(param[:assignee]) if param[:assignee].present?
            #     + relation.milestone(param[:milestone]) if param[:milestone].present?
            }

            #OR 
            # scope :search, ->(param={}) {
            #     relation = all
            #     relation = relation.sort_by(param[:sort_by],param[:sort_type]) if param[:sort_by].present?
            #     relation = relation.author(param[:author]) if param[:author].present?
            #     relation = relation.assignee(param[:assignee]) if param[:assignee].present?
            #     relation = relation.milestone(param[:milestone]) if param[:milestone].present?
            #     relation
            # }
            # https://stackoverflow.com/questions/39091525/reuse-multiple-scopes-in-another-scope-to-create-search-multiple-fields-in-rails
end