class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
    t.integer "user_id"
    t.string "user_name"
    t.integer "gender"
    t.text "bio"
    t.integer "sexual_preferences"
    t.integer "age"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "postal_code"
    t.float "longitude"
    t.float "latitude"
    t.index ["user_id"], name: "index_profiles_on_user_id"
    t.timestamps
  end
  end
end
