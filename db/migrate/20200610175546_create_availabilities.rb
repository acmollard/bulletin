class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.integer :epoch_time
      t.integer :user_id

      t.timestamps
    end
  end
end
