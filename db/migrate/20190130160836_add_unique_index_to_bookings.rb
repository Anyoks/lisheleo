class AddUniqueIndexToBookings < ActiveRecord::Migration[5.1]
  def change
    add_index :bookings, [:time, :client_id, :program_id], unique: true
  end
end
