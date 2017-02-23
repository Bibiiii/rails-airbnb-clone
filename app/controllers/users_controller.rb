class UsersController < ApplicationController

  before_action :set_user

  def index
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
