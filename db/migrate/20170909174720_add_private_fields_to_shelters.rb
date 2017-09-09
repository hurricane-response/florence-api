class AddPrivateFieldsToShelters < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :private_sms, :string
    add_column :shelters, :private_volunteer_data_mgr, :string
  end
end
