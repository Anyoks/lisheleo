class CreateBookingActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_activities, id: :uuid do |t|
      t.string :description
      t.uuid :activity_id, foreign_key: true
      t.uuid :booking_id, foreign_key: true

      t.timestamps
    end
  end
end
