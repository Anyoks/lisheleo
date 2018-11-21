class AddIndexToBooking < ActiveRecord::Migration[5.1]
  def change
    add_index :bookings, [:time, :program_id]
  end
end
