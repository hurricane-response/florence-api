class AddDeviceUuidConnectMarkers < ActiveRecord::Migration[5.1]
  def change
    add_column :connect_markers, :device_uuid, :string, null: false, default: ''
    add_index :connect_markers, :device_uuid
  end
end
