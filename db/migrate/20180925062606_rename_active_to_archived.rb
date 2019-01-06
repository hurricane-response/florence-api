class RenameActiveToArchived < ActiveRecord::Migration[5.1]
  # DOES NOT rename Distribution Points because they are correct since inclusion

  def up
    rename_column :shelters, :active, :archived
    change_column_default :shelters, :archived, false

    rename_column :needs, :active, :archived
    change_column_default :needs, :archived, false

    execute <<-SQL
      UPDATE shelters SET archived = NOT archived;
      UPDATE needs SET archived = NOT archived;
    SQL
  end

  def down
    rename_column :shelters, :archived, :active
    change_column_default :shelters, :active, true

    rename_column :needs, :archived, :active
    change_column_default :needs, :active, true

    execute <<-SQL
      UPDATE shelters SET active = NOT active;
      UPDATE needs SET active = NOT active;
    SQL
  end
end
