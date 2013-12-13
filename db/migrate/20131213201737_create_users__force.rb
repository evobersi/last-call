class CreateUsersForce < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :phone
      t.string :gender
      t.string :facebook
      t.string :password_digest, :null => false
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.string :oauth_expires_at
      
      t.timestamps
    end
  end
end
