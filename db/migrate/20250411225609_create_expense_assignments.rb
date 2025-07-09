class CreateExpenseAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_assignments do |t|
      t.references :person, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
