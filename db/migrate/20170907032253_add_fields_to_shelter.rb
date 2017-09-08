class AddFieldsToShelter < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :private_notes, :text
    add_column :shelters, :distribution_center, :text
    add_column :shelters, :food_pantry, :text
  end
end
