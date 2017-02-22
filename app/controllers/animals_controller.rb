class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    # if params[:species].blank?
      # @animals = Animal.all
    # else
    #   species = Species.find(params[:species])
    #   @animals = Animal.where(species: species)
    # end
    @animals = Animal.search_animal(params[:species], Date.parse(params[:start]), Date.parse(params[:end]), params[:location])
  end

  def new
    @animal = Animal.new
  end

  def show
    @animal = Animal.find(params[:id])
    @booking = Booking.new
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
  params.require(:animal).permit(:name, :bio, :species_id, :price, photos: [])
end
end
