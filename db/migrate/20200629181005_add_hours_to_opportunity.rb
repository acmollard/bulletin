class AddHoursToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :hours, :float
  end
end
