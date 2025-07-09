class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.float :Amount
      t.string :People
      t.integer :trip_id

      t.timestamps
    end
  end
end
