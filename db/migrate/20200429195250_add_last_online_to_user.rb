class AddLastOnlineToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_online, :datetime
  end
end
