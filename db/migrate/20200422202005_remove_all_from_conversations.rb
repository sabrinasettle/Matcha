class RemoveAllFromConversations < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversations, :recipient_id, :integer
    remove_column :conversations, :sender_id, :integer
  end
end
