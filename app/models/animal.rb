class Animal < ApplicationRecord
  belongs_to :user
  belongs_to :species
  has_many :bookings
  has_many :animalreviews
  validates :name, presence: true
  validates :species, presence: true
  has_attachments :photos, maximum: 4
end
