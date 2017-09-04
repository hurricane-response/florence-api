class AddArchiveToCharitableOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :charitable_organizations, :active, :boolean, default: true, null: false
  end
end
