class AddOrganizationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :organization
  end
end
