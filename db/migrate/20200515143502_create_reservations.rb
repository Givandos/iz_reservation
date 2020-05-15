class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :table, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :open_time, null: false
      t.datetime :close_time, null: false

      t.timestamps
    end
  end
end
