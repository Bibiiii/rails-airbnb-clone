class AddLikesAndJobToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :likes, :text
    add_column :users, :job, :string
  end
end
