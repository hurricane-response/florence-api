class CreateCharitableOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :charitable_organizations do |t|
      t.string :name
      t.string :services
      t.boolean :food_bank
      t.string :donation_website
      t.string :phone_number
      t.string :email
      t.string :physical_address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
