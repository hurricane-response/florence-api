class CreateAmazonProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :amazon_products do |t|
      t.string :need, unique: true, allow_null: false
      t.string :amazon_title, allow_null: false
      t.string :asin, allow_null: false
      t.string :detail_url, allow_null: false

      t.timestamps
    end
  end
end
