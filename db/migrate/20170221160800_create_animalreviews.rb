class CreateAnimalreviews < ActiveRecord::Migration[5.0]
  def change
    create_table :animalreviews do |t|
      t.text :comment
      t.references :user, foreign_key: true
      t.references :animal, foreign_key: true

      t.timestamps
    end
  end
end
