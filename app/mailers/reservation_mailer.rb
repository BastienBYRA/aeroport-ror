class ReservationMailer < ApplicationMailer
  def new_reservation_email
    @reservation = params[:reservation]

    mail(to: 'kefeho5924@syinxun.com', subject: 'Test email')
  end
end
