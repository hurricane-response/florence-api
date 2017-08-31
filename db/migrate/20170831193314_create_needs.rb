class CreateNeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :needs do |t|

      t.string :updated_by
      t.string :timestamp
      t.string :location_name
      t.string :location_address
      t.string :longitude
      t.string :latitude
      t.string :contact_for_this_location_name
      t.string :contact_for_this_location_phone_number
      t.boolean :are_volunteers_needed
      t.string :tell_us_about_the_volunteer_needs
      t.boolean :are_supplies_needed
      t.string :tell_us_about_the_supply_needs
      t.string :anything_else_you_would_like_to_tell_us
      t.string :source
      t.timestamps
    end
  end
end
