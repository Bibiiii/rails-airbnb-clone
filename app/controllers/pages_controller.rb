class PagesController < ApplicationController
  def home
    @user = current_user
    @animals = Animal.all
  end
end
