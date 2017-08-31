class ChangeLatLongToFloats < ActiveRecord::Migration[5.1]
  def change
    execute("DELETE FROM shelters")
    execute("DELETE FROM needs")

    execute("ALTER TABLE shelters ALTER COLUMN latitude TYPE float USING (latitude::float)")
    execute("ALTER TABLE shelters ALTER COLUMN longitude TYPE float USING (longitude::float)")
    execute("ALTER TABLE needs ALTER COLUMN latitude TYPE float USING (latitude::float)")
    execute("ALTER TABLE needs ALTER COLUMN longitude TYPE float USING (longitude::float)")


  end
end
