class CreateUserRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_ratings do |t|
      t.integer :rating
      t.integer :user_id

      t.timestamps
    end
  end
end
