class AddWebsiteToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :website, :string
  end
end
