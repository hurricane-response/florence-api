class AddDataToMarkers < ActiveRecord::Migration[5.1]
  def change
    add_column :connect_markers, :data, :jsonb, null: false, default: {}
  end
end
