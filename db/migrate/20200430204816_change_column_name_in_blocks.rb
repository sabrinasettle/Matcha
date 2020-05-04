class ChangeColumnNameInBlocks < ActiveRecord::Migration[5.2]
  def change
    rename_column :blocks, :blocked_user, :profile_id
  end
end
