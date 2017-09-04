class AddEmailToConnectMarkers < ActiveRecord::Migration[5.1]
  def change
    add_column :connect_markers, :email, :string
  end
end
