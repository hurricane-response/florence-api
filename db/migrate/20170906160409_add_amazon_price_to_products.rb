class AddAmazonPriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :amazon_products, :price_in_cents, :integer, default: 0
  end
end
