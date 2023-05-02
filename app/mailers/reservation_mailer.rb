class ReservationMailer < ApplicationMailer
  def new_reservation_email
    @reservation = params[:reservation]

    mail(to: @reservation.user.email, subject: 'Test email')
  end
end
