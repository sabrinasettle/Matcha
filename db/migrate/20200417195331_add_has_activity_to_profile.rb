class AddHasActivityToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :has_activity, :boolean, default: false
  end
end
