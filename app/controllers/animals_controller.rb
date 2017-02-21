class AnimalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:query].blank?
      @animals = Animal.all
    else
      @animals = Animal.where('species ILIKE ?', "%#{params[:query]}%")
    end
  end

  def new
    @animal = Animal.new
  end

  def show
    @animal = Animal.find(params[:id])
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
