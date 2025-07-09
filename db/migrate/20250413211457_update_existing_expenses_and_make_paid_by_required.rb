class UpdateExistingExpensesAndMakePaidByRequired < ActiveRecord::Migration[8.0]
  def up
    # First, let's delete any expenses that don't have associated people
    execute <<-SQL
      DELETE FROM expenses 
      WHERE NOT EXISTS (
        SELECT 1 
        FROM people p
        INNER JOIN participations part ON part.person_id = p.id
        WHERE part.trip_id = expenses.trip_id
      );
    SQL

    # Now update remaining expenses to use the first person in the trip as paid_by
    execute <<-SQL
      UPDATE expenses 
      SET paid_by_id = (
        SELECT p.id 
        FROM people p
        INNER JOIN participations part ON part.person_id = p.id
        WHERE part.trip_id = expenses.trip_id
        LIMIT 1
      )
      WHERE paid_by_id IS NULL;
    SQL

    # Make the column non-nullable
    change_column_null :expenses, :paid_by_id, false
  end

  def down
    change_column_null :expenses, :paid_by_id, true
  end
end
