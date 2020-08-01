class AddUserToApprovals < ActiveRecord::Migration[6.0]
  def change
    add_reference :approvals, :user
  end
end
