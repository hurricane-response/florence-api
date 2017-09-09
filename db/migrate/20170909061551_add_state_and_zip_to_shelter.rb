class AddStateAndZipToShelter < ActiveRecord::Migration[5.1]
  def change
    change_table :shelters do |t|
      t.string :state
      t.string :zip
      t.string :google_place_id
    end
  end
end
