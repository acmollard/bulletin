class AddRequireApprovalsToOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :require_approvals, :boolean
  end
end
