class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.integer "profile_id"
      t.string "image_file_name"
      t.string "image_content_type"
      t.bigint "image_file_size"
      t.datetime "image_updated_at"
      t.timestamps
    end
  end
end
