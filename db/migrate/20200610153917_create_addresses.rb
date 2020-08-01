class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :street
      t.integer :zip
      t.integer :organization_id

      t.timestamps
    end
  end
end
