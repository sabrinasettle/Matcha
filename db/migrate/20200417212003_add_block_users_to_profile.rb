class AddBlockUsersToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :blocked_user, :string, array:true, default: []
  end
end
