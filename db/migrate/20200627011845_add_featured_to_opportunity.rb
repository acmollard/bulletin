class AddFeaturedToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :featured, :boolean
  end
end
