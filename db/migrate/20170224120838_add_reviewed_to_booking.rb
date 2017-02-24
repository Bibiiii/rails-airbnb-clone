class AddReviewedToBooking < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :reviewed, :boolean
  end
end
