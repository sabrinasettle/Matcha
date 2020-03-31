class Like < ApplicationRecord
  belongs_to :profile
  belongs_to :user

  validates :user_id, uniqueness: { scope: :profile_id }
end
