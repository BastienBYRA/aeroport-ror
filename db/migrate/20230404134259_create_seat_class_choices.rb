class CreateSeatClassChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :seat_class_choices do |t|
      t.string :name

      t.timestamps
    end
  end
end
