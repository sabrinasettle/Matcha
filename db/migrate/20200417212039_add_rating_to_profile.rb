class AddRatingToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :user_rating, :decimal, default: 5.0
  end
end
