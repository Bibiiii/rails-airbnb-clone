class Species < ApplicationRecord
  has_many :animals

  validates :name, presence: true, uniqueness: true
end
