class Profile < ApplicationRecord

    belongs_to :user

    validates :user_id, :bio, :sexual_preferences, :gender, presence: true
    validates_numericality_of :age, greater_than_or_equal_to: 18, less_than_or_equal_to: 100, message: 'Must be older than 18 years old'
    enum gender: [:female, :male]
    enum sexual_preferences: [:heterosexual, :gay, :bisexual]
    validates :bio, length: { maximum: 500,
        too_long: "%{count} characters is the maximum allowed" }
    validates_format_of :postal_code,
                    :with => /[0-9]{5}(-[0-9]{4})?/, #needs to be tested
                    :message => "should be 12345 or 12345-1234"          
    
    #profile pictures(avatar/gallery)
    has_attached_file :avatar, styles: { medium: '152x152#', thumb: "100x100>" }, 
    :default_url => '/assets/images/no-image-icon.png', attachment_presence: true, dependent: :destroy
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
    validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]

    has_many :pictures, dependent: :destroy
    # validate :validate_images

    has_and_belongs_to_many :interests, dependent: :destroy

    # Each Profile as many of these models, which means the Profile id is in these tables
    has_many :visits
    has_many :visitors, through: :visits
    
    has_many :likes, dependent: :destroy 
    
    # geocoded_by :address

    # def address 
        # [street, city, zip, state].compact.join(", ")
    # end



    # sorting
        # https://www.chrisjmendez.com/2016/12/31/rails-order-by-desc/
        #but by location
        #scope :desc, order(name: :desc)

    def self.search(search)
        where("user_name LIKE ?", "%#{search}%") 
        # where("content LIKE ?", "%#{search}%")
    end

    
    private
        def validate_images
            return if pictures.count < 4
            errors.add(:pictures, 'You can upload max 4 images')
        end
    
end
