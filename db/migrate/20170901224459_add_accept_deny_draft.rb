class AddAcceptDenyDraft < ActiveRecord::Migration[5.1]
  def change
    add_reference :drafts, :accepted_by, {foreign_key: {to_table: :users}}
    add_reference :drafts, :denied_by, {foreign_key: {to_table: :users}}
  end
end
