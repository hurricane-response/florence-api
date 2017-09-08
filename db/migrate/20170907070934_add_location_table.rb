class AddLocationTable < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      # Core location information
      t.string  :name
      t.string  :address
      t.string  :city
      t.string  :state
      t.string  :zip
      t.string  :phone
      t.boolean :active, default: true, null: false
      # Storage for legacy information
      t.string  :organization
      t.string  :legacy_table_name
      t.jsonb   :legacy_data, default: {}, null: false
      t.float   :latitude
      t.float   :longitude

      t.timestamps
    end
  end
end
