class AddCreatedByToDrafts < ActiveRecord::Migration[5.1]
  def change
    add_column :drafts, :created_by_id, :int
  end
end
