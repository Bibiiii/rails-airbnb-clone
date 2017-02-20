class CreateAnimals < ActiveRecord::Migration[5.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
