class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    unless params[:start].empty? || params[:end].empty?
      @animals = Animal.search_animal(params[:species], Date.parse(params[:start]), Date.parse(params[:end]), params[:location], params[:radius])
    else
      @animals = Animal.search_animal(params[:species], params[:start], params[:end], params[:location], params[:radius])
    end

    @species_list = @animals.map { |animal| animal.species.name }.uniq
    @species_list.unshift("All animals")

    @hash = Gmaps4rails.build_markers(@animals) do |animal, marker|
      marker.lat animal.latitude
      marker.lng animal.longitude
      marker.infowindow render_to_string(partial: "users/map_box", locals: { animal: animal })
    end
  end

  def new
    @animal = Animal.new
  end

  def show
    @animal = Animal.find(params[:id])
    @animals = [@animal]
    @hash = Gmaps4rails.build_markers(@animals) do |animal, marker|
      marker.lat animal.latitude
      marker.lng animal.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end

    # Already booked dates are greyed out
    @taken_dates = []
    Booking.all.each do |booking|
      if booking.animal == @animal

        (booking.start_date..booking.end_date).each do |date|
          @taken_dates << date.strftime("%Y-%m-%d")
        end

      end
    end

    @bookings = review_list

    @booking = Booking.new
  end

  def review_list
    bookings = []

    Booking.all.each do |booking|
      bookings << booking if booking.animal == @animal
    end
    return bookings
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user = current_user
    if @animal.save
      redirect_to animal_path(@animal)
    else
      render :new
    end
  end

  def edit
    @animal = Animal.find(params[:id])
    redirect_to animal_path(@animal) unless @animal.user == current_user
  end

  def update
    @animal = Animal.find(params[:id])

    if @animal.update(animal_params)
      redirect_to animal_path(@animal)
    else
      render :new
    end
  end

private

def animal_params
  params.require(:animal).permit(:name, :bio, :species_id, :price, :location, photos: [])
end
end
