class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :seat_number
      t.references :user, null: false, foreign_key: true
      t.references :flight, null: false, foreign_key: true
      t.references :seat_class_choice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
