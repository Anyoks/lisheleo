class AddProgramToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :program_id, :integer, foreign_key: true
  end
end
