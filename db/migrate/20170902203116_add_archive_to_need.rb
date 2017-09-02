class AddArchiveToNeed < ActiveRecord::Migration[5.1]
  def change
    add_column :needs, :active, :boolean, default: true
    add_column :shelters, :active, :boolean, default: true
  end
end
