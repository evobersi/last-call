class RemoveUsersForce < ActiveRecord::Migration
  def change
    drop_table :users__forces
  end
end
