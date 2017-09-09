class AddPrivateEmailToShelters < ActiveRecord::Migration[5.1]
  def change
    change_table :shelters do |t|
      t.string :private_email
    end
  end
end
