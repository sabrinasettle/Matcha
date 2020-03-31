class User < ApplicationRecord

  before_create :set_confirmation_token

  validates :first_name, :last_name, presence: true
  validates :user_name, presence: true, uniqueness: true, length: { in: 4..25 }
  validates :email, presence: true, uniqueness: true
  # validates :password, length: { in: 7..20 }
  validates_presence_of :password_digest
  has_secure_password

  #each user has one profile, which belong_to them as a assoication
  has_one :profile, dependent: :destroy #, inverse_of: :user
  
  #accepts creation of another object from this one
  accepts_nested_attributes_for :profile, update_only: true, allow_destroy: true 
  has_many :likes, dependent: :destroy

  has_many :messages
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
  
  def change_lat_long(profile)
    lat = profile.postal_code.to_lat
    long = profile.postal_code.to_lon
    self.update_attributes(latitude: lat, longitude: long)
  end
  
  # returns true or false if a profile is liked by another profile
  def likes?(profile)
    self.likes.where(["profile_id = :p", {p: profile.id}]).any?
  end

  def find_location(user)
    if current_user == user
        
    end
  end

    
  private
    def set_confirmation_token
      if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end
