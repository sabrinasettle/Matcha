class Like < ApplicationRecord
  include PublicActivity::Common
  # tracked
  # tracked owner: ->(controller, model) { controller.current_user }
  belongs_to :profile
  belongs_to :user

  validates :user_id, uniqueness: { scope: :profile_id }

end
