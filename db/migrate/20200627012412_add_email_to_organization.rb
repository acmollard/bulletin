class AddEmailToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :email, :string
  end
end
