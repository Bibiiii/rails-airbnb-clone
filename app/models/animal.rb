class Animal < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
  belongs_to :user
  belongs_to :species
  has_many :bookings
  validates :name, presence: true
  validates :species, presence: true
  has_attachments :photos, maximum: 4

  def self.search_animal(species, start_date, end_date, location, radius)
    # Species
    species_name = Species.find(species)
    if species_name.name == "All animals"
      animals_by_species = Animal.all
    else
      animals_by_species = Animal.where(species: species_name)
    end

    # Dates
    unless start_date.nil? || end_date.nil?
      animals_by_species_dates = animals_by_species.select do |animal|
        animal.available_for_booking?(start_date, end_date)
      end
    else
      animals_by_species_dates = animals_by_species
    end

    # Location
    unless location.empty? || radius.empty?
      animals_by_species_dates_location = []
      Animal.near(location, radius).each do |animal|
        animals_by_species_dates_location << animal if animals_by_species_dates.include?(animal)
      end
    else
      animals_by_species_dates_location = animals_by_species_dates
    end

    return animals_by_species_dates_location
  end

  def available_for_booking?(start_date, end_date)
    (start_date..end_date).all? do |date|
      self.bookings.all? do |booking|
        !(booking.start_date..booking.end_date).include?(date)
      end
    end
  end
end
