class CreateConnectMarkers < ActiveRecord::Migration[5.1]
  def change
    create_table :connect_markers do |t|
      t.string :marker_type, null: false
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :phone, null: false, default: ""
      t.string :category, null: false, default: ""
      t.boolean :resolved, null: false, default: false
      t.float :latitude, null: false, default: 0.0
      t.float :longitude, null: false, default: 0.0
      t.string :address, null: false, default: ""

      t.timestamps
    end
    add_index :connect_markers, [:latitude, :longitude]
    add_index :connect_markers, :category
    add_index :connect_markers, :resolved, name: "index_connect_markers_on_unresolved", where: "(resolved IS FALSE)"
  end
end
