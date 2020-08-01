class AddPocEmailToOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :poc_email, :string
  end
end
