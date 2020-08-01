class ChangeDescriptionToText < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :description, :text
    change_column :opportunities, :preferences, :text
    change_column :opportunities, :requirements, :text
    change_column :opportunities, :next_steps, :text
  end
end
