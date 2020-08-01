class AddActiveToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :active, :boolean
  end
end
