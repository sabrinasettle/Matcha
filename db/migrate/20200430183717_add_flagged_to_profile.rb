class AddFlaggedToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :is_flagged, :boolean, default: false
  end
end
