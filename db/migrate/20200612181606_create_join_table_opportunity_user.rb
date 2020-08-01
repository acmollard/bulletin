class CreateJoinTableOpportunityUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :opportunities, :users do |t|
      t.index :opportunity_id
      t.index :user_id
    end
  end
end
