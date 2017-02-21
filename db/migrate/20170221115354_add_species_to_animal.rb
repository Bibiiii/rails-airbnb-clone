class AddSpeciesToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_reference :animals, :species, foreign_key: true
  end
end
