class ConvertAcceptingToEnum < ActiveRecord::Migration[5.1]
  def up
    # NOTE: Wanted to RAISE a DB error on unknown value,
    #       but seems Rails/AR doesn't support that
    # ... ELSE RAISE EXCEPTION 'UNKNOWN ACCEPTING VALUE IN ROW (ID %): %', id, accepting
    execute <<-DDL
      CREATE TYPE shelter_accepting_value AS ENUM (
        'true', 'false', 'unknown'
      );

      ALTER TABLE shelters
      ALTER COLUMN accepting TYPE shelter_accepting_value
      USING CASE accepting
            WHEN TRUE THEN 'true'::shelter_accepting_value
            WHEN FALSE THEN 'false'::shelter_accepting_value
            WHEN NULL THEN 'unknown'::shelter_accepting_value
            ELSE 'unknown'::shelter_accepting_value
      END
    DDL
  end
  def down
    execute <<-DDL
      ALTER TABLE shelters
      ALTER COLUMN accepting TYPE boolean
      USING CASE accepting
            WHEN 'true'::shelter_accepting_value THEN TRUE
            WHEN 'false'::shelter_accepting_value THEN FALSE
            WHEN 'unknown'::shelter_accepting_value THEN NULL
            ELSE NULL
      END

      DROP TYPE shelter_accepting_value;
    DDL
  end
end
