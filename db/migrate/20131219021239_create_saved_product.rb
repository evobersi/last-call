class CreateSavedProduct < ActiveRecord::Migration
  def change
    create_table :saved_product do |t|
      t.references :search, null: false
      t.references :user, null: false
      t.boolean :added, default: false
    end
  end
end
