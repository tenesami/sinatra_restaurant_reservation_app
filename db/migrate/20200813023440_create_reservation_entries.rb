class CreateReservationEntries < ActiveRecord::Migration
  def change
    create_table :reservation_entries do |t|
      t.string :restaurant_name
      t.string :numOfTable
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
