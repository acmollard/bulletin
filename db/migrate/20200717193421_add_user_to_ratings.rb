class AddUserToRatings < ActiveRecord::Migration[6.0]
  def change
    add_reference :ratings, :user
  end
end
