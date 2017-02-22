class Animal < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
  belongs_to :user
  belongs_to :species
  has_many :bookings
  validates :name, presence: true
  validates :species, presence: true
  has_attachments :photos, maximum: 4
end
