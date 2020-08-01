class MakeAddressPolymorphic < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :organization_id
    add_reference :addresses, :locatable, polymorphic: true, index: true
  end
end
