class Block < ApplicationRecord
    belongs_to :profile
    belongs_to :user

    # validates :user_id, uniqueness: { scope: :blocked_user }
end
