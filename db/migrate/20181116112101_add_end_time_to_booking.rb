class AddEndTimeToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :end_time, :datetime
  end
end
