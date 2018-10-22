class CreateFailedSmsBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :failed_sms_bookings, id: :uuid do |t|
      t.string :phone_number
      t.string :message

      t.timestamps
    end
  end
end
