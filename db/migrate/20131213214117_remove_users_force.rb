class RemoveUsersForce < ActiveRecord::Migration
  def change
    drop_table :users_forces
  end
end
