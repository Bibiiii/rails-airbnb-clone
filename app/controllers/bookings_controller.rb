class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_animal, only: [:new, :create]
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  # def destroy
  #   @booking = Booking.find(params[:id])
  #   @booking.active? = false
  # end

  # def new
  #   @booking = Booking.new
  # end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.animal = @animal
    @booking.accepted = false
    @booking.save
    redirect_to booking_path(@booking)
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
