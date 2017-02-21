class DropAnimalreviews < ActiveRecord::Migration[5.0]
  def change
    drop_table :animalreviews
  end
end
