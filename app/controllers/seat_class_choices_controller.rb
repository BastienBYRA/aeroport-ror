class SeatClassChoicesController < ApplicationController
  before_action :set_seat_class_choice, only: %i[ show edit update destroy ]

  # GET /seat_class_choices or /seat_class_choices.json
  def index
    @seat_class_choices = SeatClassChoice.all
  end

  # GET /seat_class_choices/1 or /seat_class_choices/1.json
  def show
  end

  # GET /seat_class_choices/new
  def new
    @seat_class_choice = SeatClassChoice.new
  end

  # GET /seat_class_choices/1/edit
  def edit
  end

  # POST /seat_class_choices or /seat_class_choices.json
  def create
    @seat_class_choice = SeatClassChoice.new(seat_class_choice_params)

    respond_to do |format|
      if @seat_class_choice.save
        format.html { redirect_to seat_class_choice_url(@seat_class_choice), notice: "Seat class choice was successfully created." }
        format.json { render :show, status: :created, location: @seat_class_choice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @seat_class_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seat_class_choices/1 or /seat_class_choices/1.json
  def update
    respond_to do |format|
      if @seat_class_choice.update(seat_class_choice_params)
        format.html { redirect_to seat_class_choice_url(@seat_class_choice), notice: "Seat class choice was successfully updated." }
        format.json { render :show, status: :ok, location: @seat_class_choice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @seat_class_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seat_class_choices/1 or /seat_class_choices/1.json
  def destroy
    @seat_class_choice.destroy

    respond_to do |format|
      format.html { redirect_to seat_class_choices_url, notice: "Seat class choice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seat_class_choice
      @seat_class_choice = SeatClassChoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def seat_class_choice_params
      params.require(:seat_class_choice).permit(:name)
    end
end
