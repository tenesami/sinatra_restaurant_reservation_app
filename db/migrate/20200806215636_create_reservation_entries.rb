class CreateReservationEntries < ActiveRecord::Migration
  def change
    create_table :reservation_entries do |t|

      t.timestamps null: false
    end
  end
end
