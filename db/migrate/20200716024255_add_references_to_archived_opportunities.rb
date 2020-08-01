class AddReferencesToArchivedOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_reference :archived_opportunities, :opportunity, null: false, foreign_key: true
  end
end
