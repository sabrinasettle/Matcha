class Interest < ApplicationRecord
    has_and_belongs_to_many :profiles, dependent: :destroy
    validates :name, uniqueness: true
    acts_as_taggable_on :tag
end
