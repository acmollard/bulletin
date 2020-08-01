class AddInterestedToOpportunitiesUser < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities_users, :interested, :boolean
  end
end
