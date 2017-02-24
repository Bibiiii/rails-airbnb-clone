class PagesController < ApplicationController
  def home
    @user = current_user
    @species = Species.all
    @animals = Animal.all
    @species_list = @animals.map { |animal| animal.species.name }.uniq
    @species_list.unshift("All animals")
    @start_date = Date.today() + 1.days
    @end_date = Date.today() + 8.days
    @featured_animals = []
    calculate_featured_animals
    @col_size = 12/@featured_animals[0..2].length unless @featured_animals.length == 0


    # @bookings = @user.bookings
  end

private

def calculate_featured_animals
  @animals.each { |animal| animal.available_for_booking?(@start_date, @end_date) ? @featured_animals << animal : animal }
end


end
