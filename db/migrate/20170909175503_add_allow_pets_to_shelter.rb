class AddAllowPetsToShelter < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :allow_pets, :boolean
  end
end
