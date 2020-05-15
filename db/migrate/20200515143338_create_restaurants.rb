class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.time :open_time, null: false
      t.time :close_time, null: false

      t.timestamps
    end
  end
end
