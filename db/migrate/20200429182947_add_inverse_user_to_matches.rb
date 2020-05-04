class AddInverseUserToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :inverse_user, :integer
    add_index :matches, :inverse_user
  end
end
