class AddAccessbilityTextFieldToShelters < ActiveRecord::Migration[5.1]
  def up
    add_column :shelters, :accessibility, :text
    Shelter.where(special_needs: true).update_all(accessibility: 'Yes (more detail needed)')
    Shelter.where(special_needs: false).update_all(accessibility: 'No')
  end

  def down
    remove_column :shelters, :accessibility
  end
end
