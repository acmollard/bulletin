class DropOrganizationsUsers < ActiveRecord::Migration[6.0]
  def change
      drop_table :organizations_users
  end
end
