class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_animal, only: [:new, :create]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])

    if Time.now > @booking.end_date # && @booking.accepted ADD THIS FOR COMPLETION
      if @booking.animal_rating.nil? && @booking.user == current_user
        @animal_review_needed = true
      else
        @animal_review_needed = false
      end

      if @booking.renter_rating.nil? && @booking.animal.user == current_user
        @renter_review_needed = true
      else
        @renter_review_needed = false
      end
    end

  end

  def update
    @booking = Booking.find(params[:id])

    @booking.animal_rating = params[:booking][:animal_rating] if @booking.animal_rating.nil?
    @booking.animal_review = params[:booking][:animal_review] if @booking.animal_review.nil?

    @booking.renter_rating = params[:booking][:renter_rating] if @booking.renter_rating.nil?
    @booking.renter_review = params[:booking][:renter_review] if @booking.renter_review.nil?

    if @booking.save
      redirect_to root_path
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
