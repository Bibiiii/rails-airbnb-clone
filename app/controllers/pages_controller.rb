class PagesController < ApplicationController
  def home
    @user = current_user
    @species = Species.all
    @animals = Animal.all
    # @bookings = @user.bookings
  end
end
