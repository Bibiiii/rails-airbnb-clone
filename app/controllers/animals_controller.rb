class AnimalsController < ApplicationController

  before_action :set_user, only: [:new, :create]

  def index
    if params[:query].blank?
      @animals = Animal.all
    else
      @animals = Animal.where('name ILIKE ?', "%#{params[:query]}%")
    end
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user = @user
    if @animal.save
      redirect_to animal_path(animal)
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def animal_params
    params.require(:animal).permit(:name, :bio, :price, photos: [])
  end

end
