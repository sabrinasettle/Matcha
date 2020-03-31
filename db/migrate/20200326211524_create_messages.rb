class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text "body"
      t.integer "conversation_id"
      t.integer "user_id"
      t.timestamps
      t.index ["conversation_id"], name: "index_messages_on_conversation_id"
      t.index ["user_id"], name: "index_messages_on_user_id"
    end
  end
end
