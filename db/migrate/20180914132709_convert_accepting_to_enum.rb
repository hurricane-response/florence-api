class ConvertAcceptingToEnum < ActiveRecord::Migration[5.1]
  def up
    execute <<-DDL
      CREATE TYPE shelter_accepting_value AS ENUM (
        'yes', 'no', 'unknown'
      );

      ALTER TABLE shelters
      ALTER COLUMN accepting TYPE shelter_accepting_value
      USING CASE accepting
            WHEN TRUE THEN 'yes'::shelter_accepting_value
            WHEN FALSE THEN 'no'::shelter_accepting_value
            ELSE 'unknown'::shelter_accepting_value
      END
    DDL
  end

  def down
    execute <<-DDL
      ALTER TABLE shelters
      ALTER COLUMN accepting TYPE boolean
      USING CASE accepting
            WHEN 'yes'::shelter_accepting_value THEN TRUE
            WHEN 'no'::shelter_accepting_value THEN FALSE
            ELSE NULL
      END

      DROP TYPE shelter_accepting_value;
    DDL
  end
end
