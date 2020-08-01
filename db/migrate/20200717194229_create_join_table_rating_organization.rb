class CreateJoinTableRatingOrganization < ActiveRecord::Migration[6.0]
  def change
    create_join_table :ratings, :organizations do |t|
      # t.index [:rating_id, :organization_id]
      # t.index [:organization_id, :rating_id]
    end
  end
end
