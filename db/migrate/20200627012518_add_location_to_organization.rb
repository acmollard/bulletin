class AddLocationToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :location, :string
  end
end
