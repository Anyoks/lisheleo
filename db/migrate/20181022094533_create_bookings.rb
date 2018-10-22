class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings, id: :uuid do |t|
      t.datetime :time
      t.date :date
      t.string :description
      t.boolean :status, default: false
      t.string :confirm_status
      t.uuid  :client_id, foreign_key: true
      t.uuid  :sms_id, foreign_key: true

      t.timestamps
    end
  end
end
