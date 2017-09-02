class CreateIgnoredAmazonProductNeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :ignored_amazon_product_needs do |t|
      t.string :need

      t.timestamps
    end
  end
end
