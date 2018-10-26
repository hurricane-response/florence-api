class CreateShelters < ActiveRecord::Migration[5.1]
  def change
    create_table :shelters do |t|
      t.string :county
      t.string :shelter
      t.string :address
      t.string :city
      t.string :pets
      t.string :phone
      t.boolean :accepting
      t.string :last_updated
      t.string :updated_by
      t.string :notes
      t.string :volunteer_needs
      t.string :longitude
      t.string :latitude
      t.string :supply_needs
      t.string :source
      t.string :address_name

      t.timestamps
    end
  end
end
