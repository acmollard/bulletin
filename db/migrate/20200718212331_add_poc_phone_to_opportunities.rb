class AddPocPhoneToOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :poc_phone, :string
  end
end
