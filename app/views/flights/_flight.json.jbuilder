json.extract! flight, :id, :number, :departure_airport, :arrival_airport, :business_class_seats, :economy_class_seats, :departure_date, :duration, :created_at, :updated_at
json.url flight_url(flight, format: :json)
