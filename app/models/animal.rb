class Animal < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :name, presence: true
  validates :species, inclusion: { in: ["Spider", "Snake", "Elephant", "T-Rex", "Unicorn", "Centaur", "Great-White Shark", "Achilles son of God"]}
  has_attachments :photos, maximum: 4
end
