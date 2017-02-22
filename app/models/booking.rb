class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :animal_rating, inclusion: { in: [1,2,3,4,5], allow_nil: true }
end

