class CreateJoinTableOpportunityApproval < ActiveRecord::Migration[6.0]
  def change
    create_join_table :opportunities, :approvals do |t|
      # t.index [:opportunity_id, :approval_id]
      # t.index [:approval_id, :opportunity_id]
    end
  end
end
