class Animal < ApplicationRecord
  belongs_to :user
  belongs_to :species
  has_many :bookings
  validates :name, presence: true
  has_attachments :photos, maximum: 4
end
