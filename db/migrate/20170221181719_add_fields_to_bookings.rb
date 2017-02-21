class AddFieldsToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :animal_review, :text
    add_column :bookings, :animal_rating, :integer
    add_column :bookings, :renter_review, :text
    add_column :bookings, :renter_rating, :integer
  end
end
