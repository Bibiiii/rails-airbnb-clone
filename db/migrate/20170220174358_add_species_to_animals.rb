class AddSpeciesToAnimals < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :species, :string
  end
end
