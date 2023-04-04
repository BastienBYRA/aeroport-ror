json.extract! reservation, :id, :seat_number, :code, :user_id, :flight_id, :seat_class_choice_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
