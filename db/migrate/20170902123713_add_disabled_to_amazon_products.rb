class AddDisabledToAmazonProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :amazon_products, :priority, :boolean, default: false
    add_column :amazon_products, :disabled, :boolean, default: false
  end
end
