class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      t.date :Start_Date
      t.date :End_Date
      t.string :People
      t.string :name
      t.timestamps
    end
  end
end
