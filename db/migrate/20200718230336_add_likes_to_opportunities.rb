class AddLikesToOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :likes, :integer
  end
end
