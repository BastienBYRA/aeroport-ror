class ChangeDataTypeForFlightDateDeparture < ActiveRecord::Migration[7.0]
  def self.up
  change_table :flights do |t|
    t.change :departure_date, :datetime
  end
end
def self.down
  change_table :flights do |t|
    t.change :departure_date, :date
  end
end
end
