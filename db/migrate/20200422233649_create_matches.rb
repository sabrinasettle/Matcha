class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :conversation, foreign_key: true

      t.timestamps
    end
    add_index :matches, [:user_id, :conversation_id], unique: true
  end
end
