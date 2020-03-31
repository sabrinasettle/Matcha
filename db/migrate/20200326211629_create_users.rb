class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer "user_id"
      t.string "first_name"
      t.string "last_name"
      t.string "email"
      t.string "user_name"
      t.string "password_digest"
      t.string "password_confirmation"
      t.boolean "email_confirmed", default: false
      t.string "confirm_token"
      t.string "password_reset_token"
      t.datetime "password_reset_sent_at"
      t.boolean "profile_created", default: false
      t.boolean "online", default: false
      t.float "longitude"
      t.float "latitude"
      t.timestamps
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["user_id"], name: "index_users_on_user_id"
      t.index ["user_name"], name: "index_users_on_user_name", unique: true
    end
  end
end
