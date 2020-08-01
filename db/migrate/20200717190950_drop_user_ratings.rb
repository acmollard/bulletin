class DropUserRatings < ActiveRecord::Migration[6.0]
  def change
    drop_table :user_ratings
    drop_table :organization_ratings
  end
end
