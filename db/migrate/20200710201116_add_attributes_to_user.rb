class AddAttributesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :affiliation, :string
    add_column :users, :grad_year, :string
    add_column :users, :description, :string
    add_column :users, :major, :string
    add_column :users, :gender, :string
  end
end
