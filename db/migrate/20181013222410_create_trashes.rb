class CreateTrashes < ActiveRecord::Migration[5.1]
  def change
    create_table :trashes do |t|
      t.references :trashable, polymorphic: true, null: false
      t.jsonb :data
      t.references :user, foreign_key: true
      t.text :reason
      t.timestamps
    end
  end
end
