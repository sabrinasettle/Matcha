class Picture < ApplicationRecord
    belongs_to :user, class_name: 'Profile', foreign_key: :profile_id

    has_attached_file :image, styles: { large: '200x200', medium: '152x152' }, dependent: :destroy

    do_not_validate_attachment_file_type :image

end
