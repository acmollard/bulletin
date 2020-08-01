class CreateJoinTableOpportunitiesTags < ActiveRecord::Migration[6.0]
  def change
    create_join_table :opportunities, :tags do |t|
      # t.index [:opportunity_id, :tag_id]
      # t.index [:tag_id, :opportunity_id]
    end
  end
end
