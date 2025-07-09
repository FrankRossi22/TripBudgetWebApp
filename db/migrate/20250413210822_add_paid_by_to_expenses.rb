class AddPaidByToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_reference :expenses, :paid_by, null: true, foreign_key: { to_table: :people }
  end
end
