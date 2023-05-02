# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def new_reservation_email
    # Set up a temporary order for the preview
    reservation = Reservation.new(seat_number: 10, user_id: 1, flight_id: 2, seat_class_choice_id: 3)

    ReservationMailer.with(reservation: reservation).new_reservation_email
  end
end
