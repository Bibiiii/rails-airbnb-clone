class AddDateToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :location, :string
  end
end
