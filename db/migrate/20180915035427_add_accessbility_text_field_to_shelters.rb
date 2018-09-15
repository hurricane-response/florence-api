class AddAccessbilityTextFieldToShelters < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :accessibility, :text
  end
end
