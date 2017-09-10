class AddUnofficialToShelters < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :unofficial, :boolean
  end
end
