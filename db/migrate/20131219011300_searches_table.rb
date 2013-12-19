class SearchesTable < ActiveRecord::Migration
  def change
    drop_table :products
      create_table :searches do |t|
      t.string   "name"
      t.string   "brand"
      t.string   "retailer_name"
      t.string   "url"
      t.text     "description"
      t.float    "retail_price"
      t.float    "sale_price"
      t.string   "image"
      t.string   "size"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "added",         default: false
    end
  end
end
