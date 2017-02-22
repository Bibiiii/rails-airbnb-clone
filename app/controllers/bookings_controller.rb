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
    if @animal.available_for_booking?(@booking.start_date, @booking.end_date)
      @booking.user = current_user
      @booking.animal = @animal
      @booking.accepted = false
      @booking.save
      flash[:title] = 'Success!'
      flash[:notice] = 'Success! You have booked ' + @animal.name
      redirect_to booking_path(@booking)
    else
      flash[:title] = 'Error!'
      flash[:notice] = "Sorry - " + @animal.name + " is already booked on this day"
      render 'animals/show'
    end
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  # def booking_valid?(booking)
  #   (booking.start_date..booking.end_date).all? do |date|
  #     @animal.bookings.all? do |booking|
  #       !(booking.start_date..booking.end_date).include?(date)
  #     end
  #   end
  # end
end
