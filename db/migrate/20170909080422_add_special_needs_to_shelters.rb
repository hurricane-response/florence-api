class AddSpecialNeedsToShelters < ActiveRecord::Migration[5.1]
  def change
    change_table :shelters do |t|
      t.boolean :special_needs
    end
  end
end
