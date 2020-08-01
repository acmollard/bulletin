class AddRequirementsToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :requirements, :string
  end
end
