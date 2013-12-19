class ProductsUsers < ActiveRecord::Migration
  def change
    change_table(:products) do |t|
      t.boolean :added, default: false 
    end
  end
end
