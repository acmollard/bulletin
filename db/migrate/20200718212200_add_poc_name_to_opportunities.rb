class AddPocNameToOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :poc_name, :string
  end
end
