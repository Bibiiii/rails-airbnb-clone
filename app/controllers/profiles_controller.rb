class ProfilesController < ApplicationController
before_action :authenticate_user!, only: [:edit, :update]

  def my_profile
    @user = current_user

    @bookings = review_list
  end

  def review_list
    bookings = []

    Booking.all.each do |booking|
      bookings << booking if booking.user == @user
    end
    return bookings
  end

  def show
    @user = User.find(params[:id])
    @bookings = review_list
  end

  def my_bookings
    @user = current_user
  end

  def my_requests
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.username = params[:user][:username]
    @user.bio = params[:user][:bio]
    @user.photo = params[:user][:photo]


    if @user.save
      redirect_to my_profile_path
    else
      render :new
    end
  end
end
