class CreateFailedBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :failed_bookings, id: :uuid do |t|
      t.string :phone_number
      t.string :message
      t.uuid :sms_id, foreign_key: true

      t.timestamps
    end
  end
end
