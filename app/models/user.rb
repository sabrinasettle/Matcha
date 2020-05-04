class User < ApplicationRecord

  before_create :set_confirmation_token
  include PgSearch::Model 
  

  attr_accessor :skip_validations



  # :presence => {:message => "Title can't be blank." },
  #         :uniqueness => {:message => "Title already exists."},
# need to get the messages out when I can
  validates :first_name, :last_name, presence: {:message => "Required input, please try again"}
  validates_format_of :first_name, :last_name, :with => /[a-z]/
  validates :user_name, presence: {:message => "Required input, please try again"}, 
    uniqueness: {:message => "Username already taken"}, :length => { :minimum => 4, :maximum => 25, :message => "Must be more than 4 and less than 25 characters"}
  # validates_length_of :foo, minimum: 4, maximum: 25, message: "Username must be 4 to 25 characters long"
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: {:message => "Required input, please try again"}, uniqueness: true

  validates :password, presence: true, length: { :minimum => 7, :maximum => 20, :message => "Password must be between 8 and 20 characters, with a special character and a number "}, unless: :skip_validations 
  validates_confirmation_of :password
  # validates_presence_of :password_digest
  has_secure_password

  #each user has one profile, which belong_to them as a assoication
  has_one :profile, dependent: :destroy #, inverse_of: :user
  
  #accepts creation of another object from this one
  accepts_nested_attributes_for :profile, update_only: true, allow_destroy: true 
  has_many :likes, dependent: :destroy
  has_many :blocks, dependent: :destroy

  has_many :matches
  has_many :conversations, through: :matches
  has_many :messages

  
  # belongs_to_and_has_many :conversations #, foreign_key: :sender_id
  # has_many :messages, through: :conversations

  # has_many :messages
  # #commented out because it was doing something weird
  # has_many :conversations, foreign_key: :sender_id
  
  def activate?
    update_attribute('email_confirmed', true)
    update_attribute('confirm_token', nil)
    if self.email_confirmed = true
      return true
    else
      return false
    end
  end
  
  def profile?
    update_attribute('profile_created', true)
    self.profile.update_attribute('has_activity', true)
    if self.profile_created = true
      return true
    else
      return false
    end
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64.to_s
    end while User.exists?(column => self[column])
  end
  
  # returns true or false if a profile is liked by another profile
  def likes?(profile)
    self.likes.where(["profile_id = :p", {p: profile.user_id}]).any?
  end

  def blocks?(profile)
  #   puts "hey"
    self.blocks.where(["profile_id = :p", {p: profile.user_id}]).any?
      # puts "hey hey"
    # end
  end

  #search method
  def self.search(search)
    if search
      user = User.find_by(user_name: search)
      if user
        self.where(user_id: user)
      end
    end
  end

  # Delete activites before destroying the user
  before_destroy :delete_activities

  def delete_activities
      acts = PublicActivity::Activity.where(owner_id: self.id, owner_type: "User")
      acts.delete_all
  end

    
  private
    def set_confirmation_token
      if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end
