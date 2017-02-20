class AddColumnsToAnimals < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :bio, :string
    add_column :animals, :price, :integer
  end
end
