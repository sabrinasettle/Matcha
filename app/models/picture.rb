class Picture < ApplicationRecord
    # belongs_to :user, class_name: 'Profile', foreign_key: :profile_id
    belongs_to :profile, foreign_key: :profile_id

    validates :profile_id, presence: true
    has_attached_file :image, styles: { xlarge: '400x400#', large: '200x200#', medium: '152x152#', small: '100x100#'}, dependent: :destroy
    # validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    # validates_attachment_file_name :image, matches: [/png\z/, /jpe?g\z/, /jpg\z/]    # validates :count
    do_not_validate_attachment_file_type :image
    # validates
    # validates_associated :profile

end
