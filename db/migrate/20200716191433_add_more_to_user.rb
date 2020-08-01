class AddMoreToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :degree, :string
    add_column :users, :school, :string
    add_column :users, :department, :string
    add_column :users, :position, :string
  end
end
