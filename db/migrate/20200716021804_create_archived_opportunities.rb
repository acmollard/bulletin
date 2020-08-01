class CreateArchivedOpportunities < ActiveRecord::Migration[6.0]
  def change
    create_table :archived_opportunities do |t|
      t.string :title
      t.integer :date
      t.float :hours
      t.string :organization

      t.timestamps
    end
  end
end
