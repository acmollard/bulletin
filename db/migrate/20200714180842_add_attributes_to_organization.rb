class AddAttributesToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :approved, :boolean
    add_column :organizations, :approved, :boolean
    add_column :organizations, :registered, :boolean
    add_column :organizations, :ein, :string
  end
end
