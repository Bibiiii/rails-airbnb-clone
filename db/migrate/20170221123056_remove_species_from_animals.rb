class RemoveSpeciesFromAnimals < ActiveRecord::Migration[5.0]
  def change
    remove_column :animals, :species, :string
  end
end
