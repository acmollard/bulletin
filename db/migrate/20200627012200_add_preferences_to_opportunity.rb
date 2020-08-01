class AddPreferencesToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :preferences, :string
  end
end
