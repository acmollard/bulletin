class AddStepsToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :next_steps, :string
  end
end
