class UpdateCategoryOnConnectMarkers < ActiveRecord::Migration[5.1]
  def change
    # This will lose data, but we don't need/want it anyways
    remove_column :connect_markers, :category, :string, null: false, default: ""
    add_column :connect_markers, :categories, :jsonb, null: false, default: {}
    add_index  :connect_markers, :categories, using: :gin
  end
end
