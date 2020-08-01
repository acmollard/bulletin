class ChangeUserPassword < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :encrypted_password, :string, :null => true
    change_column_default :users, :encrypted_password, nil
  end
end
