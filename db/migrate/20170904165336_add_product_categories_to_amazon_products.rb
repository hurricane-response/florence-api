class AddProductCategoriesToAmazonProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :amazon_products, :category_specific, :string, default: ''
    add_column :amazon_products, :category_general, :string, default: ''
  end
end
