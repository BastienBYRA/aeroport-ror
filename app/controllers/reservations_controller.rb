class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    # Affiche toutes les reservations de l'utilisateur courant
    if current_user
      @reservations = Reservation
                        .where(user_id: current_user.id)
                        .order(:created_at)
                        .page(params[:page] || 1)
    end

  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    # SEUL un utilisateur identifié peut effectuer une réservation
    if !user_signed_in?
      redirect_to new_user_session_path
    end

    @reservation = Reservation.new

    # Si le flight existe pas, renvoie à la page principal
    flight_exist = Flight.exists?(params[:flight_id])
    if flight_exist == false
      redirect_to controller: :flights, action: :index
    end

    if current_user
      @reservation.user_id = current_user.id

      # Verifie si une reservation existe déja, auquel cas, on le renvoie sur le detail de sa réservation
      already_reservation = Reservation.find_by(user_id: current_user.id, flight_id: params[:flight_id])
      if already_reservation.present?
        redirect_to controller: :reservations, action: :edit, id: already_reservation.id and return
      end
    end


    @flight = Flight.find(params[:flight_id])
    @reservation.flight_id = params[:flight_id]
    @all_seat_class_choice = SeatClassChoice.all

    # Récupère le nombre de sièges max
    seat_class_choose_exist = SeatClassChoice.exists?(params[:seat_class_choice_id])
    @current_nb_seat = 1
    @max_seat = 99
    @selected_class_seat = 0

    if seat_class_choose_exist != false
      seat_class_choose = SeatClassChoice.find(params[:seat_class_choice_id])

      # Si l'utilisateur à changer la classe de voyage
      @max_seat = @flight.getMaxAvailableSeats(seat_class_choose.name)
      @selected_class_seat = seat_class_choose.id

    else
      default_seat_class = SeatClassChoice.first
      @max_seat = @flight.getMaxAvailableSeats(nil)
      @selected_class_seat = default_seat_class.id
    end

    # Récupère le nombre de sièges selectionné par l'utilisateur avant refresh de la page
    if params[:nb_seat] != nil && params[:nb_seat].to_i > 0
      @current_nb_seat = (params[:nb_seat].to_i  > @max_seat) ? @max_seat : params[:nb_seat].to_i
    end

  end

  # GET /reservations/1/edit
  def edit

    # Si la reservation existe pas, renvoie à la page principal
    reservation_exist = Reservation.exists?(params[:id])
    if reservation_exist == false
      redirect_to controller: :reservations, action: :index
    end

    @reservation = Reservation.find(params[:id])
    @flight = Flight.find(@reservation.id)
    @all_seat_class_choice = SeatClassChoice.all

    # Récupère le nombre de sièges max
    seat_class_choose_exist = false
    if params[:seat_class_choice_id] != nil
      seat_class_choose_exist = SeatClassChoice.exists?(params[:seat_class_choice_id])
    end

    @current_nb_seat = @reservation.seat_number
    @max_seat = 99
    @selected_class_seat = 0
    if seat_class_choose_exist != false
      seat_class_choose = SeatClassChoice.find(params[:seat_class_choice_id])

      # Si l'utilisateur à changer la classe de voyage
      @max_seat = @flight.getMaxAvailableSeats(seat_class_choose.name)
      @selected_class_seat = seat_class_choose.id

    else
      default_seat_class = SeatClassChoice.find(@reservation.seat_class_choice_id)
      @max_seat = @flight.getMaxAvailableSeats(default_seat_class.name)
      @selected_class_seat = default_seat_class.id
    end

    # Récupère le nombre de sièges selectionné par l'utilisateur avant refresh de la page
    if params[:nb_seat] != nil && params[:nb_seat].to_i > 0
      @current_nb_seat = (params[:nb_seat].to_i  > @max_seat) ? @max_seat : params[:nb_seat].to_i
    end

  end

  # POST /reservations or /reservations.json
  def create

    # SEUL un utilisateur identifié peut effectuer une réservation
    unless current_user
      redirect_to new_user_session_path and return
    end

    @reservation = Reservation.new(reservation_params)
    @reservation.code = SecureRandom.hex(3)

    respond_to do |format|
      if @reservation.save
        #Envoyer un email de confirmation de réservation
        ReservationMailer.with(reservation: @reservation).new_reservation_email.deliver_later

        format.html { redirect_to reservations_path notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update

    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservations_path, notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:seat_number, :code, :user_id, :flight_id, :seat_class_choice_id)
    end
end
