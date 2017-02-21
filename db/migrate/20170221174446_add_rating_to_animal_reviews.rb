class AddRatingToAnimalReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :animalreviews, :rating, :integer
  end
end
