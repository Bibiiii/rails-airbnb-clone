class AddAttributesToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :start_date, :date
    add_column :bookings, :end_date, :date
    add_column :bookings, :accepted, :boolean
  end
end
