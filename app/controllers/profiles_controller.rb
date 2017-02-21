class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
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

  private

  def def profile_params
    params.require(:user).permit(:username, :bio, :photo, :first_name, :last_name, :email)
  end

end
