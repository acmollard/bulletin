class AddLongitudeLatitudeToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :longitude, :float
    add_column :opportunities, :latitude, :float
  end
end
