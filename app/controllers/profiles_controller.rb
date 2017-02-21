class ProfilesController < ApplicationController
before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def my_bookings
    @user = current_user

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.username = params[:user][:username]
    @user.bio = params[:user][:bio]
    @user.photo = params[:user][:photo]


    if @user.save
      redirect_to profile_show_path(@user)
    else
      render :new
    end
  end
end
