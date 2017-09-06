class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :key, default: "", unique: true, null: false
      t.text :content, default: "", null: false

      t.timestamps
    end
  end
end
