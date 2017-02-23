class ChangeDateTypeForBio < ActiveRecord::Migration[5.0]
  def change
    change_table :animals do |t|
      t.change :bio, :text
    end
  end
end
