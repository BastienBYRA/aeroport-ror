class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :flight
  belongs_to :seat_class_choice
end
