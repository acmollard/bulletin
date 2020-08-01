class CreateJoinTableArchivedOpportunityUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :archived_opportunities, :users do |t|
      # t.index [:archived_opportunity_id, :user_id]
      # t.index [:user_id, :archived_opportunity_id]
    end
  end
end
