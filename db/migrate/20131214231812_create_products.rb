class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :name
      t.string :brand
      t.string :retailer_name
      t.string :url
      t.text   :description
      t.float  :retail_price
      t.float  :sale_price
      t.string :image_large
      t.string :image
      t.string :color
      t.string :size
      t.string :extract_date

      t.timestamps
    end
  end
end
