# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'csv'

# Création des vols
CSV.foreach(Rails.root.join('lib/seed_csv/flights.csv'), headers: true) do |row|
  Flight.create( {
                   number: row['number'],
                   departure_airport: row['departure_airport'],
                   arrival_airport: row['arrival_airport'],
                   business_class_seats: row['business_class_seats'].to_i,
                   economy_class_seats: row['economy_class_seats'].to_i,
                   departure_date: row['departure_date'].to_datetime,
                   duration: row['duration'].to_i,
                 } )
end

# Création des classes de sièges
CSV.foreach(Rails.root.join('lib/seed_csv/seat_class_choices.csv'), headers: true) do |row|
  created_at = row['created_at'].present? ? row['created_at'].to_datetime : Time.now
  updated_at = row['updated_at'].present? ? row['updated_at'].to_datetime : Time.now

  SeatClassChoice.create({
                           name: row['name'],
                           created_at: created_at,
                           updated_at: updated_at
                         })
end