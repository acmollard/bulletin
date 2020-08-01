class CreateOrganizationRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_ratings do |t|
      t.integer :rating
      t.integer :organization_id

      t.timestamps
    end
  end
end
