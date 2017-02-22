class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_animal, only: [:new, :create]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])

    if Time.now > @booking.end_date && @booking.animal_rating.nil? && @booking.user == current_user # && @booking.accepted ADD THIS FOR COMPLETION
      @animal_review_needed = true
    else
      @animal_review_needed = false
    end

  end

  def update
    @booking = Booking.find(params[:id])

    @booking.animal_rating = params[:booking][:animal_rating]
    @booking.animal_review = params[:booking][:animal_review]

    if @booking.save
      redirect_to animal_path(@booking.animal)
    else
      render :new
    end
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

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
