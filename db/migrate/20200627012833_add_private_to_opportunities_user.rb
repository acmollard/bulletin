class AddPrivateToOpportunitiesUser < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities_users, :private, :boolean
  end
end
