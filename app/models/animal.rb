class Animal < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
  belongs_to :user
  belongs_to :species
  has_many :bookings
  validates :name, presence: true
  validates :species, presence: true
  has_attachments :photos, maximum: 4

  def self.search_animal(species, start_date, end_date, location)
    species_name = Species.find(species)
    if species_name.name == "All animals"
      animals_by_species = Animal.all
    else
      animals_by_species = Animal.where(species: species_name)
    end
    animals_by_species_dates = animals_by_species.select do |animal|
      animal.available_for_booking?(start_date, end_date)
    end
    return animals_by_species_dates
  end

  def available_for_booking?(start_date, end_date)
    (start_date..end_date).all? do |date|
      self.bookings.all? do |booking|
        !(booking.start_date..booking.end_date).include?(date)
      end
    end
  end

  LOGOS = {
    'snail' => '🐌',
    'snake' => '🐍',
    'horse' => '🐎',
    'sheep' => '🐑',
    'monkey' => '🐒',
    'chicken' => '🐔',
    'boar' => '🐗',
    'elephant' => '🐘',
    'octopus' => '🐙',
    'bug' => '🐛',
    'ant' => '🐜',
    'honeybee' => '🐝',
    'ladybird' => '🐞',
    'fish' => '🐠',
    'blowfish' => '🐡',
    'turtle' => '🐢',
    'chick' => '🐥',
    'bird' => '🐦',
    'penguin' => '🐧',
    'koala' => '🐨',
    'poodle' => '🐩',
    'camel' => '🐫',
    'dolphin' => '🐬',
    'mouse' => '🐭',
    'cow' => '🐮',
    'tiger' => '🐯',
    'rabbit' => '🐰',
    'cat' => '🐱',
    'dragon' => '🐲',
    'whale' => '🐳',
    'horse' => '🐴',
    'monkey' => '🐵',
    'dog' => '🐶',
    'pig' => '🐷',
    'frog' => '🐸',
    'hamster' => '🐹',
    'wolf' => '🐺',
    'bear' => '🐻',
    'panda' => '🐼'
  }
end
