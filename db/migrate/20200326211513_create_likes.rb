class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer "profile_id"
      t.integer "user_id"
      t.index ["profile_id"], name: "index_likes_on_profile_id"
      t.index ["user_id"], name: "index_likes_on_user_id"
      t.timestamps
    end
  end
end
