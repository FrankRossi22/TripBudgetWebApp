class CreateTripExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :trip_expenses do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
