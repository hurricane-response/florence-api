class AddUpdateDraftTable < ActiveRecord::Migration[5.1]
  def change
    create_table :drafts do |t|
      t.jsonb :info
      t.timestamps
    end

    add_reference(:drafts, :record, polymorphic: true)
  end
end
