class CreateOpportunities < ActiveRecord::Migration[6.0]
  def change
    create_table :opportunities do |t|
      t.integer :date
      t.string :title
      t.string :location
      t.text :description
      t.integer :volunteers_needed
      t.integer :organization_id

      t.timestamps
    end
  end
end
