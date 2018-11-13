class CreateAvailableTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :available_times do |t|
      t.string :day
      t.time :start_time
      t.time :end_time

      t.integer :program_id, foreign_key: true

      t.timestamps
    end
  end
end
