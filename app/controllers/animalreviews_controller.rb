class AnimalreviewsController < ApplicationController
  before_action :set_animal, only: [:index, :new, :show, :create, :edit]

  def index
    @animalreviews = Animalreview.all
  end

  def show
    @animalreview = Animalreview.find(params[:id])
  end

  def new
    @animalreview = Animalreview.new
  end

  def create
    @animalreview = Animalreview.new(animal_review_params)
    @animalreview.animal = @animal
    if @animalreview.save
      redirect_to animal_path(@animal)
    else
      render :new
    end
  end

  def edit
    @animalreview = Animalreview.find(params[:id])
  end

  def update
     @animalreview = Animalreview.find(params[:id])
    if @animalreview.update(animal_review_params)
      redirect_to animal_path(@animal)
    else
      render :new
    end
  end


  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def animal_review_params
    params.require(:animalreview).permit(:comment, :rating)
  end

end
