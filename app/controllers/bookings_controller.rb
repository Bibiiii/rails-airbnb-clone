class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_animal, only: [:new, :create, :requests]
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])

    if Time.now > @booking.end_date && @booking.accepted
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

    # Reset @___review_needed variables to false?
    if @booking.save
      redirect_to animal_path(@animal)
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

  def accept
    @booking = Booking.find(params[:id])
    @booking.accepted = true
    @booking.save
    redirect_to my_requests_path
  end

  def create
    # could add that users can't book their own animal?
    @booking = Booking.new(booking_params)
    if @booking.start_date < @booking.end_date && @booking.start_date > Time.now
      if @animal.available_for_booking?(@booking.start_date, @booking.end_date)
        @booking.user = current_user
        @booking.animal = @animal
        @booking.accepted = false

        # Making sure the user isn't booking their own animal
        unless @booking.user == @booking.animal.user
          @booking.save
          flash[:title] = 'Success!'
          flash[:notice] = 'Success! You have booked ' + @animal.name
          redirect_to booking_path(@booking)
        else
          flash[:title] = "Error!"
          flash[:notice] = "You can't book your own animal"
          render 'animals/show'
        end

      else
        flash[:title] = 'Error!'
        flash[:notice] = "Sorry - " + @animal.name + " is already booked on this day"
        render 'animals/show'
      end

    # All do similar things just display different messages for different errors
    elsif @booking.start_date < Time.now
      flash[:title] = "Error!"
      flash[:notice] = "You can't book in the past"
      render 'animals/show'
    elsif @booking.start_date > @booking.end_date
      flash[:title] = "Error!"
      flash[:notice] = "The start date can't be before the end date"
      render 'animals/show'
    else # This condition will probably never be met. Should always be true on other conditions
      flash[:title] = "Error!"
      flash[:notice] = "Unknown Error"
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
