class CreateParticipations < ActiveRecord::Migration[8.0]
  def change
    create_table :participations do |t|
      t.references :person, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
