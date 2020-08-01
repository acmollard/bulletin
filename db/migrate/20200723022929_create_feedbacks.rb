class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.text :description
      t.boolean :anonymous

      t.timestamps
    end

    add_reference :feedbacks, :user
    add_reference :feedbacks, :organization
    add_reference :feedbacks, :opportunity
  end
end
