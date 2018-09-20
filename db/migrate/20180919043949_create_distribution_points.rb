class CreateDistributionPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :distribution_points do |t|
      t.string :facility_name
      t.string :address
      t.string :city
      t.string :county
      t.string :state
      t.string :zip
      t.string :phone
      t.string :updated_by
      t.string :notes
      t.string :source
      t.float :longitude
      t.float :latitude
      t.string :google_place_id
      t.boolean :active, default: true
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
