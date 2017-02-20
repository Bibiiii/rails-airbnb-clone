class AnimalsController < ApplicationController

  def index
    if params[:query].blank?
      @animals = Animal.all
    else
      @animals = Animal.where('name ILIKE ?', "%#{params[:query]}%")
    end

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
      redirect_to animal_path(animal)
    else
      render :new
    end

  end
end

private

  def animal_params
    params.require(:animal).permit(:name, :bio, :price, photos: [])
  end


end
